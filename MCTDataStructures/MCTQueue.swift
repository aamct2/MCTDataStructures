//
//  MCTQueue.swift
//  MCTDataStructures
//
//  Created by Aaron McTavish on 8/13/15.
//  Copyright © 2015 Aaron McTavish. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

public class MCTQueue<T : CustomStringConvertible> : CustomStringConvertible, SequenceType {
    private var capacity = 10
    private var items = [T]()
    
    public var size: Int {
        return items.count
    }
    
    public var isEmpty: Bool {
        return items.isEmpty
    }
    
    public var description : String {
        var result = ""
        for curObject in items {
            result += "::\(curObject)"
        }
        
        return result
    }
    
    public init(capacity newCapacity: Int) {
        capacity = newCapacity
    }
    
    public func popObject() -> T? {
        if isEmpty { return nil }
        
        return items.removeAtIndex(0)
    }
    
    public func pushObject(newObject: T) {
        items.append(newObject)
        
        if size > capacity { popObject() }
    }
    
    public func popAll() {
        items.removeAll()
    }
    
    public func peek() -> T? {
        if isEmpty { return nil }
        
        return items[0]
    }
    
    public func bottomPeek() -> T? {
        if isEmpty { return nil }
        
        return items[items.count - 1]
    }
    
    public func queueAsArray() -> [T] {
        return items
    }
    
    public func generate() -> QueueGenerator<T> {
        return QueueGenerator<T>(items: items[0 ..< items.count])
    }
    
    public func copy() -> MCTQueue<T> {
        let newQueue = MCTQueue<T>(capacity: self.capacity)
        
        newQueue.items = self.items
        
        return newQueue
    }
    
}

public struct QueueGenerator<T> : GeneratorType {
    public mutating func next() -> T? {
        if items.isEmpty {return nil}
        
        let ret = items[0]
        items = items[1 ..< items.count]
        
        return ret
    }
    
    var items: ArraySlice<T>
}
