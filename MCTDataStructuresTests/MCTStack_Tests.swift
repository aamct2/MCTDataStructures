//
//  MCTStack_Tests.swift
//  MCTDataStructures
//
//  Created by opensource on 8/13/15.
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

import XCTest
@testable import MCTDataStructures

class MCTStack_Tests: XCTestCase {
    
    var testStack = MCTStack<Int>!()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        testStack = MCTStack<Int>()
        testStack.push(-1)
        testStack.push(3)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Properties
    
    func testSize() {
        testStack.push(4)
        
        XCTAssertEqual(testStack.size, 3)
        
        testStack.pop()
        
        XCTAssertEqual(testStack.size, 2)
        
        testStack.popAll()
        
        XCTAssertEqual(testStack.size, 0)
    }
    
    func testEmpty() {
        XCTAssertFalse(testStack.empty)
        
        testStack.popAll()
        
        XCTAssertTrue(testStack.empty)
    }
    
    func testDescription() {
        XCTAssertEqual(testStack.description, "::-1::3")
    }
    
    // MARK: - Methods
    
    func testPop() {
        XCTAssertEqual(testStack.pop(), 3)
        XCTAssertEqual(testStack.pop(), -1)
        
        XCTAssertNil(testStack.pop())
    }
    
    func testPush() {
        var newStack = MCTStack<Int>()
        
        newStack.push(-1)
        newStack.push(3)
        
        XCTAssertEqual(newStack.top(), 3)
    }
    
    func testPopAll() {
        testStack.popAll()
        
        XCTAssertEqual(testStack.size, 0)
    }
    
    func testTop() {
        XCTAssertEqual(testStack.top(), 3)
        
        testStack.popAll()
        
        XCTAssertNil(testStack.top())
    }
    
    func testReverseStack() {
        XCTAssertEqual(testStack.top(), 3)
        
        let result = testStack.reverseStack()
        
        XCTAssertEqual(result.top(), -1)
    }
    
    func testStackAsArray() {
        let testArray = testStack.stackAsArray()
        
        XCTAssertEqual(testArray.count, 2)
        XCTAssertEqual(testArray[0], -1)
        XCTAssertEqual(testArray[1], 3)
    }
    
    func testGenerator() {
        var result = 0
        
        for item in testStack {
            result += item
        }
        
        XCTAssertEqual(result, 2)
    }
    
    // MARK: - Logical Operators
    
    func testEquality() {
        var secondStack = MCTStack<Int>()
        secondStack.push(-1)
        secondStack.push(3)
        
        XCTAssertTrue(testStack == secondStack)
        
        var thirdStack = MCTStack<Int>()
        thirdStack.push(2)
        thirdStack.push(3)
        
        XCTAssertFalse(testStack == thirdStack)
        
        var fourthStack = MCTStack<Int>()
        fourthStack.push(-1)
        
        XCTAssertFalse(testStack == fourthStack)
    }
    
    func testInequality() {
        var secondStack = MCTStack<Int>()
        secondStack.push(-1)
        secondStack.push(3)
        
        XCTAssertFalse(testStack != secondStack)
        
        var thirdStack = MCTStack<Int>()
        thirdStack.push(2)
        thirdStack.push(3)
        
        XCTAssertTrue(testStack != thirdStack)
        
        var fourthStack = MCTStack<Int>()
        fourthStack.push(-1)
        
        XCTAssertTrue(testStack != fourthStack)
    }
    
    func testLessThan() {
        var secondStack = MCTStack<Int>()
        secondStack.push(-1)
        secondStack.push(3)
        
        XCTAssertFalse(testStack < secondStack)
        
        var thirdStack = MCTStack<Int>()
        thirdStack.push(2)
        thirdStack.push(3)
        
        XCTAssertTrue(testStack < thirdStack)
        
        var fourthStack = MCTStack<Int>()
        fourthStack.push(-2)
        
        XCTAssertFalse(testStack < fourthStack)
        
        var fifthStack = MCTStack<Int>()
        fifthStack.push(-1)
        
        XCTAssertFalse(testStack < fifthStack)
    }
    
    func testGreaterThan() {
        var secondStack = MCTStack<Int>()
        secondStack.push(-1)
        secondStack.push(3)
        
        XCTAssertFalse(testStack > secondStack)
        
        var thirdStack = MCTStack<Int>()
        thirdStack.push(2)
        thirdStack.push(3)
        
        XCTAssertFalse(testStack > thirdStack)
        
        var fourthStack = MCTStack<Int>()
        fourthStack.push(-2)
        
        XCTAssertTrue(testStack > fourthStack)
        
        var fifthStack = MCTStack<Int>()
        fifthStack.push(-1)
        
        XCTAssertFalse(testStack > fifthStack)
    }
    
    func testLessThanOrEqual() {
        var secondStack = MCTStack<Int>()
        secondStack.push(-1)
        secondStack.push(3)
        
        XCTAssertTrue(testStack <= secondStack)
        
        var thirdStack = MCTStack<Int>()
        thirdStack.push(2)
        thirdStack.push(3)
        
        XCTAssertTrue(testStack <= thirdStack)
        
        var fourthStack = MCTStack<Int>()
        fourthStack.push(-2)
        
        XCTAssertFalse(testStack <= fourthStack)
        
        var fifthStack = MCTStack<Int>()
        fifthStack.push(-1)
        
        XCTAssertTrue(testStack <= fifthStack)
    }
    
    func testGreaterThanOrEqual() {
        var secondStack = MCTStack<Int>()
        secondStack.push(-1)
        secondStack.push(3)
        
        XCTAssertTrue(testStack >= secondStack)
        
        var thirdStack = MCTStack<Int>()
        thirdStack.push(2)
        thirdStack.push(3)
        
        XCTAssertFalse(testStack >= thirdStack)
        
        var fourthStack = MCTStack<Int>()
        fourthStack.push(-2)
        
        XCTAssertTrue(testStack >= fourthStack)
        
        var fifthStack = MCTStack<Int>()
        fifthStack.push(-1)
        
        XCTAssertTrue(testStack >= fifthStack)
    }
    
}
