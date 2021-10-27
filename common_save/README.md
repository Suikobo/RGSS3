# 共通セーブファイル

## 機能説明
- 各セーブファイルに依存しない、ゲーム全体共通のセーブファイルを作成します。
- 「true/false」と「数値」の２種類の値が保存できます。
- ＣＧやイベントシーンの閲覧フラグや強くてニューゲームのデータ一時保管に便利です。

## 導入方法
「▼ 素材」以下で、他の素材より上の方に導入して下さい。

## サンプルスクリプト
~~~
msgbox $savec.check("aaa")
$savec.set("aaa", true)
msgbox $savec.check("aaa")
msgbox $savec.get_num("bbb")
$savec.set_num("bbb", 14106)
msgbox $savec.get_num("bbb")
~~~

## 使用方法
### □ 「true/false」の保存
~~~
$savec.set(id, data)
~~~
| 引数名 | 入れる値 |
| ---- | ---- |
| id | 任意の文字列、または数字 |
| data | true/false |

### □ 「true/false」の読出し
~~~
$savec.check(id)
~~~
| 引数名 | 入れる値 |
| ---- | ---- |
| id | 任意の文字列、または数字 |
| 戻り値 | true/false<br>存在しないidはfalse |

### □ 数値の保存
~~~
$savec.set_num(id, data)
~~~
| 引数名 | 入れる値 |
| ---- | ---- |
| id | 任意の文字列、または数字 |
| data | $savec.get_num(id) |

### □ 数値の読出し
~~~
$savec.get_num(id)
~~~
| 引数名 | 入れる値 |
| ---- | ---- |
| id | 任意の文字列、または数字 |
| 戻り値 | 数値<br>存在しないidは-1 |
