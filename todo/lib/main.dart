import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_ui/firestore_ui.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseAuth.instance.signInAnonymously();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListPage(),
    );
  }
}

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ToDo')),
      floatingActionButton: _buildFloatingActionButton(context),
      body: _buildFirestoreAnimatedList(),
    );
  }

  Widget _buildFirestoreAnimatedList() {
    return FirestoreAnimatedList(
      query: Firestore.instance.collection('todo').snapshots(),
      defaultChild: Text('ToDo List'),
      itemBuilder: (
        BuildContext context,
        DocumentSnapshot snapshot,
        Animation<double> animation,
        int index,
      ) =>
          FadeTransition(
        opacity: animation,
        child: Dismissible(
          resizeDuration: null,
          key: Key(snapshot.documentID),
          onDismissed: (_) async {
            await Firestore.instance.document(snapshot.reference.path).delete();
          },
          child: Card(
            child: ListTile(
              title: Text('${snapshot.data['memo']}'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: context,
          child: _buildDialog(context),
        );
      },
    );
  }

  Center _buildDialog(BuildContext context) {
    final _controller = TextEditingController();
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(labelText: '内容'),
            ),
            StatefulBuilder(builder: (context, setState) {
              _controller.addListener(() {
                setState(() {});
              });
              return RaisedButton(
                child: Text('登録'),
                onPressed: _controller.text.isEmpty
                    ? null
                    : () {
                        if (_controller.text.isNotEmpty) {
                          Firestore.instance.collection('todo').add({
                            'memo': _controller.text,
                          });
                        }
                        Navigator.pop(context);
                      },
              );
            })
          ],
        ),
      ),
    );
  }
}
