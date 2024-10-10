# QuickNote
Sinatraによってlocalhost上で実行できるメモアプリです。メモアプリとして、メモの作成・閲覧・編集・削除などの基本的な機能を備えています。

# 目次
- [デモ動画](#デモ動画)
- [動作要件](#動作要件)
- [導入方法](#導入方法)
- [使用方法](#使用方法)
  - [アプリの起動](#アプリの起動)
  - [メモの新規作成](#メモの新規作成)
  - [メモの閲覧](#メモの閲覧)
  - [メモの編集](#メモの編集)
  - [メモの削除](#メモの削除)

# デモ動画
![quicknote_demo](https://github.com/user-attachments/assets/bb41ed7b-8b76-4bfb-a5fc-0b7f6881ab5a)

# 動作要件
実行には、Gemで以下のファイルが必要
* sinatra
* sinatra-contrib

# 導入方法
1. 以下のコマンドでリポジトリをクローンする
```bash
git clone -b develop https://github.com/lsesmpmido/sinatra-practice.git
```

2. クローンしたリポジトリ内にディレクトリを移動
```bash
cd sinatra-practice
```

3. Bundlerを初期化
```bash
bundle init
```

4. 初期化後に作成されるGemfileに以下の内容を記入
```gemfile
# frozen_string_literal: true

source "https://rubygems.org"

gem "sinatra"
gem "sinatra-contrib"
```
5. Gemfileの内容を保存し、以下の操作で必要なGemをインストール
```bash
bundle install
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

<img src="https://github.com/user-attachments/assets/c930f4a4-ec8f-4d73-aed0-15ac50c56ff4" width="50%">

2. 「ここにメッセージを入力」の欄にメモをしたい内容を記入する

<img src="https://github.com/user-attachments/assets/1a2484fc-d277-40fd-8406-91f01b8d4408" width="50%">

3. 「保存ボタン」を押すと、メモの内容を保存することができる

<img src="https://github.com/user-attachments/assets/259edc17-1a2d-493d-b7b4-36480e84c06b" width="50%">


## メモの閲覧
1. [ホーム画面](http://localhost:4567/quicknote)に移動し、閲覧したいメモを選択

<img src="https://github.com/user-attachments/assets/a5d7bc84-772d-4a64-8087-d9b92b351baf" width="50%">

2. 選択すると画像のようにメモの内容を確認することができる

<img src="https://github.com/user-attachments/assets/0401ac68-e794-43e8-bb81-c917636c3c5d" width="50%">


## メモの編集
1. [ホーム画面](http://localhost:4567/quicknote)に移動し、編集したいメモを選択

<img src="https://github.com/user-attachments/assets/a5d7bc84-772d-4a64-8087-d9b92b351baf" width="50%">

2. 「編集ボタン」を選択する

<img src="https://github.com/user-attachments/assets/e894faf5-f3fe-4a59-a945-9aae80cba475" width="50%">

3. テキストを選択し、メモの編集を行う

<img src="https://github.com/user-attachments/assets/2e3092aa-3501-4846-8969-aecd6a7b6138" width="50%">

4. 「保存ボタン」を押すと、編集したメモの内容を保存することができる

<img src="https://github.com/user-attachments/assets/1a4904f4-6efd-43dd-a5f2-38e096f8d175" width="50%">

## メモの削除
1. [ホーム画面](http://localhost:4567/quicknote)に移動し、削除したいメモを選択

<img src="https://github.com/user-attachments/assets/a5d7bc84-772d-4a64-8087-d9b92b351baf" width="50%">

2. 「削除ボタン」を選択する

<img src="https://github.com/user-attachments/assets/6c834fe8-8ce6-47a2-a6b3-448815acc406" width="50%">

3. 自動で[ホーム画面](http://localhost:4567/quicknote)に遷移し、実際に選択したメモが消えていることが確認できる

<img src="https://github.com/user-attachments/assets/95458f21-f721-4567-97f8-08ad6a836ad6" width="50%">
