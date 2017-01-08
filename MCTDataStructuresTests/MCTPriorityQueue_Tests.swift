//
//  MCTPriorityQueue_Tests.swift
//  MCTDataStructures
//
//  Created by opensource on 9/1/15.
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

class MCTPriorityQueue_Tests: XCTestCase {
    
    var testQueue = MCTPriorityQueue<Int>(comp: >)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        testQueue = MCTPriorityQueue<Int>(comp: >)
        testQueue.push(-1)
        testQueue.push(3)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // MARK: - Properties
    
    func testSize() {
        testQueue.push(4)
        
        XCTAssertEqual(testQueue.size, 3)
        
        let _ = testQueue.pop()
        
        XCTAssertEqual(testQueue.size, 2)
        
        testQueue.popAll()
        
        XCTAssertEqual(testQueue.size, 0)
    }
    
    func testDescription() {
        XCTAssertEqual(testQueue.description, "::3::-1")
    }
    
    // MARK: - Methods
    
    func testPopObject() {
        XCTAssertEqual(testQueue.pop(), 3)
        XCTAssertEqual(testQueue.pop(), -1)
        
        XCTAssertNil(testQueue.pop())
    }
    
    func testPushObject() {
        var newQueue = MCTPriorityQueue<Int>(comp: >)
        
        newQueue.push(-1)
        
        XCTAssertEqual(newQueue.top(), -1)
        
        newQueue.push(3)
        newQueue.push(4)
        
        XCTAssertEqual(newQueue.top(), 4)
    }
    
    func testPopAll() {
        testQueue.popAll()
        
        XCTAssertEqual(testQueue.size, 0)
    }
    
    func testPeek() {
        XCTAssertEqual(testQueue.top(), 3)
        
        testQueue.popAll()
        
        XCTAssertNil(testQueue.top())
    }
    
    func testQueueAsArray() {
        let testArray = testQueue.queueAsArray()
        
        XCTAssertEqual(testArray.count, 2)
        XCTAssertEqual(testArray[0], 3)
        XCTAssertEqual(testArray[1], -1)
    }
    
    func testGenerator() {
        var result = 0
        
        for item in testQueue {
            result += item
        }
        
        XCTAssertEqual(result, 2)
    }
    
    // MARK: - Logical Operators
    
    func testEquality() {
        var secondQueue = MCTPriorityQueue<Int>(comp: >)
        secondQueue.push(-1)
        secondQueue.push(3)
        
        XCTAssertTrue(testQueue == secondQueue)
        
        var thirdQueue = MCTPriorityQueue<Int>(comp: >)
        thirdQueue.push(2)
        thirdQueue.push(3)
        
        XCTAssertFalse(testQueue == thirdQueue)
        
        var fourthQueue = MCTPriorityQueue<Int>(comp: >)
        fourthQueue.push(-1)
        
        XCTAssertFalse(testQueue == fourthQueue)
    }
    
    func testInequality() {
        var secondQueue = MCTPriorityQueue<Int>(comp: >)
        secondQueue.push(-1)
        secondQueue.push(3)
        
        XCTAssertFalse(testQueue != secondQueue)
        
        var thirdQueue = MCTPriorityQueue<Int>(comp: >)
        thirdQueue.push(2)
        thirdQueue.push(3)
        
        XCTAssertTrue(testQueue != thirdQueue)
        
        var fourthQueue = MCTPriorityQueue<Int>(comp: >)
        fourthQueue.push(-1)
        
        XCTAssertTrue(testQueue != fourthQueue)
    }
    
    func testLessThan() {
        var secondQueue = MCTPriorityQueue<Int>(comp: >)
        secondQueue.push(-1)
        secondQueue.push(3)
        
        XCTAssertFalse(testQueue < secondQueue)
        
        var thirdQueue = MCTPriorityQueue<Int>(comp: >)
        thirdQueue.push(2)
        thirdQueue.push(3)
        
        XCTAssertTrue(testQueue < thirdQueue)
        
        var fourthQueue = MCTPriorityQueue<Int>(comp: >)
        fourthQueue.push(-2)
        
        XCTAssertFalse(testQueue < fourthQueue)
        
        var fifthQueue = MCTPriorityQueue<Int>(comp: >)
        fifthQueue.push(-1)
        
        XCTAssertFalse(testQueue < fifthQueue)
        
        let sixthQueue = MCTPriorityQueue<Int>(comp: >)
        XCTAssertFalse(testQueue < sixthQueue)
    }
    
    func testGreaterThan() {
        var secondQueue = MCTPriorityQueue<Int>(comp: >)
        secondQueue.push(-1)
        secondQueue.push(3)
        
        XCTAssertFalse(testQueue > secondQueue)
        
        var thirdQueue = MCTPriorityQueue<Int>(comp: >)
        thirdQueue.push(2)
        thirdQueue.push(3)
        
        XCTAssertFalse(testQueue > thirdQueue)
        
        var fourthQueue = MCTPriorityQueue<Int>(comp: >)
        fourthQueue.push(-2)
        
        XCTAssertTrue(testQueue > fourthQueue)
        
        var fifthQueue = MCTPriorityQueue<Int>(comp: >)
        fifthQueue.push(-1)
        
        XCTAssertTrue(testQueue > fifthQueue)
    }
    
    func testLessThanOrEqual() {
        var secondQueue = MCTPriorityQueue<Int>(comp: >)
        secondQueue.push(-1)
        secondQueue.push(3)
        
        XCTAssertTrue(testQueue <= secondQueue)
        
        var thirdQueue = MCTPriorityQueue<Int>(comp: >)
        thirdQueue.push(2)
        thirdQueue.push(3)
        
        XCTAssertTrue(testQueue <= thirdQueue)
        
        var fourthQueue = MCTPriorityQueue<Int>(comp: >)
        fourthQueue.push(-2)
        
        XCTAssertFalse(testQueue <= fourthQueue)
        
        var fifthQueue = MCTPriorityQueue<Int>(comp: >)
        fifthQueue.push(-1)
        
        XCTAssertFalse(testQueue <= fifthQueue)
    }
    
    func testGreaterThanOrEqual() {
        var secondQueue = MCTPriorityQueue<Int>(comp: >)
        secondQueue.push(-1)
        secondQueue.push(3)
        
        XCTAssertTrue(testQueue >= secondQueue)
        
        var thirdQueue = MCTPriorityQueue<Int>(comp: >)
        thirdQueue.push(2)
        thirdQueue.push(3)
        
        XCTAssertFalse(testQueue >= thirdQueue)
        
        var fourthQueue = MCTPriorityQueue<Int>(comp: >)
        fourthQueue.push(-2)
        
        XCTAssertTrue(testQueue >= fourthQueue)
        
        var fifthQueue = MCTPriorityQueue<Int>(comp: >)
        fifthQueue.push(-1)
        
        XCTAssertTrue(testQueue >= fifthQueue)
    }
    
}
