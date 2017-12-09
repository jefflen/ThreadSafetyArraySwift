//
//  main.swift
//  ThreadSafetyArraySwift
//
//  Created by Hungju Lu on 06/12/2016.
//  Copyright © 2016 Hungju. All rights reserved.
//

import Foundation

let arr = ThreadSafetyArray<Int>()

arr.insert(101)
arr.insert(102)


arr.insert(104)

for i in 0..<1000 {
    DispatchQueue.global().async {
        arr.insert(i)
        print("\(i) inserted")
    }
    
    DispatchQueue.global().async {
        print("> start print")
        for num in arr.array() {
            print("\(num)")
        }
        print("^")
    }
}

DispatchQueue.global().async {
    for num in arr.array() {
        print("\(num)")
    }
}

arr.insert(103)

DispatchQueue.global().async {
    for num in arr.array() {
        print("\(num)")
    }
}
