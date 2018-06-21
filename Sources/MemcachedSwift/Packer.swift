//
//  Packer.swift
//  MemcachedSwift
//
//  Created by Anatoly Myaskov on 6/20/18.
//

import Foundation

public typealias Byte = UInt8

public enum ByteOrder {
    case bigEndian
    case littleEndian
    
    public static let nativeByteOrder: ByteOrder = (Int(CFByteOrderGetCurrent()) == Int(CFByteOrderLittleEndian.rawValue)) ? .littleEndian : .bigEndian
}


open class Packer {
    open class func unpack<T: Any>(_ valueByteArray: [Byte], byteOrder: ByteOrder = .nativeByteOrder) -> T {
        return Packer.unpack(valueByteArray, toType: T.self, byteOrder: byteOrder)
    }
    
    open class func unpack<T: Any>(_ valueByteArray: [Byte], toType type: T.Type, byteOrder: ByteOrder = .nativeByteOrder) -> T {
        let bytes = (byteOrder == ByteOrder.nativeByteOrder) ? valueByteArray : valueByteArray.reversed()
        return bytes.withUnsafeBufferPointer {
            return $0.baseAddress!.withMemoryRebound(to: T.self, capacity: 1) {
                $0.pointee
            }
        }
    }
    
    open class func pack<T: Any>( _ value: T, byteOrder: ByteOrder = .nativeByteOrder) -> [Byte] {
        var value = value // inout works only for var not let types
        let valueByteArray = withUnsafePointer(to: &value) {
            Array(UnsafeBufferPointer(start: $0.withMemoryRebound(to: Byte.self, capacity: 1){$0}, count: MemoryLayout<T>.size))
        }
        return (byteOrder == ByteOrder.nativeByteOrder) ? valueByteArray : valueByteArray.reversed()
    }
}


public extension Data {
    func toByteArray() -> [Byte] {
        let count = self.count / MemoryLayout<Byte>.size
        var array = [Byte](repeating: 0, count: count)
        copyBytes(to: &array, count:count * MemoryLayout<Byte>.size)
        return array
    }
}


