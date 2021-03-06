# ToDoRTA
ToDoアプリRTA用

# レギュレーション

## 計測開始の前提条件
* homebrewインストール済
* Android Studio, Xcodeがインストール済
* Android StudioのFlutterプラグインがインストール済
* anyenv > rbenv環境構築済
* direnv環境構築済
* gitのuser.name, user.emailが設定済
* README.md, .gitignore以外のファイルがディレクトリ内に存在しないこと
* gcloud, firebaseコマンド, aws-cli等のログインが完了していても良い(プロジェクトやインスタンスが計測前に作成されているのはNG)

## コーディングにおける制約
* pub.devに公開されているライブラリは自由に使うことができる
* gistにて公開されているclassやextensionなどは自由に使用可能とする。ただし、このRTAの仕様専用とみなされるものは不可。
* 永続化の手段について問わない

## Definition of Done (完了の定義)
* AndoridシミュレータのPixel 3でE2Eテストシナリオを満たしていること
* ソースコードがgithubにpushされていること
* 上記を満たした時点でタイマーストップ

## 仕様書Lv1
* いわゆるToDoアプリ
* ToDoの単位は「タスク」と呼ぶ
* タスクには「本文」「登録した日時」のみがある
* タスクを新規に追加できること
* 記録したタスクを一覧できること
  * 一覧の各項目では本文の冒頭および登録した日時がわかること。
* 記録したタスクを編集できること
* タスクを削除できること
* 永続化できること

## テストシナリオ
0. (初回)アプリを起動
1. > 一覧に何も表示されていないこと
2. タスクを追加する
  * タスクを追加する機能が、一目見てわかること
3. > 追加したタスクが一覧に表示されていること
4. もう一つタスクを追加する
5. > 2と4で追加したタスクが追加した順に上から一覧表示されていること
6. アプリをキルする(バックグラウンド化ではない)
7. アプリを起動する
1. > アプリキルする前の状態と同じ表示であること
1. 2で追加したタスクを編集する
1. > 編集のUIについては問わない。
1. 2で追加したタスクを削除する
  * 削除のUIについては問わない。確認操作は不要。
1. > 4で追加したタスクだけが一覧で表示されていること
1. 4で追加したタスクを削除する
1. > 一覧に何も表示されていないこと

# 非機能要件
* テストシナリオにおいてクラッシュしないこと
