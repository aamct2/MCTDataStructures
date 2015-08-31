//
//  MCTDequeTests.swift
//  MCTDataStructures
//
//  Created by opensource on 8/19/15.
//  Copyright © 2015 Aaron McTavish. All rights reserved.
//

import XCTest
@testable import MCTDataStructures

class MCTDequeTests: XCTestCase {

    var testDeque = MCTDeque<Int>!()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        testDeque = MCTDeque<Int>()
        testDeque.push_back(-1)
        testDeque.push_back(3)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // MARK: - Properties
    
    func testSize() {
        testDeque.push_back(4)
        
        XCTAssertEqual(testDeque.size, 3)
        
        testDeque.pop_back()
        
        XCTAssertEqual(testDeque.size, 2)
        
        testDeque.clear()
        
        XCTAssertEqual(testDeque.size, 0)
    }
    
    func testDescription() {
        XCTAssertEqual(testDeque.description, "::-1::3")
    }
    
    // MARK: - Methods
    
    func testPop_Front() {
        XCTAssertEqual(testDeque.pop_front(), -1)
        XCTAssertEqual(testDeque.pop_front(), 3)
        
        XCTAssertNil(testDeque.pop_front())
    }
    
    func testPop_Back() {
        XCTAssertEqual(testDeque.pop_back(), 3)
        XCTAssertEqual(testDeque.pop_back(), -1)
        
        XCTAssertNil(testDeque.pop_back())
    }
    
    func testPush_Front() {
        var newQueue = MCTDeque<Int>()
        
        newQueue.push_front(-1)
        
        XCTAssertEqual(newQueue.front(), -1)
        
        newQueue.push_front(3)
        newQueue.push_front(4)
        
        XCTAssertEqual(newQueue.front(), 4)
    }
    
    func testPush_Back() {
        var newQueue = MCTDeque<Int>()
        
        newQueue.push_back(-1)
        
        XCTAssertEqual(newQueue.back(), -1)
        
        newQueue.push_back(3)
        newQueue.push_back(4)
        
        XCTAssertEqual(newQueue.back(), 4)
    }
    
    func testClear() {
        testDeque.clear()
        
        XCTAssertEqual(testDeque.size, 0)
    }
    
    func testEraseAtIndex() {
        testDeque.erase(0)
        
        XCTAssertEqual(testDeque.size, 1)
        XCTAssertEqual(testDeque.front(), 3)
    }
    
    func testEraseRange() {
        testDeque.push_back(4)
        
        testDeque.erase(0, endIndex: 2)
        
        XCTAssertEqual(testDeque.size, 1)
        XCTAssertEqual(testDeque.front(), 4)
    }
    
    func testFront() {
        XCTAssertEqual(testDeque.front(), -1)
        
        testDeque.clear()
        
        XCTAssertNil(testDeque.front())
    }
    
    func testBack() {
        XCTAssertEqual(testDeque.back(), 3)
        
        testDeque.clear()
        
        XCTAssertNil(testDeque.back())
    }
    
    func testDequeAsArray() {
        let testArray = testDeque.dequeAsArray()
        
        XCTAssertEqual(testArray.count, 2)
        XCTAssertEqual(testArray[0], -1)
        XCTAssertEqual(testArray[1], 3)
    }
    
    func testReverseDeque() {
        XCTAssertEqual(testDeque.front(), -1)
        
        let result = testDeque.reverseDeque()
        
        XCTAssertEqual(result.front(), 3)
    }
    
    func testGenerator() {
        var result = 0
        
        for item in testDeque {
            result += item
        }
        
        XCTAssertEqual(result, 2)
    }
    
    // MARK: - Logical Operators
    
