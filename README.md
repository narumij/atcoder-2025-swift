# atcoder-2025-swift

English | [日本語](README.ja.md)

An executable Swift Package compatible with the [AtCoder Language Update for 2024-2025](https://atcoder.jp/posts/1342).

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

A bug in swift-ac-collections prevented public methods from appearing in code completion suggestions, so swift-ac-collections has been fixed.
A performance issue in z_algorithm was found, so swift-ac-library has been fixed.

Because these fixes have been applied, the versions of swift-ac-library, swift-ac-collections, and swift-ac-memoize in this package do not match the judge environment.
If you need complete parity with the judge environment, please use tag 1.0.1.

## Notes

- Feel free to use this package however you like.
- Library versions are pinned.
- AtCoder does not track differences introduced by Xcode or Swift version updates. Please use them with care.
- It should work on Linux and Windows as well, but this has not been tested.

## Known Issues

A porting mistake exists in z_algorithm, causing poor performance.

Please use the following implementation as a workaround:
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

- Importing AcFoundation or IOReader replaces the definition of Error

If you need the original Error, write Swift.Error explicitly.

- IOReader may cause MLE when reading strings

This is caused by a design and implementation issue where an internal variable-length buffer is never released. Sorry about that.
[MLE example](https://atcoder.jp/contests/abc324/submissions/71894548)
[Workaround example](https://atcoder.jp/contests/abc324/submissions/71897651)

The reader always retains a buffer at least as large as the string size it has read. Reading a large string at once can therefore use more than twice as much memory as the input itself.

Specifically, this affects `String`, `[Character]`, and `[UInt8]`.
Other types are unaffected because they do not use the variable-length buffer.

Methods in the `.stdin` and `.read()` families eventually access this internal variable-length buffer and are therefore affected.
Other methods, such as the `.readLine()` family, do not use variable-length buffer access and can be used as a workaround.

- Using reference types as RedBlackTree Element, Key, or Value causes memory leaks

Please use value types instead of reference types.

- RedBlackTree's `formIndex(_:offsetBy:limitedBy)` does not assign limit when an operation moves beyond limit

There is no way to determine whether the operation failed because it exceeded limit. Sorry about that.

- Swift Concurrency support in swift-ac-library is insufficient

Please use annotations such as `@preconcurrency` or `nonisolated(unafe)` as needed.
`@MainActor` alone may not be sufficient, so please be careful.

There are behavioral differences in this area between recent Xcode environments and the judge environment.
For data structures and similar components, it is recommended to verify compilation in AtCoder Code Test before submitting.


```swift
@preconcurrency import AtCoder
```

- Macros do not compile with the combination of Xcode and the 6.2.0 toolchain

Remove the following two entries from the package. Commenting them out is also fine.

```swift
      .package(
        url: "https://github.com/narumij/swift-ac-memoize",
        from: "0.2.0"),
```

```swift
        .product(name: "AcMemoize", package: "swift-ac-memoize"),
```

The same issue may occur with toolchains other than 6.2.0. If so, apply the same workaround.

- The stdin methods for SIMD2, SIMD3, and SIMD4 are unavailable

Methods required for protocol conformance are provided, but SingleReadable conformance is missing, so the stdin property cannot be used.
When using them, add the following to your source code:

```swift
extension SIMD2: SingleReadable { }
extension SIMD3: SingleReadable { }
extension SIMD4: SingleReadable { }
```

- Writing everything directly at the top level is slow

Starting with 6.2, submissions that write the submitted code directly at the top level appear to become slow.

[Slow example](https://atcoder.jp/contests/abc325/submissions/76863120), [fast example](https://atcoder.jp/contests/abc325/submissions/76863120)

For this reason, submitting in the following form is recommended.

```swift
import AcFoundation
func main() {
  // Submission code
}
main()
```

## License

CC0-1.0
