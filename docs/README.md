# AHK-Tools

AutoHotkey(v2)を使用したキーボード・マウス操作の拡張ツール群です。

## 目次

- [概要](#概要)
- [ディレクトリ構成](#ディレクトリ構成)
- [主な機能](#主な機能)
  - [基本操作](#基本操作)
  - [カーソル移動](#カーソル移動f13--キー)
  - [テキスト編集](#テキスト編集)
  - [アプリケーション固有機能](#アプリケーション固有機能)
  - [検索機能](#検索機能)
- [インストールと設定](#インストールと設定)
- [使用方法](#使用方法)

## 概要

このツールは、キーボードとマウスの操作を拡張し、作業効率を向上させることを目的としています。
特にプログラミングやテキスト編集作業において、快適な操作環境を提供します。

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
- キーマップ表示（Alt + L）
- テキスト検索（Shift + 中クリック）

### カーソル移動（F13 + キー）

- IJKL: 矢印キー（↑←↓→）相当の移動
- H/;: Home/End（行頭/行末）
- y/u: 前の単語の先頭へ/次の単語の先頭へ
- Space: Enter
- N/M: Page Up/Down

### テキスト編集

- O/P: バックスペース/削除
- カット/コピー/ペースト: 標準的なショートカット対応
- 選択範囲の拡張: Shift + 移動キー

### アプリケーション固有機能

#### ブラウザ（Chrome/Edge/Brave）

- タブ切り替え（F13 + ホイール）
- タブ操作（F13 + Y/U）
- Shiftダブルタップで改行挿入

#### Microsoft Office

- Excel: シート切り替え（F13 + ホイール）
- PowerPoint/Word: 左右スクロール（Shift + ホイール）

### 検索機能

選択テキストに応じた自動アクション：

1. URLの場合：デフォルトブラウザで開く
2. ローカルパスの場合：エクスプローラーで開く
3. その他の文字列：Google検索を実行

## インストールと設定

1. 必要条件
   - AutoHotkey v2のインストール
   - Windows 10/11

2. セットアップ

   ```bash
   git clone https://github.com/yourusername/AHK-Tools.git
   cd AHK-Tools
   ```

<!-- 3. 設定ファイルの編集（必要に応じて）
   - `config/settings.ini`で個人設定を調整 -->

## 使用方法

1. `main.ahk`を実行
2. タスクトレイにアイコンが表示されることを確認
