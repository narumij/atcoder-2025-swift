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
この修正を反映し、このバージョンではswift-ac-collectionsとswift-ac-memizeのバージョンがジャッジと一致していません。
ジャッジとの完全一致をご希望の場合、tag 1.0.1をご利用ください。

## その他

- どうぞご自由にお使いください。
- ライブラリのバージョンは固定されています。
- XcodeやSwiftのバージョンアップに伴う差分にAtCoder側は追従しません。各々で注意してご利用ください。
- LinuxやWindowsでも利用可能だとは思いますが試していません

## ライセンス

CC0-1.0
