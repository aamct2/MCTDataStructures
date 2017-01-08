//
//  MCTDeque.swift
//  MCTDataStructures
//
//  Created by opensource on 8/19/15.
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

/// Generic implementation of a double-ended queue collection.
public struct MCTDeque<Element : CustomStringConvertible> : CustomStringConvertible, Sequence {
    
    // MARK: - Properties
    
    /// Underlying container (array) representation of deque.
    fileprivate var items = [Element]()
    
    /// The number of elements in the deque.
    public var size: Int {
        return items.count
    }
    
    /// Test whether the deque is empty.
    public var empty: Bool {
        return items.isEmpty
    }
    
    
    // MARK: - C++11 Functions
    
    /**
    Remove the last element of the deque.
    
    - returns: The last element of the deque, if it exists.
    */
    public mutating func pop_back() -> Element? {
        if empty { return nil }
        
        return items.remove(at: size - 1)
    }
    
    /**
    Remove the first element of the deque.
    
    - returns: The first element of the deque, if it exists.
    */
    public mutating func pop_front() -> Element? {
        if empty { return nil }
        
        return items.remove(at: 0)
    }
    
    /**
    Insert element at the end of the deque.
    
    - parameter newObject: Element to push onto the deque.
    */
    public mutating func push_back(_ newObject: Element) {
        items.append(newObject)
    }
    
    /**
    Insert element at the beginning of the deque.
    
    - parameter newObject: Element to push onto the deque.
    */
    public mutating func push_front(_ newObject: Element) {
        items.insert(newObject, at: 0)
    }
    
    /**
    Access the next element of the deque without removing it.
    
    - returns: The next element of the deque, if it exists.
    */
    public func front() -> Element? {
        if empty { return nil }
        
        return items[0]
    }
    
    /**
    Access the last element of the deque without removing it.
    
    - returns: The last element of the deque, if it exists.
    */
    public func back() -> Element? {
        if empty { return nil }
        
        return items[size - 1]
    }
    
    /**
    Removes all elements from the deque.
    */
    public mutating func clear() {
        items.removeAll()
    }
    
    /**
    Removes an element at a specific index.
    
    - parameter index: Index at which to remove the element.
    */
    public mutating func erase(_ index: Int) {
        guard index >= 0 && index < size else { return }
        
        items.remove(at: index)
    }
    
    /**
    Removes a range of elements inclusive of the `startIndex` and exclusive of the `endIndex`. Effectively, it is the range [`startIndex`, `endIndex`).
    
    - parameter startIndex: Index of first object to remove.
    - parameter endIndex:   Index after the last object to remove.
    */
    public mutating func erase(_ startIndex: Int, endIndex: Int) {
        guard startIndex >= 0 && startIndex < size &&
            endIndex > startIndex && endIndex <= size else { return }
        
        items.removeSubrange(startIndex ..< endIndex)
    }
    
}

// MARK: - Additional Convenience Functions

public extension MCTDeque {
    
    /// A text representation of the deque.
    public var description : String {
        var result = ""
        for curObject in items {
            result += "::\(curObject)"
        }
        
        return result
    }
    
    /**
    Returns a `MCTDeque` containing the elements of `self` in reverse order.
    
    - returns: A `MCTDeque` containing the elements of `self` in reverse order.
    */
    public func reverseDeque() -> MCTDeque<Element> {
        var newDeque = MCTDeque<Element>()
        
        newDeque.items = items.reversed()
        
        return newDeque
    }
    
    /**
    Returns the deque as an array object.
    
    - returns: Array representation of the deque.
    */
    public func dequeAsArray() -> [Element] {
        return items
    }
    
    /// Return a *generator* over the elements.
    ///
    /// - Complexity: O(1).
    public func makeIterator() -> MCTDequeGenerator<Element> {
        return MCTDequeGenerator<Element>(items: items[0 ..< items.count])
    }
    
}


// MARK: - Deque Generator Type

public struct MCTDequeGenerator<Element> : IteratorProtocol {
    public mutating func next() -> Element? {
        if items.isEmpty {return nil}
        
        let ret = items.first
        items.removeFirst()
        
        return ret
    }
    
    var items: ArraySlice<Element>
}


// MARK: - Relational Operators for Deques

/**
Returns true if these deques contain the same elements.

- parameter lhs: The left-hand deque.
- parameter rhs: The right-hand deque.

- returns: True if these deques contain the same elements. Otherwise returns false.
*/
public func ==<Element: Equatable>(lhs: MCTDeque<Element>, rhs: MCTDeque<Element>) -> Bool {
    guard lhs.size == rhs.size else { return false }
    
    for index in 0 ..< lhs.size {
        if lhs.items[index] != rhs.items[index] { return false }
    }
    
    return true
}

/**
Returns result of equivalent operation !(lhs == rhs).

- parameter lhs: The left-hand deque.
- parameter rhs: The right-hand deque.

- returns: Returns result of equivalent operation !(lhs == rhs).
*/
public func !=<Element: Equatable>(lhs: MCTDeque<Element>, rhs: MCTDeque<Element>) -> Bool {
    return !(lhs == rhs)
}

/**
Compares elements sequentially using operator< and stops at the first occurance where a<b or b<a.

- parameter lhs: The left-hand deque.
- parameter rhs: The right-hand deque.

- returns: Returns true if the first element in which the deques differ, the left hand element is less than the right hand element. Otherwise returns false.
*/
public func <<Element: Comparable>(lhs: MCTDeque<Element>, rhs: MCTDeque<Element>) -> Bool {
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

- parameter lhs: The left-hand deque.
- parameter rhs: The right-hand deque.

- returns: Returns result of equivalent operation rhs < lhs.
*/
public func ><Element: Comparable>(lhs: MCTDeque<Element>, rhs: MCTDeque<Element>) -> Bool {
    return rhs < lhs
}

/**
Returns result of equivalent operation !(rhs < lhs).

- parameter lhs: The left-hand deque.
- parameter rhs: The right-hand deque.

- returns: Returns result of equivalent operation !(rhs < lhs).
*/
public func <=<Element: Comparable>(lhs: MCTDeque<Element>, rhs: MCTDeque<Element>) -> Bool {
    return !(rhs < lhs)
}

/**
Returns result of equivalent operation !(lhs < rhs).

- parameter lhs: The left-hand deque.
- parameter rhs: The right-hand deque.

- returns: Returns result of equivalent operation !(lhs < rhs).
*/
public func >=<Element: Comparable>(lhs: MCTDeque<Element>, rhs: MCTDeque<Element>) -> Bool {
    return !(lhs < rhs)
}
