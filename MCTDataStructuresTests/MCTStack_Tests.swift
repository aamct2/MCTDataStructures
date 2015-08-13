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
        testStack.pushObject(-1)
        testStack.pushObject(3)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Initializers
    
    func testInit() {
        let emptyStack = MCTStack<Int>()
        
        XCTAssertNotNil(emptyStack)
    }
    
    // MARK: - Properties
    
    func testSize() {
        testStack.pushObject(4)
        
        XCTAssertEqual(testStack.size, 3)
        
        testStack.popObject()
        
        XCTAssertEqual(testStack.size, 2)
        
        testStack.popAll()
        
        XCTAssertEqual(testStack.size, 0)
    }
    
    func testIsEmpty() {
        XCTAssertFalse(testStack.isEmpty)
        
        testStack.popAll()
        
        XCTAssertTrue(testStack.isEmpty)
    }
    
    func testDescription() {
        XCTAssertEqual(testStack.description, "::-1::3")
    }
    
    // MARK: - Methods
    
    func testPopObject() {
        XCTAssertEqual(testStack.popObject(), 3)
        XCTAssertEqual(testStack.popObject(), -1)
        
        XCTAssertNil(testStack.popObject())
    }
    
    func testPushObject() {
        let newStack = MCTStack<Int>()
        
        newStack.pushObject(-1)
        newStack.pushObject(3)
        
        XCTAssertEqual(newStack.peek(), 3)
    }
    
    func testPopAll() {
        testStack.popAll()
        
        XCTAssertEqual(testStack.size, 0)
    }
    
    func testPeek() {
        XCTAssertEqual(testStack.peek(), 3)
        
        testStack.popAll()
        
        XCTAssertNil(testStack.peek())
    }
    
    func testReverseStack() {
        XCTAssertEqual(testStack.peek(), 3)
        
        testStack.reverseStack()
        
        XCTAssertEqual(testStack.peek(), -1)
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
    
    func testCopy() {
        let newStack = testStack.copy()
        
        testStack.pushObject(4)
        
        XCTAssertEqual(testStack.size, 3)
        XCTAssertEqual(newStack.size, 2)
        XCTAssertEqual(newStack.popObject(), 3)
        XCTAssertEqual(newStack.popObject(), -1)
    }
    
}
