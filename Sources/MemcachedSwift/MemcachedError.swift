//
//  MemcachedError.swift
//  MemcachedSwift
//
//  Created by Anatoly Myaskov on 6/21/18.
//

#if os(Linux)
import libMemcachedLinux
#else
import Darwin
import libMemcachedMac
#endif

import Foundation

struct MemcachedError: Error {
    var reason: String
    
    var rc: memcached_return = MEMCACHED_ERROR
    init(_ rc: memcached_return) {
        self.rc = rc
        
        switch rc {
        case MEMCACHED_AUTH_CONTINUE:
            reason = "Authentication has been paused."
        case MEMCACHED_AUTH_FAILURE:
            reason = "The credentials provided are not valid for this server."
        case MEMCACHED_AUTH_PROBLEM:
            reason = "An unknown issue has occured during authentication."
            
        case MEMCACHED_BAD_KEY_PROVIDED:
            reason = "The key provided is not a valid key."
            
        case MEMCACHED_BUFFERED:
            reason = "The request has been buffered."
            
        case MEMCACHED_CLIENT_ERROR:
            reason = "An unknown client error has occured internally."
            
            
        case MEMCACHED_CONNECTION_BIND_FAILURE:
            reason = "We were not able to bind() to the socket."
            
        case MEMCACHED_CONNECTION_FAILURE:
            reason = "A unknown error has occured while trying to connect to a server."
            
        case MEMCACHED_CONNECTION_SOCKET_CREATE_FAILURE:
            reason = "An error has occurred while trying to connect to a server. It is likely that either the number of file descriptors need to be increased or you are out of memory."
            
        case MEMCACHED_DATA_DOES_NOT_EXIST:
            reason = "The data requested with the key given was not found."
            
        case MEMCACHED_DATA_EXISTS:
            reason = "The data requested with the key given was not found."
            
        case MEMCACHED_DELETED:
            reason = "The object requested by the key has been deleted."
            
        case MEMCACHED_DEPRECATED:
            reason = "The method that was requested has been deprecated."
            
        case MEMCACHED_E2BIG:
            reason = "Item is too large for the server to store."
            
        case MEMCACHED_END:
            reason = "The server has completed returning all of the objects requested."
            
        case MEMCACHED_ERRNO:
            reason = "An error has occurred in the driver which has set errno."
            
        case MEMCACHED_FAILURE:
            reason = "A unknown failure has occurred in the server."
            
        case MEMCACHED_FAIL_UNIX_SOCKET:
            reason = "A connection was not established with the server via a unix domain socket."
            
        case MEMCACHED_FETCH_NOTFINISHED:
            reason = "A request has been made, but the server has not finished the fetch of the last request."
            
        case MEMCACHED_HOST_LOOKUP_FAILURE:
            reason = "A DNS failure has occurred."
            
        case MEMCACHED_INVALID_ARGUMENTS:
            reason = "The arguments supplied to the given function were not valid."
            
        case MEMCACHED_INVALID_HOST_PROTOCOL:
            reason = "The server you are connecting too has an invalid protocol. Most likely you are connecting to an older server that does not speak the binary protocol."
            
        case MEMCACHED_ITEM:
            reason = "An item has been fetched (this is an internal error only)."
            
        case MEMCACHED_KEY_TOO_BIG:
            reason = "The key that has been provided is too large for the given server."
            
        case MEMCACHED_MAXIMUM_RETURN:
            reason = "This in an internal only state."
            
        case MEMCACHED_MEMORY_ALLOCATION_FAILURE:
            reason = "An error has occurred while trying to allocate memory."
            
        case MEMCACHED_NOTFOUND:
            reason = "The object requested was not found."
            
        case MEMCACHED_NOTSTORED:
            reason = "The request to store an object failed."
            
        case MEMCACHED_NOT_SUPPORTED:
            reason = "The given method is not supported in the server."
            
        case MEMCACHED_NO_KEY_PROVIDED:
            reason = "No key was provided."
            
        case MEMCACHED_NO_SERVERS:
            reason = "No servers have been added to the object."
            
        case MEMCACHED_PARSE_ERROR:
            reason = "An error has occurred while trying to parse the configuration string. You should use memparse to determine what the error was."
            
        case MEMCACHED_PARSE_USER_ERROR:
            reason = "An error has occurred in parsing the configuration string."
            
        case MEMCACHED_PARTIAL_READ:
            reason = "The read was only partcially successful."
            
        case MEMCACHED_PROTOCOL_ERROR:
            reason = "An unknown error has occurred in the protocol."
            
        case MEMCACHED_READ_FAILURE:
            reason = "A read failure has occurred."
            
        case MEMCACHED_SERVER_ERROR:
            reason = "An unknown error has occurred in the server."
            
        case MEMCACHED_SERVER_MARKED_DEAD:
            reason = "The requested server has been marked dead."
            
        case MEMCACHED_SOME_ERRORS:
            reason = "A multi request has been made, and some underterminate number of errors have occurred."
            
        case MEMCACHED_STAT:
            reason = "A “stat” command has been returned in the protocol."
            
        case MEMCACHED_STORED:
            reason = "The requested object has been successfully stored on the server."
            
        case MEMCACHED_TIMEOUT:
            reason = "Operation has timed out."
            
        case MEMCACHED_UNKNOWN_READ_FAILURE:
            reason = "An unknown read failure only occurs when either there is a bug in the server, or in rare cases where an ethernet nic is reporting dubious information."
            
        case MEMCACHED_UNKNOWN_STAT_KEY:
            reason = "The server you are communicating with has a stat key which has not be defined in the protocol."
            
        case MEMCACHED_WRITE_FAILURE:
            reason = "An error has occured while trying to write to a server."
            
        default:
            reason = "Uncnown"
        }
    }
    
    var localizedDescription: String {
        return reason
    }
}

extension  MemcachedError: LocalizedError {
    public var errorDescription: String? {
        return "[Memcached] "+reason
    }
}
