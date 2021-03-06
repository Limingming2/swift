// RUN: %target-run-simple-swift
// REQUIRES: executable_test

// REQUIRES: objc_interop

import StdlibUnittest

// Also import modules which are used by StdlibUnittest internally. This
// workaround is needed to link all required libraries in case we compile
// StdlibUnittest with -sil-serialize-all.
import SwiftPrivate
#if _runtime(_ObjC)
import ObjectiveC
#endif

import Foundation

var NSArrayAPI = TestSuite("NSArrayAPI")

NSArrayAPI.test("mixed types with AnyObject") {
  do {
    let result: AnyObject = [1, "two"]
    let expect: NSArray = [1, "two"]
    expectEqual(expect, result as! NSArray)
  }
  do {
    let result: AnyObject = [1, 2]
    let expect: NSArray = [1, 2]
    expectEqual(expect, result as! NSArray)
  }
}

NSArrayAPI.test("CustomStringConvertible") {
  let result = String(NSArray(objects:"A", "B", "C", "D"))
  let expect = "(\n    A,\n    B,\n    C,\n    D\n)"
  expectEqual(expect, result)
}

NSArrayAPI.test("copy construction") {
  let expected = ["A", "B", "C", "D"]
  let x = NSArray(array: expected as NSArray)
  expectEqual(expected, x as! Array)
  let y = NSMutableArray(array: expected as NSArray)
  expectEqual(expected, y as NSArray as! Array)
}

var NSMutableArrayAPI = TestSuite("NSMutableArrayAPI")

NSMutableArrayAPI.test("CustomStringConvertible") {
  let result = String(NSMutableArray(objects:"A", "B", "C", "D"))
  let expect = "(\n    A,\n    B,\n    C,\n    D\n)"
  expectEqual(expect, result)
}

runAllTests()
