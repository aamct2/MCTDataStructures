//
//  MCTPriorityQueue.swift
//  MCTDataStructures
//
//  Created by opensource on 8/31/15.
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

/// Generic implementation of a priority queue collection.
public struct MCTPriorityQueue<Element : CustomStringConvertible> : CustomStringConvertible, SequenceType {

    // MARK: - Properties
    
    /// Underlying container (array) representation of queue. Array is arranged as a heap.
    private var items = [Element]()
    
    /// Comparator for elements used in ordering the priority queue. Returns true if `lhs` should come before `rhs`.
    private var comp: (lhs: Element, rhs: Element) -> (Bool)
    
    /// The number of elements in the queue.
    public var size: Int {
        return items.count
    }
    
    /// Test whether the queue is empty.
    public var empty: Bool {
        return items.isEmpty
    }
    
    
    // MARK: - Initializers
    
    /**
    Initializer for priority queue.
    
    - parameter comp: Comparison closure. Return true if `lhs` should come before `rhs`.
    */
    init(comp : (lhs: Element, rhs: Element) -> (Bool)) {
        self.comp = comp
    }
    
    
    // MARK: - C++11 Functions
    
    /**
    Remove the first element of the priority queue.
    
    - returns: The first element of the priority queue, if it exists.
    */
    public mutating func pop() -> Element? {
        if empty { return nil }
        
        return items.removeAtIndex(0)
    }
    
    /**
    Insert element at the end of the priority queue. Then reorders the queue.
    
    - parameter newObject: Element to push onto the priority queue.
    */
    public mutating func push(newObject: Element) {
        items.append(newObject)
        items.sortInPlace(comp)
    }
    
    /**
    Access the next element of the priority queue without removing it.
    
    - returns: The next element of the priority queue, if it exists.
    */
    public func top() -> Element? {
        if empty { return nil }
        
        return items[0]
    }
    
}


// MARK: - Additional Convenience Functions

public extension MCTPriorityQueue {
    
    /// A text representation of the queue.
    public var description : String {
        var result = ""
        for curObject in items {
            result += "::\(curObject)"
        }
        
        return result
    }
    
    /**
    Removes all elements from the priority queue.
    */
    public mutating func popAll() {
        items.removeAll()
    }
    
    /**
    Returns the priority queue as an array object.
    
    - returns: Array representation of the priority queue.
    */
    public func queueAsArray() -> [Element] {
        return items
    }
    
    public func generate() -> MCTPriorityQueueGenerator<Element> {
        return MCTPriorityQueueGenerator<Element>(items: items[0 ..< items.count])
    }
    
}


// MARK: - Priority Queue Generator Type

public struct MCTPriorityQueueGenerator<Element> : GeneratorType {
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
Returns true if these priority queues contain the same elements.

- parameter lhs: The left-hand priority queue.
- parameter rhs: The right-hand priority queue.

- returns: True if these priority queues contain the same elements. Otherwise returns false.
*/
public func ==<Element: Equatable>(lhs: MCTPriorityQueue<Element>, rhs: MCTPriorityQueue<Element>) -> Bool {
    guard lhs.size == rhs.size else { return false }
    
    for index in 0 ..< lhs.size {
        if lhs.items[index] != rhs.items[index] { return false }
    }
    
    return true
}

/**
Returns result of equivalent operation !(lhs == rhs).

- parameter lhs: The left-hand priority queue.
- parameter rhs: The right-hand priority queue.

- returns: Returns result of equivalent operation !(lhs == rhs).
*/
public func !=<Element: Equatable>(lhs: MCTPriorityQueue<Element>, rhs: MCTPriorityQueue<Element>) -> Bool {
    return !(lhs == rhs)
}

/**
Compares elements sequentially using operator< and stops at the first occurance where a<b or b<a.

- parameter lhs: The left-hand priority queue.
- parameter rhs: The right-hand priority queue.

- returns: Returns true if the first element in which the priority queues differ, the left hand element is less than the right hand element. Otherwise returns false.
*/
public func <<Element: Comparable>(lhs: MCTPriorityQueue<Element>, rhs: MCTPriorityQueue<Element>) -> Bool {
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

- parameter lhs: The left-hand priority queue.
- parameter rhs: The right-hand priority queue.

- returns: Returns result of equivalent operation rhs < lhs.
*/
public func ><Element: Comparable>(lhs: MCTPriorityQueue<Element>, rhs: MCTPriorityQueue<Element>) -> Bool {
    return rhs < lhs
}

/**
Returns result of equivalent operation !(rhs < lhs).

- parameter lhs: The left-hand priority queue.
- parameter rhs: The right-hand priority queue.

- returns: Returns result of equivalent operation !(rhs < lhs).
*/
public func <=<Element: Comparable>(lhs: MCTPriorityQueue<Element>, rhs: MCTPriorityQueue<Element>) -> Bool {
    return !(rhs < lhs)
}

/**
Returns result of equivalent operation !(lhs < rhs).

- parameter lhs: The left-hand priority queue.
- parameter rhs: The right-hand priority queue.

- returns: Returns result of equivalent operation !(lhs < rhs).
*/
public func >=<Element: Comparable>(lhs: MCTPriorityQueue<Element>, rhs: MCTPriorityQueue<Element>) -> Bool {
    return !(lhs < rhs)
}
