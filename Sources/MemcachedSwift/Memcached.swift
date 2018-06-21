//
//  Memcached.swift
//  MemcachedSwift
//
//  Created by Anatoly Myaskov on 6/20/18.
//

#if os(Linux)
import libMemcachedLinux
#else
import Darwin
import libMemcachedMac
#endif


import Foundation

class Memcached {
    fileprivate var memc: UnsafeMutablePointer<memcached_st> = memcached_create(nil)
    fileprivate var rc: memcached_return = MEMCACHED_ERROR
}

// Add Server
extension Memcached {
    func addServer(host: String, port: UInt16, weight: UInt32? = nil) throws {
        if weight == nil {
            rc = memcached_server_add(self.memc, host, port)
        } else {
            rc = memcached_server_add_with_weight(self.memc, host, port, weight!)
        }
        if (rc != MEMCACHED_SUCCESS) {
            throw MemcachedError(rc)
        }
    }
    
    func addServer(udp host: String, port: UInt16, weight: UInt32? = nil) throws {
        if weight == nil {
            rc = memcached_server_add_udp(self.memc, host, port)
        } else {
            rc = memcached_server_add_udp_with_weight(self.memc, host, port, weight!)
        }
        if (rc != MEMCACHED_SUCCESS) {
            throw MemcachedError(rc)
        }
    }
    
    func addServer(unix filename: String, weight: UInt32? = nil) throws {
        if weight == nil {
            rc = memcached_server_add_unix_socket(self.memc, filename)
        } else {
            rc = memcached_server_add_unix_socket_with_weight(self.memc, filename, weight!)
        }
        if (rc != MEMCACHED_SUCCESS) {
            throw MemcachedError(rc)
        }
    }
}

extension Memcached {
    func set<T: Any>(key: String, object: T, expiration: Int = 0, flags: UInt32 = 0) throws {
        var data = Data(bytes: Packer.pack(object) )
        try data.withUnsafeBytes{(bytes: UnsafePointer<Int8>) -> Void in
            rc = memcached_set(memc, key, strlen(key), bytes, data.count+1, expiration, flags);
            if (rc != MEMCACHED_SUCCESS) {
                throw MemcachedError(rc)
            }
        }
    }
    
    func get<T: Any>(key: String, flags: UInt32 = 0) throws -> T {
        var _flags = flags
        var length: size_t = 0;
        let returnValue = memcached_get (memc, key, strlen(key), &length, &_flags, &rc);
        if (rc == MEMCACHED_SUCCESS) {
            return Packer.unpack(Data(bytes: returnValue!, count: length).toByteArray(), toType: T.self)
        } else {
            throw MemcachedError(rc)
        }
    }
}
