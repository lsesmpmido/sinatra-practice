# QuickNote
Sinatraによってlocalhost上で実行できるメモアプリです。メモアプリとして、メモの作成・閲覧・編集・削除などの基本的な機能を備えています。

![image](https://github.com/user-attachments/assets/f629abc0-c5bd-4b7e-bb21-4219219c1185)

# 目次
- [動作要件](#動作要件)
- [導入方法](#導入方法)
- [使用方法](#使用方法)
  - [アプリの起動](#アプリの起動)
  - [メモの新規作成](#メモの新規作成)
  - [メモの閲覧](#メモの閲覧)
  - [メモの編集](#メモの編集)
  - [メモの削除](#メモの削除)

# 動作要件
実行には、Gemで以下のファイルが必要
* pg
* rackup
* rexml
* sinatra
* sinatra-contrib

# 導入方法
1. 以下のコマンドでリポジトリをクローンする
```bash
git clone -b develop_use-postgresql https://github.com/lsesmpmido/sinatra-practice.git
```

2. クローンしたリポジトリ内にディレクトリを移動
```bash
cd sinatra-practice
```

3. リポジトリ内のGemfileを使用して以下の操作で必要なGemをインストール
```bash
bundle install
```

# 環境構築

## DBの作成
1. psqlにログインする
```bash
sudo -u postgres psql
```
2. 以下のSQL文でデータベースを新規作成する
```sql
CREATE DATABASE newdb;
```
3. データベースに対するすべての権限を付与
```sql
GRANT ALL PRIVILEGES ON DATABASE newdb TO your_user;
```
4. 作成したデータベース内に入る
```sql
\c newdb;
```
5. 以下のSQL文でテーブルを新規作成する
```sql
CREATE TABLE table_name (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255),
    content TEXT
);
```
6. 作成したテーブルに対して以下の権限を設定
```sql
-- テーブルに対するデフォルト権限を設定
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO your_user;

-- シーケンスに対するデフォルト権限を設定
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE, SELECT ON SEQUENCES TO your_user;
```

## 環境変数の設定
- sqlに接続するために必要な設定を以下のコマンドで環境変数に設定する
  - DB_HOSTのデフォルトは`localhost`
```bash
export DB_NAME='your_db_name'
export DB_USER='your_db_user'
export DB_PASSWORD='your_db_password'
export DB_HOST='your_db_host'
```

# 使用方法

## アプリの起動
1. クローンしたリポジトリ内にディレクトリ内で以下のコマンドを実行
```bash
ruby quicknote.rb
```

2. ブラウザを起動し、http://localhost:4567/ にアクセスすることでアプリ画面を開く

## メモの新規作成
1. [ホーム画面](http://localhost:4567/quicknote)に移動し、「＋アイコン」を選択

<img src="https://github.com/user-attachments/assets/c2d0332f-54f2-4c7f-9825-015c44cde0bb" width="50%">

2. 「ここにタイトルを入力」にメモのタイトルを、「ここにメッセージを入力」の欄にメモの内容を記入する

<img src="https://github.com/user-attachments/assets/8a9970fa-3e79-44fa-8183-4af2d4257a7e" width="50%">

3. 「保存ボタン」を押すと、メモの内容を保存することができる

<img src="https://github.com/user-attachments/assets/b89b8ea8-35aa-4912-8bfa-d8ee94dd6b8a" width="50%">


## メモの閲覧
1. [ホーム画面](http://localhost:4567/quicknote)に移動し、閲覧したいメモを選択

<img src="https://github.com/user-attachments/assets/9b6a33cb-9abf-43a5-994f-f5faeb45bd9b" width="50%">

2. 選択すると画像のようにメモの内容を確認することができる

<img src="https://github.com/user-attachments/assets/5a686756-9db9-47d5-ba03-a0c2af9a5b8a" width="50%">


## メモの編集
1. [ホーム画面](http://localhost:4567/quicknote)に移動し、編集したいメモを選択

<img src="https://github.com/user-attachments/assets/9b6a33cb-9abf-43a5-994f-f5faeb45bd9b" width="50%">

2. 「編集ボタン」を選択する

<img src="https://github.com/user-attachments/assets/e02fc517-eb85-4092-a0c8-98ae64c728fe" width="50%">

3. テキストを選択し、メモの編集を行う

<img src="https://github.com/user-attachments/assets/d2126455-2252-4aa9-9183-632f846fb58a" width="50%">

4. 「保存ボタン」を押すと、編集したメモの内容を保存することができる

<img src="https://github.com/user-attachments/assets/8d1c112b-f00e-4c71-8c38-8cfaa8d8a780" width="50%">

## メモの削除
1. [ホーム画面](http://localhost:4567/quicknote)に移動し、削除したいメモを選択

<img src="https://github.com/user-attachments/assets/9b6a33cb-9abf-43a5-994f-f5faeb45bd9b" width="50%">

2. 「削除ボタン」を選択する

<img src="https://github.com/user-attachments/assets/2c08b173-b931-49c4-9596-7244a30712b9" width="50%">

3. 自動で[ホーム画面](http://localhost:4567/quicknote)に遷移し、実際に選択したメモが消えていることが確認できる

<img src="https://github.com/user-attachments/assets/18dfc2a0-62c1-4319-890b-ffd60ab739eb" width="50%">
