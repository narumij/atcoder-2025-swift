# タイトル未定

## はじめに

AtCoderに限った内容は一般的なSwiftの入門書やSwiftの入門コンテンツにはあまりみられないので、これを補うことがこの文書の目的です。

ほんとうにSwiftやプログラミングを知らない人がこの文書にたどり着くことは無いとは思いますが、知識のおさらいも兼ねてそういった方を想定しています。

## 出力とprint関数

とっても短いプログラム

```swift
print("Hello, world!")
```

このプログラムは Hello, world! という文字を出力します。

print関数の詳しい説明は、Xcodeの
Help > Developer Documentation
とメニューを辿り、左ペインで以下を辿ると読むことが出来ます。

```
> Swift
  > Swift Standard Library
    > Input and Output
      > print(_:separator:terminator:)
```

「与えられた値の文字列表現を標準出力へ書き出す」
という説明があります。

（この説明は、関数をoption+clickすることでポップアップ表示されたり、右ペインに簡易ブラウザを表示させることもできるなど、複数のアクセス方法があります。）

次に以下のような記述のあと、さらに説明があります。

```swift
func print(
    _ items: Any...,
    separator: String = " ",
    terminator: String = "\n"
)
```

これは簡単にまとめると、

- 複数の値をまとめて出力できる
- 値の間には空白が入る
- 最後に改行が入る

ということです。


先ほどの短いプログラムをもう少しきっちり書くと以下になり、同じ結果となります。

```swift
print("Hello, world!", separator: " ", terminator: "\n")
```

`separator: " ", terminator: "\n"`が隠れていたわけです。

`"Hello, world!"`や`" "`や`"\n"`は文字列リテラルと呼ばれます。
リテラルとは、文字列や値を直接プログラムに記述する形式のことです。
他にも、数値リテラル、配列リテラル、辞書リテラルなどがあります。

## 実行と入力

### ローカルXcodeでの実行

main.swiftの中身を以下だけにします。それ以外は全部消してください。

```swift
print("Hello, world!")
```

View>Debug Area>Activate Consoleでコンソールを表示しましょう。
Product>Runとするか、コマンド+Rキーを押して実行してみましょう。

ソース
```swift
print("Hello, world!")
```

期待されるコンソール出力は以下です。少し待つかもしれませんが、これが表示されたら成功です！

```
Hello, world!
```

### コードテストでの実行

[practice contest - コードテスト](https://atcoder.jp/contests/practice/custom_test)

言語でSwift 6.2を選びます。

ソースコードに以下をペーストします。
```swift
print("Hello, world!")
```

実行ボタンを押します。

期待される標準出力は以下です。以下が表示されれば成功です！

```
Hello, world!
```

それでは、入力に対して期待された出力を生成するプログラムを作りましょう。

実際の問題で試してみましょう。

[practice contest - A - Welcome to AtCoder](https://atcoder.jp/contests/practice/tasks/practice_1)

出力例1は

以下のように書けば正解できます。
```swift
print(6, "test") // -> 6 test
```

出力例2は

以下のように書けば正解できます。
```swift
print(456, "myonmyon") // -> 456 myonmyon
```

ただしこれでは、どちらかにしか正解できない不十分なプログラムとなってしまいます。

## 入力と足し算

ここで一旦寄り道をします。

```swift
import AcFoundation
print(String.stdin)
```

Xcodeの場合は実行してからコンソールに好きな文字を入力して改行
コードテストの場合は標準入力に好きな文字を入力してから実行

importがでてきました。これは雑に説明すると、機能を付け足すということです。
Stringが出てきました。これは種類を表していて文字列です。
.stdinが出てきました。これはimportで付け足されたもので、入力を一個受け取ります。
String.stdinで文字列を一個受け取るという意味になります。

こちらも試してみましょう。

```swift
import AcFoundation
print(Int.stdin)
```

好きな数字を入力にして試してください。

Intが出てきました。これは種類を表していて整数です。
Int.stdinで整数を一個受け取るという意味になります。

これらを使って少し進めます。

```swift
import AcFoundation
let a = Int.stdin
print(1, "test")
```

letが出てきました。これは値に名前を付けるためのものです。
一度値を入れたら変更できないという特徴もあります。

つまり以下の一文は、入力から一個取り出した整数を変更不可能なaという名前で用意するという意味です。

```swift
let a = Int.stdin
```

入力が他に三つあるので、それらも読むように修正したのが以下です。b, c, sが用意されました。
```swift
import AcFoundation
let a = Int.stdin
let b = Int.stdin
let c = Int.stdin
let s = String.stdin
print(1, "test")
```

a+b+cを計算するよう修正します
```swift
let calc = a + b + c
```

a+b+cの計算結果と、文字列sを並べて表示します。

```swift
print(calc, s)
```

まとめたものが以下です。

```swift
import AcFoundation

let a = Int.stdin
let b = Int.stdin
let c = Int.stdin
let s = String.stdin

let calc = a + b + c

print(calc, s)
```

これで入力例1と入力例2に正解することが出来、それ以外のテストケースにも正解できるようになりました。

## 数列の出力

問題によっては、複数の整数をまとめて出力する必要があります。

Swiftでは複数の値を配列で持つことが一般的です。

配列リテラルは`[]`を使います。
例えば以下です。
```swift
[1, 2, 3, 4]
```

これをprintすると、リテラル形式で出力されます。
```swift
print([1, 2, 3, 4]) // -> [1, 2, 3, 4]
```
AtCoderではSwiftの配列リテラルを出力結果として受け付けてくれないため、異なる出力方法が必要になります。

```swift
import Convenience
[1, 2, 3 ,4].print() // -> 1 2 3 4
```
(将来、import Convenienceではなく、import AcFoundationになります。)

## 複数数列や複数文字列の出力
(注：将来こうなるという内容です。)

```swift
[[1,2],[3,4]].print()
```

```
1 2
3 4
```

```swift
["####","####"].print()
```

```
####
####
```

## まとめ

`stdin` と `print` を覚えるだけで、入力と出力についてはひとまず困らなくなります。

あとは問題を解きながら、必要になった知識を少しずつ増やしていきましょう。
