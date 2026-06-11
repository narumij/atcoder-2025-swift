# atcoder-2025-swift

English | [日本語](README.ja.md)

An executable Swift Package compatible with the [AtCoder Language Update for 2024–2025](https://atcoder.jp/posts/1342).

## Requirements

- macOS 26 or later
- Xcode 26.0 or later

## Changes

Updated the Swift language version:

- 6.2

Updated the following libraries:

- swift-collections
- swift-algorithm
- swift-numerics

Added the following libraries:

- BigInt
- swift-bignum
- kvSIMD
- accelerate-linux
- swift-ac-library
- swift-ac-collections
- swift-ac-foundation
- swift-ac-memoize

Added the following judge definition:

- ONLINE_JUDGE

## About Some Updates

A bug in `swift-ac-collections` prevented public methods from appearing in code completion suggestions. This has been fixed.

A performance issue in the Z Algorithm implementation was found in `swift-ac-library`. This has also been fixed.

Because these fixes have been applied, the versions of `swift-ac-library`, `swift-ac-collections`, and `swift-ac-memoize` included in this package do not exactly match the versions used by the AtCoder judge environment.

If you require complete version parity with the judge environment, please use tag `1.0.1`.

## Notes

- Feel free to use this package however you like.
- Library versions are pinned.
- AtCoder does not track differences introduced by newer versions of Xcode or Swift. Please use them with care.
- It should work on Linux and Windows as well, but this has not been tested.

## Known Issues

### Poor Performance in `z_algorithm`

A porting mistake exists in `z_algorithm`, causing it to perform poorly.

Please use the following implementation as a workaround:

```swift
...
```

### `Error` Is Shadowed When Using AcFoundation or IOReader

When importing AcFoundation or IOReader, the standard `Error` definition is replaced.

If you need the original Swift error type, explicitly use:

```swift
Swift.Error
```

### IOReader May Cause MLE When Reading Strings

This is caused by a design and implementation issue where an internal variable-length buffer is never released. Sorry about that.

- MLE example: https://atcoder.jp/contests/abc324/submissions/71894548
- Workaround example: https://atcoder.jp/contests/abc324/submissions/71897651

The reader always retains a buffer at least as large as the largest string it has read. As a result, reading a large string at once may consume significantly more memory than the size of the input itself.

Specifically, this affects:

- `String`
- `[Character]`
- `[UInt8]`

Other types are unaffected because they do not use the variable-length buffer.

Methods in the `.stdin` and `.read()` families eventually access this internal buffer and are therefore affected.

Other methods, such as `.readLine()` and related APIs, do not use the variable-length buffer and can be used as a workaround.

### Memory Leak When Using Reference Types in RedBlackTree

Using reference types as `Element`, `Key`, or `Value` in RedBlackTree causes memory leaks.

Please use value types instead.

### `formIndex(_:offsetBy:limitedBy:)` Does Not Assign `limit` on Failure

When `RedBlackTree.formIndex(_:offsetBy:limitedBy:)` attempts to move beyond the specified limit, it does not assign the limit value.

Unfortunately, there is currently no way to determine whether the operation failed because the limit was exceeded. Sorry about that.

### Incomplete Swift Concurrency Support in swift-ac-library

Swift Concurrency support in `swift-ac-library` is not yet sufficient.

Please use annotations such as `@preconcurrency` or `nonisolated(unsafe)` as needed.

`@MainActor` alone may not always be sufficient.

There are also behavioral differences between recent Xcode environments and the AtCoder judge environment in this area.

For data structures and other concurrency-sensitive components, it is recommended to verify that your code compiles successfully using AtCoder's Code Test feature before submitting.

```swift
@preconcurrency import AtCoder
```

### Macros Fail to Compile with Xcode + Swift 6.2.0 Toolchain

If you encounter macro compilation errors when using Xcode together with the Swift 6.2.0 toolchain, remove the following package dependency (commenting it out is also fine):

```swift
.package(
  url: "https://github.com/narumij/swift-ac-memoize",
  from: "0.2.0"),
```

And also remove:

```swift
.product(name: "AcMemoize", package: "swift-ac-memoize"),
```

Similar issues may occur with toolchains other than 6.2.0. If so, apply the same workaround.

## License

CC0-1.0
