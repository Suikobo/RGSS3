# フィルター付きＣＧギャラリー画面

## 機能説明
- ＡＤＶ系のゲームでよくあるＣＧギャラリーを再現します。
- 共通セーブファイル併用により、各セーブで共通の閲覧フラグが管理できます。
- フィルター機能により、衣装差分等のフィルタリングが可能になります。
- 画面サイズ「544×416」「640×480」に対応しています。

## 導入方法
「▼ 素材」以下の適当な場所に導入して下さい。  
設定が複雑なので「sample.zip」で動作を確認しながら導入して下さい。  
また、この素材は「共通セーブファイル」の導入が必要です。

## 使用方法
### □ ＣＧギャラリー画面への移行
スクリプトにて以下の命令を実行して下さい。  
ＣＧギャラリー画面からの復帰は「Ｂ」ボタンを押してください。
~~~
Scene_CgGallery.start
~~~

### □ フィルターの操作
| 操作 | 説明 |
| ---- | ---- |
| ←→キー | カーソルを左右に移動します。   |
| Ｃボタン | 選択中のフィルターで、ＣＧリストにカーソルを移動します。 |
| Ｂボタン | ＣＧギャラリー画面を閉じます。 |

### □ ＣＧリストの操作
| 操作 | 説明 |
| ---- | ---- |
| 十字キー | カーソルを上下左右に移動します。 |
| ＬＲボタン | カーソルをページ送り・戻しします。 |
| Ｃボタン | カーソルのあるＣＧの閲覧モードに移行します。 |
| Ｂボタン | フィルターの選択操作に戻ります。 |

### □ ＣＧ閲覧モードの操作
| 操作 | 説明 |
| ---- | ---- |
| Ｃボタン | 次の差分がある場合、次のＣＧを表示します。<br>次の差分がない場合、ＣＧリストの選択操作に戻ります。  |
| Ｂボタン | ＣＧリストの選択操作に戻ります。 |

## コンフィグ設定
### □ CG_LIST
スクリプト内のコメントをご覧下さい。

### □ CG_DIR
ＣＧが保存されているフォルダを指定します。

### □ CG_BGM
ＣＧギャラリー画面で再生するＢＧＭを指定します。
「Audio/BGM」にあるファイルを指定して下さい。

### □ ALL_OPEN_MODE
全開放フラグに使う共通セーブファイルのIDを指定して下さい。  
ここで指定したＩＤの値を「true」に設定すると、すべてのＣＧが開放されます。  
「false」にすると、元の開放状態に戻ります。

### □ CG_FILTER
フィルターウィンドウに表示するアイコンとヘルプテキストを設定します。  
設定した順に表示され、フィルタ番号は「０」から定義されます。  
０番は全表示フィルターです。必ず設定して下さい。  
基本的に何個でも設定できますが、あまり多く設定すると画面に表示しきれません。  
「アイコン番号」は、ツクールで使われているアイコンのインデックス番号を指定して下さい。  
「ヘルプテキスト」は、そのフィルターが何なのか分かりやすいテキストを指定して下さい。

## その他の説明
### □ ＣＧファイルの命名規則
このギャラリーを正しく使うため、以下の命名規則に従いCGファイル名を決めてください。
~~~
[ファイル名]_[差分番号].[拡張子]
~~~
| 項目名 | 説明 |
| ---- | ---- |
| ファイル名 | 基本ＣＧ名です。ここは自由に決めて問題ありません。 |
| 差分番号 | 半角数字２桁表記で「01」から順に付けて下さい。 |
| 拡張子 | ツクールで扱える画像形式の拡張子を付けて下さい。 |

### □ 各ＣＧの開放フラグの立て方について
各ＣＧの差分「01」で判断しています。  
見てない差分は表示したくない場合は、気合で改造して下さい。多分割と行けます。  
フラグを立てるにはＣＧを表示するタイミングで以下のスクリプトを実行して下さい。
~~~
$savec.set("基本ＣＧ名_01", true)
~~~

### □ 全開放フラグの立て方について
コンフィグ設定で指定したＩＤを「true」に設定します。
以下のスクリプトを実行して下さい。
~~~
$savec.set("設定したID", true)
$savec.set(SUI::GALLERY::ALL_OPEN_MODE, true)でも行けます。
解除するには「false」を設定して下さい。
~~~

### □ ＣＧサムネイルの扱いについて
ＣＧギャラリーに表示されるサムネイルは「cg_thumb.png（デフォルト）」にあります。  
各サムネイルはCG_LISTの「サムネ番号」で指定された場所にあるサムネイルを表示します。  
サムネイルは「100×75」サイズにして、ファイル内の該当箇所に貼り付けてください。  
一番左上（０番）のサムネイルはダミーサムネイルです。ＣＧ閲覧フラグが「false」の場合に変わりに表示されます。  
サムネイルの数が99個で足りない場合は、下方向に拡張してください。
