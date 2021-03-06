# フィルター付きシーン回想画面

## 機能説明
- ＡＤＶ系のゲームでよくあるシーン回想画面を再現します。
- 共通セーブファイル併用により、各セーブで共通の閲覧フラグが管理できます。
- フィルター機能により、衣装差分等のフィルタリングが可能になります。
- 画面サイズ「544×416」「640×480」に対応しています。

## 導入方法
「▼ 素材」以下の適当な場所に導入して下さい。  
設定が複雑なので「sample.zip」で動作を確認しながら導入して下さい。  
また、この素材は「共通セーブファイル」と「フィルター付きＣＧギャラリー画面」の導入が必要です。

## 使用方法
### □ シーン回想画面への移行
スクリプトにて以下の命令を実行して下さい。  
シーン回想画面からの復帰は「Ｂ」ボタンを押してください。
~~~
Scene_SceneGallery.start
~~~

### □ フィルターの操作
| 操作 | 説明 |
| ---- | ---- |
| ←→キー | カーソルを左右に移動します。   |
| Ｃボタン | 選択中のフィルターで、回想リストにカーソルを移動します。 |
| Ｂボタン | シーン回想画面を閉じます。 |

### □ 回想リストの操作
| 操作 | 説明 |
| ---- | ---- |
| 十字キー | カーソルを上下左右に移動します。 |
| ＬＲボタン | カーソルをページ送り・戻しします。 |
| Ｃボタン | カーソルのあるシーンの回想モードに移行します。 |
| Ｂボタン | フィルターの選択操作に戻ります。 |

### □ 回想モードの操作
通常のイベントと同じ操作です。

## コンフィグ設定
### □ SCENE_VAR
シーン回想用変数をゲーム内変数の番号で指定します。  
ここで指定した変数に回想シーンのサムネ番号が渡されます。  
自動実行イベントにてこの変数を監視し、回想シーンを構築して下さい。  
詳しくは動作サンプルをご確認下さい。

## その他の説明
### □ イベントとの連動について
回想リストでＣボタンを押した後、設定された変数にサムネ番号を渡し、一時的にマップ画面に戻ります。  
マップ画面には設定された変数がトリガになる自動実行イベントを配置し、その内部で回想イベントを構築して下さい。  
【重要】各回想終了後、必ず以下のスクリプトを実行して下さい。  
~~~
Scene_SceneGallery.start
~~~
