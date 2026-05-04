# atcoder-2025-swift

English | [日本語](README.ja.md)

A Swift executable package compatible with the [AtCoder Language Update 2024–25](https://atcoder.jp/posts/1342).

## Requirements

- macOS 26 or later  
- Xcode 26.0 or later  

## Changes

Updated language version:
- 6.2

Updated libraries:
- swift-collections
- swift-algorithm
- swift-numerics

Added libraries:
- BigInt
- swift-bignum
- kvSIMD
- accelerate-linux
- swift-ac-library
- swift-ac-collections
- swift-ac-foundation
- swift-ac-memoize

Added judge definition:
- ONLINE_JUDGE

## About Partial Updates

There was an issue where public methods did not appear in code completion, so `swift-ac-collections` was fixed.  
There was also a performance issue with the Z algorithm, so `swift-ac-library` was fixed.

Because of these fixes, the versions of `swift-ac-library`, `swift-ac-collections`, and `swift-ac-memoize` in this package do not match the judge environment.

If you need exact compatibility with the judge, please use tag `1.0.1`.

## Notes

- Feel free to use this package.
- Library versions are fixed.
- AtCoder does not follow differences caused by Xcode or Swift updates. Use at your own risk.
- It may work on Linux or Windows, but it has not been tested.

## Known Issues

### Z Algorithm Performance Issue

There is a porting mistake in `z_algorithm`, resulting in poor performance.

Please use the following implementation instead:

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

---

### Error Type Replacement

When using `AcFoundation` or `IOReader`, the `Error` type is overridden.

If you need the original one, explicitly use:

```swift
Swift.Error
```

---

### MLE When Using IOReader with Strings

This occurs because the internal variable-length buffer is not released.

Example:
- MLE case: https://atcoder.jp/contests/abc324/submissions/71894548  
- Workaround: https://atcoder.jp/contests/abc324/submissions/71897651  

The implementation keeps a buffer at least as large as the largest string read, which may result in more than double the memory usage.

Affected types:
- `String`
- `[Character]`
- `[UInt8]`

Other types are not affected because they do not use variable-length buffers.

Affected methods:
- `.stdin` family
- `.read()` family

Workaround:
- Use `.readLine()` family methods, which do not use the internal buffer.

---

### Memory Leak with Reference Types in RedBlackTree

Using reference types as `Element`, `Key`, or `Value` may cause memory leaks.

Use value types instead.

---

### `formIndex(_:offsetBy:limitedBy)` Bug

When exceeding the limit, the limit is not assigned.

There is currently no way to detect whether the operation failed due to exceeding the limit.

---

## License

CC0-1.0
