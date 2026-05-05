// The file name must be "main.swift".
// ファイル名はmain.swiftである必要があります。

// You can create an entry point with "Main.swift", but the behavior differs and will cause CE on submission.
// Main.swiftでもエントリーポイントは作れますが、挙動が異なり提出するとCEとなります。

// Turn off Intelligence features.
// Intelligenceはオフにしましょう。

import AcCollections
import AcFoundation
import AcMemoize
import Algorithms
import AtCoder
import BigInt
import BigNum
//import CharacterUtil
import Collections
//import Convenience
//import CxxWrapped
import Foundation
//import IOUtil
//import MT19937
import Numerics
//import StringUtil
//import UInt8Util
import simd

#if canImport(Glibc)
  //  import AccelerateLinux
#else
  //  import Accelerate
#endif

#if ONLINE_JUDGE
  // This branch is enabled when submitting to AtCoder.
  // 提出時こちらが有効になります
  print("Hello, AtCoder!")
#else
  // This branch is disabled when submitting to AtCoder.
  // 提出時こちらが無効になります
  print("Hello, world!")
#endif

#if false
  // The z_algorithm bundled in the new judge has an issue and is slow.
  // Please use the implementation below instead.

  // 新ジャッジ搭載のz_algorithmには不備があり性能がでません。代わりに以下をご利用ください。
  @inlinable
  func z_algorithm<Element>(pointer s: UnsafePointer<Element>, count n: Int) -> [Int]
  where Element: Equatable {
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
  where C: Equatable {
    z_algorithm(pointer: s, count: s.count)
  }

  @inlinable
  public func z_algorithm(_ s: String) -> [Int] {
    s.withCString(encodedAs: Unicode.ASCII.self) {
      z_algorithm(pointer: $0, count: s.count)
    }
  }
#endif