    func testEquality() {
        var secondQueue = MCTDeque<Int>()
        secondQueue.push_back(-1)
        secondQueue.push_back(3)
        
        XCTAssertTrue(testDeque == secondQueue)
        
        var thirdQueue = MCTDeque<Int>()
        thirdQueue.push_back(2)
        thirdQueue.push_back(3)
        
        XCTAssertFalse(testDeque == thirdQueue)
        
        var fourthQueue = MCTDeque<Int>()
        fourthQueue.push_back(-1)
        
        XCTAssertFalse(testDeque == fourthQueue)
    }
    
    func testInequality() {
        var secondQueue = MCTDeque<Int>()
        secondQueue.push_back(-1)
        secondQueue.push_back(3)
        
        XCTAssertFalse(testDeque != secondQueue)
        
        var thirdQueue = MCTDeque<Int>()
        thirdQueue.push_back(2)
        thirdQueue.push_back(3)
        
        XCTAssertTrue(testDeque != thirdQueue)
        
        var fourthQueue = MCTDeque<Int>()
        fourthQueue.push_back(-1)
        
        XCTAssertTrue(testDeque != fourthQueue)
    }
    
    func testLessThan() {
        var secondQueue = MCTDeque<Int>()
        secondQueue.push_back(-1)
        secondQueue.push_back(3)
        
        XCTAssertFalse(testDeque < secondQueue)
        
        var thirdQueue = MCTDeque<Int>()
        thirdQueue.push_back(2)
        thirdQueue.push_back(3)
        
        XCTAssertTrue(testDeque < thirdQueue)
        
        var fourthQueue = MCTDeque<Int>()
        fourthQueue.push_back(-2)
        
        XCTAssertFalse(testDeque < fourthQueue)
        
        var fifthQueue = MCTDeque<Int>()
        fifthQueue.push_back(-1)
        
        XCTAssertFalse(testDeque < fifthQueue)
    }
    
    func testGreaterThan() {
        var secondQueue = MCTDeque<Int>()
        secondQueue.push_back(-1)
        secondQueue.push_back(3)
        
        XCTAssertFalse(testDeque > secondQueue)
        
        var thirdQueue = MCTDeque<Int>()
        thirdQueue.push_back(2)
        thirdQueue.push_back(3)
        
        XCTAssertFalse(testDeque > thirdQueue)
        
        var fourthQueue = MCTDeque<Int>()
        fourthQueue.push_back(-2)
        
        XCTAssertTrue(testDeque > fourthQueue)
        
        var fifthQueue = MCTDeque<Int>()
        fifthQueue.push_back(-1)
        
        XCTAssertFalse(testDeque > fifthQueue)
    }
    
    func testLessThanOrEqual() {
        var secondQueue = MCTDeque<Int>()
        secondQueue.push_back(-1)
        secondQueue.push_back(3)
        
        XCTAssertTrue(testDeque <= secondQueue)
        
        var thirdQueue = MCTDeque<Int>()
        thirdQueue.push_back(2)
        thirdQueue.push_back(3)
        
        XCTAssertTrue(testDeque <= thirdQueue)
        
        var fourthQueue = MCTDeque<Int>()
        fourthQueue.push_back(-2)
        
        XCTAssertFalse(testDeque <= fourthQueue)
        
        var fifthQueue = MCTDeque<Int>()
        fifthQueue.push_back(-1)
        
        XCTAssertTrue(testDeque <= fifthQueue)
    }
    
    func testGreaterThanOrEqual() {
        var secondQueue = MCTDeque<Int>()
        secondQueue.push_back(-1)
        secondQueue.push_back(3)
        
        XCTAssertTrue(testDeque >= secondQueue)
        
        var thirdQueue = MCTDeque<Int>()
        thirdQueue.push_back(2)
        thirdQueue.push_back(3)
        
        XCTAssertFalse(testDeque >= thirdQueue)
        
        var fourthQueue = MCTDeque<Int>()
        fourthQueue.push_back(-2)
        
        XCTAssertTrue(testDeque >= fourthQueue)
        
        var fifthQueue = MCTDeque<Int>()
        fifthQueue.push_back(-1)
        
        XCTAssertTrue(testDeque >= fifthQueue)
    }

}
