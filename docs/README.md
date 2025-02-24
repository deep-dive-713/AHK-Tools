# AHK-Tools

AutoHotkeyを使用したキーボード・マウス操作の拡張ツール群です。

## 目次

- [ディレクトリ構成](#ディレクトリ構成)
- [主な機能](#主な機能)
  - [基本操作](#基本操作)
  - [カーソル移動](#カーソル移動f13--キー)
  - [テキスト編集](#テキスト編集)
  - [検索機能](#検索機能)
  - [アプリケーション固有機能](#アプリケーション固有機能)
    - [Microsoft Office](#microsoft-office)
    - [ブラウザ](#ブラウザ)
    - [その他](#その他)
- [使用方法](#使用方法)

## ディレクトリ構成

| ファイル/ディレクトリ | 説明 |
|-------------------|------|
| AHK-Tools/ ||  
| ├── main.ahk | メインスクリプト |
| ├── src/ | ソースコード |
| │ ├── core/ | コア機能 |
| │ │ ├── version.ahk | バージョン管理 |
| │ │ └── search.ahk | テキスト検索機能 |
| │ ├── apps/ | アプリケーション固有の設定 |
| │ │ ├── browser.ahk | ブラウザ向け設定 |
| │ │ ├── office.ahk | Microsoft Office向け設定 |
| │ │ ├── other_apps.ahk | その他アプリケーション設定 |
| │ │ └── JIS2US.ahk | JIS配列をUS配列に変換 |
| │ ├── shortcuts/ | 共通ショートカット設定 |
| │ &nbsp;&nbsp;&nbsp;&nbsp; ├── cursor_movement.ahk | カーソル移動 |
| │ &nbsp;&nbsp;&nbsp;&nbsp; ├── editing.ahk | テキスト編集 |
| │ &nbsp;&nbsp;&nbsp;&nbsp; ├── mouse_actions.ahk | マウス操作 |
| │ &nbsp;&nbsp;&nbsp;&nbsp; └── symbols.ahk | 記号入力 |
| ├── lib/ | 外部ライブラリ |
| │ └── JSON.ahk | JSON解析ライブラリ |
| ├── logs/ | ログファイル |
| │ ├── debug.log | デバッグログ |
| │ └── error.log | エラーログ |
| ├── config/ | 設定ファイル |
| │ └── setting.ini |  |
| └── docs/ | ドキュメント |
| &nbsp;&nbsp;&nbsp;&nbsp;└── README.ini | ここの説明文 |

## 主な機能

### 基本操作

- F13キーをメインモディファイアとして使用
- CapsLock切り替え（右Shift + F13）
- テキスト検索（Shift + 中クリック）

### カーソル移動（F13 + キー）

- IJKL: 矢印キー相当の移動
- H/;: Home/End（行頭/行末）
- Space: Enter

### テキスト編集

- O/P: バックスペース/削除
- N/M: Page Up/Down

### アプリケーション固有機能

#### Microsoft Office

- Excel: シート切り替え（F13 + ホイール）
- PowerPoint/Word: 左右スクロール（Shift + ホイール）
- OneNote: カスタムスクロールと移動

#### ブラウザ

- タブ切り替え（F13 + ホイール）
- Shiftダブルタップで改行挿入

#### その他

- Notion: ズーム操作（Ctrl + ホイール）
- Mattermost: カスタムズーム

### 検索機能

選択テキストに応じて：

1. URLの場合：ブラウザで開く
2. ローカルパスの場合：エクスプローラーで開く
3. その他の文字列：Google検索を実行

## 使用方法

1. AutoHotkey v1.1をインストール
2. main.ahkを実行
