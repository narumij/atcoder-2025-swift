# atcoder-2025-swift

[2024-25年度AtCoder言語アップデート](https://atcoder.jp/posts/1342)に対応した実行形式のSwift Packageです。

## 動作環境

- macOS 26以降
- Xcode 26.0以降

## 変更点

言語のバージョンを更新しました。
- 6.2

ライブラリを更新しました。
- swift-collections
- swift-algorithm
- swift-numerics

ライブラリを追加しました。
- BigInt
- swift-bignum
- kvSIMD
- accelerate-linux
- swift-ac-library
- swift-ac-collections
- swift-ac-foundation
- swift-ac-memoize

ジャッジ定義として以下を追加しました
- ONLINE_JUDGE

## 一部更新について

コード補完候補に公開メソッドが表示されない不具合があり、swift-ac-collectionを修正しました。
z algorithmの性能が出ていない不具合があり、swift-ac-libraryを修正しました。

この修正を反映し、このバージョンではswift-ac-libraryとswift-ac-collectionsとswift-ac-memizeのバージョンがジャッジと一致していません。
ジャッジとの完全一致をご希望の場合、tag 1.0.1をご利用ください。

## その他

- どうぞご自由にお使いください。
- ライブラリのバージョンは固定されています。
- XcodeやSwiftのバージョンアップに伴う差分にAtCoder側は追従しません。各々で注意してご利用ください。
- LinuxやWindowsでも利用可能だとは思いますが試していません

## 既知の不具合

z_algorithmに移植ミスがあり、性能がでません。

以下で代替してください。
```swift
@inlinable
func z_algorithm<Element>(pointer s: UnsafePointer<Element>, count n: Int) -> [Int]
where Element: Comparable {
  if n == 0 { return [] }
  return [Int](unsafeUninitializedCapacity: n) { z, initializedCount in
    let z = z.baseAddress!
    z.initialize(repeating: 0, count: n)
    initializedCount = n
    z[0] = 0
    var i = 1
    var j = 0
    while i < n {
      defer { i += 1 }
      z[i] = j + z[j] <= i ? 0 : min(j + z[j] - i, z[i - j])
      while i + z[i] < n, s[z[i]] == s[i + z[i]] { z[i] += 1 }
      if j + z[j] < i + z[i] { j = i }
    }
    z[0] = n
  }
}

@inlinable
public func z_algorithm<C>(_ s: [C]) -> [Int]
where C: Comparable {
  z_algorithm(pointer: s, count: s.count)
}

@inlinable
public func z_algorithm(_ s: String) -> [Int] {
  s.withCString(encodedAs: Unicode.ASCII.self) {
    z_algorithm(pointer: $0, count: s.count)
  }
}
```

## ライセンス

CC0-1.0
