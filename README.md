# B_2121_client

サーバサイドは[こちら](https://github.com/jphacks/B_2121_server)

## Required Dependency

- **Cocoa Pods** — https://guides.cocoapods.org/using/getting-started.html

## Getting Started

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

`You don't have write permissions for the /Library/Ruby/Gems/2.6.0 directory` などと怒られる時は、`sudo` をつける。

Install Dependencies:

```zsh
$ pod install
```

Open Workspace

```zsh
$ open goyotashi.xcworkspace
```
