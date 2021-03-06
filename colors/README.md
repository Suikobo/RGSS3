# カラーモジュール

## 機能説明
色の指定を拡張して指定できます。
- 従来どおりWindowスキンの色番号0～31
- 拡張パレットによる32～Ｎの色番号指定
- コンフィグに登録した色名による指定
- 「RRGGBB」形式による直接指定（アルファ値FF固定）
- 「AARRGGBB」形式による直接指定

## 導入方法
- 「▼ 素材」以下のほかの素材より下の位置に導入して下さい。
- 「Graphics/System/」フォルダ以下に「Colors.png」を保存して下さい。

## 使用方法
### □ スクリプト上での使用
~~~
Colors.get(number)　　　 ... Windowスキンのカラーパレット番号を指定
　　　　　　　　　　　　  　　 32以上を指定した場合、拡張パレットを使用
Colors.get(:color_name)　... コンフィグ項目のカラーネームを指定
Colors.get("RRGGBB")　　 ... RRGGBB形式のカラーコードを指定
Colors.get("AARRGGBB")　 ... AARRGGBB形式のカラーコードを指定
~~~

### □ メッセージの表示コマンドの色変更タグ（\C[n]）での使用
~~~
\C[number]　　　 ... Windowスキンのカラーパレット番号を指定
　　　　　　　　　　   32以上を指定した場合、拡張パレットを使用
\C[:color_name]　... コンフィグ項目のカラーネームを指定
\C[RRGGBB]　　　 ... RRGGBB形式のカラーコードを指定
\C[AARRGGBB]　　 ... AARRGGBB形式のカラーコードを指定
~~~

## コンフィグ設定
### □ MESSAGE_ENABLE
メッセージの表示コマンドの色変更タグ（\C[n]）にもこの素材を適用するかを指定します。

### □ EXT_FILE
拡張カラーパレットのファイル名を指定します。拡張子は指定不要です。

### □ COLORS
色名とカラーコードを登録します。  
書式は「:color_name => "color_code",」となっています。  
「color_code」は「RRGGBB」形式か「AARRGGBB」形式で指定して下さい。  
色名の付いたＷＥＢカラー140色と透明・半透明の色は事前登録済みです。  
ＷＥＢカラー140色の色サンプルについてはネットで検索してご覧下さい。
