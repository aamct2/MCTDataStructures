//
//  MCTStack.swift
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

/// Generic implementation of a Last In First Out (LIFO) stack collection.
public struct MCTStack<Element> : CustomStringConvertible, SequenceType {
    
    // MARK: - Properties
    
    /// Underlying container (array) representation of stack.
    private var items = [Element]()
    
    /// The number of elements in the stack.
    public var size: Int {
        return items.count
    }
    
    /// Test whether the stack is empty.
    public var empty: Bool {
        return items.isEmpty
    }
    
    // MARK: - C++11 Functions
    
    /**
    Remove the top element of the stack.
    
    - returns: The top element of the stack, if it exists.
    */
    public mutating func pop() -> Element? {
        if empty { return nil }
        
        return items.removeLast()
    }
    
    /**
    Insert element on top of the stack.
    
    - parameter newObject: Element to push onto the stack.
    */
    public mutating func push(newObject: Element) {
        items.append(newObject)
    }
    
    /**
    Access the top element of the stack without removing it.
    
    - returns: The top element of the stack, if it exists.
    */
    public func top() -> Element? {
        if empty { return nil }
        
        return items[size - 1]
    }
    
}


// MARK: - Additional Convenience Functions

public extension MCTStack {
    /// A text representation of the stack.
    public var description : String {
        var result = ""
        for curObject in items {
            result += "::\(curObject)"
        }
        
        return result
    }
    
    /**
    Removes all elements from the stack.
    */
    public mutating func popAll() {
        items.removeAll()
    }
    
    /**
    Returns a `MCTStack` containing the elements of `self` in reverse order.
    
    - returns: A `MCTStack` containing the elements of `self` in reverse order.
    */
    public func reverseStack() -> MCTStack<Element> {
        var newStack = MCTStack<Element>()
        
        newStack.items = items.reverse()
        
        return newStack
    }
    
    /**
    Returns the stack as an array object.
    
    - returns: Array representation of the stack.
    */
    public func stackAsArray() -> [Element] {
        return items
    }
    
    public func generate() -> MCTStackGenerator<Element> {
        return MCTStackGenerator<Element>(items: items[0 ..< items.count])
    }
}


// MARK: - Stack Generator Type

public struct MCTStackGenerator<Element> : GeneratorType {
    public mutating func next() -> Element? {
        if items.isEmpty {return nil}
        
        let ret = items[0]
        items = items[1 ..< items.count]
        
        return ret
    }
    
    var items: ArraySlice<Element>
}


// MARK: - Relational Operators

/**
Returns true if these stacks contain the same elements.

- parameter lhs: The left-hand stack.
- parameter rhs: The right-hand stack.

- returns: True if these stacks contain the same elements. Otherwise returns false.
*/
public func ==<Element: Equatable>(lhs: MCTStack<Element>, rhs: MCTStack<Element>) -> Bool {
    guard lhs.size == rhs.size else { return false }
    
    for index in 0 ..< lhs.size {
        if lhs.items[index] != rhs.items[index] { return false }
    }
    
    return true
}

/**
Returns result of equivalent operation !(lhs == rhs).

- parameter lhs: The left-hand stack.
- parameter rhs: The right-hand stack.

:returns: Returns result of equivalent operation !(lhs == rhs).
*/
public func !=<Element: Equatable>(lhs: MCTStack<Element>, rhs: MCTStack<Element>) -> Bool {
    return !(lhs == rhs)
}

/**
Compares elements sequentially using operator< and stops at the first occurance where a<b or b<a.

- parameter lhs: The left-hand stack.
- parameter rhs: The right-hand stack.

- returns: Returns true if the first element in which the stacks differ, the left hand element is less than the right hand element. Otherwise returns false.
*/
public func <<Element: Comparable>(lhs: MCTStack<Element>, rhs: MCTStack<Element>) -> Bool {
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

- parameter lhs: The left-hand stack.
- parameter rhs: The right-hand stack.

- returns: Returns result of equivalent operation rhs < lhs.
*/
public func ><Element: Comparable>(lhs: MCTStack<Element>, rhs: MCTStack<Element>) -> Bool {
    return rhs < lhs
}

/**
Returns result of equivalent operation !(rhs < lhs).

- parameter lhs: The left-hand stack.
- parameter rhs: The right-hand stack.

- returns: Returns result of equivalent operation !(rhs < lhs).
*/
public func <=<Element: Comparable>(lhs: MCTStack<Element>, rhs: MCTStack<Element>) -> Bool {
    return !(rhs < lhs)
}

/**
Returns result of equivalent operation !(lhs < rhs).

- parameter lhs: The left-hand stack.
- parameter rhs: The right-hand stack.

- returns: Returns result of equivalent operation !(lhs < rhs).
*/
public func >=<Element: Comparable>(lhs: MCTStack<Element>, rhs: MCTStack<Element>) -> Bool {
    return !(lhs < rhs)
}
