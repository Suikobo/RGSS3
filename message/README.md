# メッセージ機能拡張

## 機能説明
- 追加された制御文字で、立ち絵を左・中央・右に表示できます。
- 追加された制御文字で、音声を再生できます。
- 追加された制御文字で、ＳＥを再生できます。
- 追加された制御文字で、ＣＧの表示ができます。
- 上記機能をスクリプトからも実行できます。
- コンフィグ項目で指定したボタンで、メッセージ枠を一時消去できます。
- コンフィグ項目で指定したボタンで、自動改ページモードに移行できます。
- シーンスキップに設定したゲームスイッチをオンにすると、コンフィグ項目で設定したボタンを押すことでスキップ先ラベルまでスキップできます。

## 導入方法
「▼ 素材」以下の適当な場所に導入して下さい。  
また、この素材は「共通セーブファイル」の導入が必要です。

## 動作サンプルについて
- テーブルの上にいるＮＰＣが制御文字の動作サンプルです。
- テーブルの下にいるＮＰＣがスクリプトから操作するサンプルです。
- 一番左にいるＮＰＣがメッセージ枠一時消去と自動改ページとスキップのサンプルです。
- 一番右にいるＮＰＣはオプション画面スクリプト用のため、このスクリプトには関係ありません。

## 使用方法
### □ 制御文字とスクリプトのリファレンス
manual.txtをご覧ください。

### □ メッセージ枠の一時消去
コンフィグ設定「BTN_HIDE」で設定したボタンを押すとメッセージ枠が非表示になります。  
もう一度押すか、Ｃボタンを押すとメッセージ枠が表示されます。

### □ 自動改ページモード
コンフィグ設定「BTN_AUTO_MODE」で設定したボタンを押すと自動改ページモードになります。  
もう一度押すか、ＣボタンまたはＢボタンを押すと解除されます。  
自動改ページモード中は右上に「自動改ページモード」のメッセージが表示されます。

### □ シーンスキップ
コンフィグ設定「SW_SKIP_ON」で指定したスイッチがオンの場合にスキップが有効になります。  
スキップが有効の間、ボタン入力待ち中にコンフィグ設定「BTN_RETURN」で設定したボタンを押すと、スキップ先ラベルまでジャンプします。  
スキップ先ラベルはコンフィグ設定「SKIP_LABEL」で指定したラベルになります。

## コンフィグ設定
### □ LEFT_X, CENTER_X, RIGHT_X
左側・中央・右側のそれぞれの立ち絵を表示するＸ座標を指定します。  
ピクチャの仕様上、左上を座標原点とします。  
Ｙ座標は強制的に０にしているため、画像サイズは画面の縦幅に合わせて下さい。

### □ LEFT_PIC, CENTER_PIC, RIGHT_PIC
左側・中央・右側のそれぞれの立ち絵表示に使うピクチャ番号を指定します。

### □ CG_PIC
ＣＧの表示に使うピクチャ番号を指定します。

### □ BTN_HIDE, BTN_RETURN, BTN_AUTO_MODE
各動作のトリガーに使うボタンを指定します。  
「Input::指定するボタン」の形式で指定して下さい。  
すでに別の機能が割り当ててあるボタンを指定した場合の動作は保障していません。

### □ SURFACE_DIR, CG_DIR
立ち絵・ＣＧが保存されたフォルダを「Graphics/Pictures/」からの相対パスで指定します。  
「Graphics/Pictures/」に保存している場合は空文字を指定して下さい。

### □ VOICE_DIR
音声が保存されているフォルダを指定します。

### □ SW_SKIP_ON
シーンスキップ可否に使うゲーム内スイッチ番号を指定します。

### □ SKIP_LABEL
スキップ先として使用するラベル名を指定します。

### □ AUTO_WAIT
自動改ページモードの待ち時間をフレーム数で指定します。  
要素数３の配列で指定し、０番が「遅い」、１番が「普通」、２番が「速い」の順になります。  
オプション画面スクリプトが未導入の場合、自動的に「普通」が選択されます。

## その他の説明
### □ オプション機能について
このスクリプトの動作をカスタマイズする機能として「オプション画面」スクリプトを準備しています。  
便利な機能を搭載しているので、ぜひ合わせてご利用下さい。
