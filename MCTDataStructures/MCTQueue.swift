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

/// Generic implementation of a First In First Out (FIFO) queue collection.
public struct MCTQueue<Element : CustomStringConvertible> : CustomStringConvertible, SequenceType {
    
    // MARK: - Properties
    
    /// Underlying container (array) representation of queue.
    private var items = [Element]()
    
    /// The number of elements in the queue.
    public var size: Int {
        return items.count
    }
    
    /// Test whether the queue is empty.
    public var empty: Bool {
        return items.isEmpty
    }
    
    
    // MARK: - C++11 Functions
    
    /**
    Remove the first element of the queue.
    
    - returns: The first element of the queue, if it exists.
    */
    public mutating func pop() -> Element? {
        if empty { return nil }
        
        return items.removeAtIndex(0)
    }
    
    /**
    Insert element at the end of the queue.
    
    - parameter newObject: Element to push onto the queue.
    */
    public mutating func push(newObject: Element) {
        items.append(newObject)
    }
    
    /**
    Access the next element of the queue without removing it.
    
    - returns: The next element of the queue, if it exists.
    */
    public func front() -> Element? {
        if empty { return nil }
        
        return items[0]
    }
    
    /**
    Access the last element of the queue without removing it.
    
    - returns: The last element of the queue, if it exists.
    */
    public func back() -> Element? {
        if empty { return nil }
        
        return items[size - 1]
    }
    
}

// MARK: - Additional Convenience Functions

public extension MCTQueue {
    
    /// A text representation of the queue.
    public var description : String {
        var result = ""
        for curObject in items {
            result += "::\(curObject)"
        }
        
        return result
    }
    
    /**
    Removes all elements from the queue.
    */
    public mutating func popAll() {
        items.removeAll()
    }
    
    /**
    Returns the queue as an array object.
    
    - returns: Array representation of the queue.
    */
    public func queueAsArray() -> [Element] {
        return items
    }
    
    public func generate() -> MCTQueueGenerator<Element> {
        return MCTQueueGenerator<Element>(items: items[0 ..< items.count])
    }
    
}


// MARK: - Queue Generator Type

public struct MCTQueueGenerator<Element> : GeneratorType {
    public mutating func next() -> Element? {
        if items.isEmpty {return nil}
        
        let ret = items.first
        items.removeFirst()
        
        return ret
    }
    
    var items: ArraySlice<Element>
}


// MARK: - Relational Operators

/**
Returns true if these queues contain the same elements.

- parameter lhs: The left-hand queue.
- parameter rhs: The right-hand queue.

- returns: True if these queues contain the same elements. Otherwise returns false.
*/
public func ==<Element: Equatable>(lhs: MCTQueue<Element>, rhs: MCTQueue<Element>) -> Bool {
    guard lhs.size == rhs.size else { return false }
    
    for index in 0 ..< lhs.size {
        if lhs.items[index] != rhs.items[index] { return false }
    }
    
    return true
}

/**
Returns result of equivalent operation !(lhs == rhs).

- parameter lhs: The left-hand queue.
- parameter rhs: The right-hand queue.

- returns: Returns result of equivalent operation !(lhs == rhs).
*/
public func !=<Element: Equatable>(lhs: MCTQueue<Element>, rhs: MCTQueue<Element>) -> Bool {
    return !(lhs == rhs)
}

/**
Compares elements sequentially using operator< and stops at the first occurance where a<b or b<a.

- parameter lhs: The left-hand queue.
- parameter rhs: The right-hand queue.

- returns: Returns true if the first element in which the queues differ, the left hand element is less than the right hand element. Otherwise returns false.
*/
public func <<Element: Comparable>(lhs: MCTQueue<Element>, rhs: MCTQueue<Element>) -> Bool {
    for index in 0 ..< lhs.size {
        if index >= rhs.size { return false }
        
        if lhs.items[index] < rhs.items[index] {
            return true
        } else if rhs.items[index] < lhs.items[index] {
            return false
        }
    }
    
    return false
}

/**
Returns result of equivalent operation rhs < lhs.

- parameter lhs: The left-hand queue.
- parameter rhs: The right-hand queue.

- returns: Returns result of equivalent operation rhs < lhs.
*/
public func ><Element: Comparable>(lhs: MCTQueue<Element>, rhs: MCTQueue<Element>) -> Bool {
    return rhs < lhs
}

/**
Returns result of equivalent operation !(rhs < lhs).

- parameter lhs: The left-hand queue.
- parameter rhs: The right-hand queue.

- returns: Returns result of equivalent operation !(rhs < lhs).
*/
public func <=<Element: Comparable>(lhs: MCTQueue<Element>, rhs: MCTQueue<Element>) -> Bool {
    return !(rhs < lhs)
}

/**
Returns result of equivalent operation !(lhs < rhs).

- parameter lhs: The left-hand queue.
- parameter rhs: The right-hand queue.

- returns: Returns result of equivalent operation !(lhs < rhs).
*/
public func >=<Element: Comparable>(lhs: MCTQueue<Element>, rhs: MCTQueue<Element>) -> Bool {
    return !(lhs < rhs)
}
