# goyotashi - クライアントサイド (B_2121_client)

サーバサイドは[こちら](https://github.com/jphacks/B_2121_server)

## ドキュメントなど
[server side Wiki](https://github.com/jphacks/B_2121_server/wiki)  
[client side Wiki](https://github.com/jphacks/B_2121_client/wiki)

[発表資料](https://docs.google.com/presentation/d/1oU93MItpDkqEni_x4t5PMh3QPij3ZHZhbPva-IOwYPQ/)

<img src="https://user-images.githubusercontent.com/44559810/139521245-ca0d4cfd-e5fc-422b-9c40-3ffaadca06a0.png" alt="goyotashi-LPicture" width="100%">
<p align="center">
<div style="display:flex">
  <img style="flex-grow:1" src="https://gyazo.com/5a83d324e5bb8d6230770784bb826e30.gif" width="49%">
  <img style="flex-grow:1" src="https://gyazo.com/48635363b4836a78fa7fe7753bfe6644.gif" width="49%">
</div>
</p>

【画像提供：ホットペッパー グルメ】

## 製品概要

### eat\*Tech
グループでよく行く飲食店のリストを共有する *eat\*Tech*（消費者の食行動\*Tech）SNS 「**goyotashi**」

### 背景(製品開発のきっかけ、課題等）
グループや個人で飲食店に行くとき、「どこでもいい」と言いながら決まらないという面倒な問題がある。  
人は既知の飲食店から行き先を選ぶ際、無意識によく行く飲食店リストを思い出そうとし、これでもない、あれでもないと悩む。  
そんなときに見る便利なリストが欲しかった。
実際にユーザーにインタビューをしたところ、以下のような意見が得られた。

<img width="100%" alt="ユーザーインタビュー" src="https://user-images.githubusercontent.com/44559810/139523305-718f9156-bab7-409e-9a11-0765ba102e28.png">


### 製品説明（具体的な製品の説明）
定期的にご飯を食べる人達(**グループ**)でよく行くお店リストを集約・可視化し、飲食店選びのコストを下げてくれるiOSアプリ。  
リストはグループ外にも公開され、副作用として他のグループ御用達の、信頼できる飲食店を知ることができる。

<img width="100%" alt="スクリーンショット 2021-10-30 15 02 58" src="https://user-images.githubusercontent.com/44559810/139523279-7355b480-5b8e-4160-97fb-eede0470c650.png">

### 特長
#### 1. グループごとによく行く飲食店リストを作成・共有することで、飲食店選びのコストを下げる！

#### 2. 自分が属していない近くのグループや、似たような嗜好性のグループ御用達の飲食店を見ることで、選択肢が広がる！ 

### 解決出来ること
「どこでもいい」と言いながらも、潜在的には食べたいものの気分がある。  
そんなときに検索に変わるより低コストな手段として、飲食店選びを解決する。

### 今後の展望
グループが公開されることによる副作用をより活かす(ex. グループ・嗜好性情報の拡充)

### 注力したこと（こだわり等）
* 課題の吟味、深掘り
* ユーザーインタビューやユースケースの具体化
* 既存のグルメアプリとの差別化

## 開発技術

サーバサイドは[こちら](https://github.com/jphacks/B_2121_server)

<img width="100%" alt="技術" src="https://user-images.githubusercontent.com/44559810/139523227-3899c64e-99f6-4db2-b05e-656e340392fd.png">


### 活用した技術
* Swift

#### フレームワーク・ライブラリ・モジュール
* SnapKit
* ReactorKit
* RxSwift
* ReusableKit
* SwiftLint

#### デバイス
動作確認済みのデバイスは以下の通りです。
* iPhone12 Pro Max, iOS 15.0

### 独自技術
#### ハッカソンで開発した独自機能・技術
* アプリ、API、BDやAPIの設計、全てこの期間で開発しています

## 手元でビルドする
### Required Dependency

- **Cocoa Pods** — https://guides.cocoapods.org/using/getting-started.html

### Getting Started

⚠️ M1 Mac の場合、「Finder > アプリケーション > ユーティリティ > ターミナル > 情報をみる > Rosetta を使用して開く」
にチェックしてからターミナルアプリを開く（再起動等でチェックが勝手に外れることがあるので注意）。 以下ターミナルアプリで実行する。

Clone Repository:

```zsh
$ git clone git@github.com:jphacks/B_2121_client.git
$ cd B_2121_client
```

Install `cocoapods`:

```zsh
$ gem install cocoapods -v 1.10.1
```

`You don't have write permissions for the /Library/Ruby/Gems/2.6.0 directory` などと怒られる時は、`sudo` をつける。

Install Dependencies:

```zsh
$ pod install
```

Open Workspace

```zsh
$ open goyotashi.xcworkspace
```


Powered by <a href="http://webservice.recruit.co.jp/">ホットペッパー Webサービス</a>
