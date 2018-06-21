# MemcachedSwift

In dev

!!! Does not work for classes

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
