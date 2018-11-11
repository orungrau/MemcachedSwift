# SwiftMemcached

!!! Does not work for classes

## Installation

Modify your Package.swift file to include the following dependency:
    
```Swift
    .package(url: "https://github.com/orungrau/SwiftMemcached.git", .upToNextMinor(from: "0.0.1"))
```
You should also include “**MemcachedSwift**” in your list of target dependencies.

## Use
```Swift
import MemcachedSwift

do {
    let object: Int = 10
    
    let mem = Memcached()
    
    // add Memcached server
    try mem.addServer(host: "localhost", port: 11211)
    
    // set
    try mem.set(key: "key", object: object)
    
    // get
    let outputObject = try mem.get(key: "key") as Int // 10
    
} catch let error {
    print(error.localizedDescription)
}
```
