//
//  ThreadSafetyArray.swift
//  ThreadSafetyArraySwift
//
//  Created by Hungju Lu on 06/12/2016.
//  Copyright © 2016 Hungju. All rights reserved.
//

import Cocoa

class ThreadSafetyArray<T: Any> {

    fileprivate lazy var cache = [T]()
    
    fileprivate let queue = DispatchQueue(label: "Array Accessing Queue")
    
    public func array() -> [T] {
        var arr: [T]!
        self.queue.sync() {
            arr = Array<T>(self.cache)
        }
        return arr
    }
    
    public func insert(_ object: T) {
        self.queue.async(flags: .barrier) {
            self.cache.append(object)
        }
    }
    
    public func object(at index: Int) -> T? {
        var obj: T? = nil
        self.queue.sync() {
            obj = self.cache[index]
        }
        return obj
    }
    
    public func remove(at index: Int) {
        _ = self.queue.async(flags: .barrier) {
            self.cache.remove(at: index)
        }
    }
    
    public func removeAll() {
        self.queue.async(flags: .barrier) {
            self.cache.removeAll()
        }
    }
}
