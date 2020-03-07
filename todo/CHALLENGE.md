# 1時間24分

# Firebase Auth(Anonymous) + Firestore
# firestore_ui

# セクション1

flutter create todo
git commit

# セクション2

firebase projects:create todo
firebase init
firebase apps:create --package-name com.example.todo ANDROID todo
表示されたURLで
firebase apps:sdkmanager ... でgoogle-service.jsonをandroid/appにダウンロード
firestore.rulesに`allow read write: if request.auth.uid != null;`追加

build.gradle編集
app/build.gradle編集（multiDexEnabled true, apply plugin: 'com.google.gms.google-services')


# セクション3
* pubspec.yamlにfirestore_ui, firebase_authを追加
* コーディング開始
