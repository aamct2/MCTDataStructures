//
//  MCTQueue_Tests.swift
//  MCTDataStructures
//
//  Created by opensource on 8/13/15.
//  Copyright © 2015 Aaron McTavish. All rights reserved.
//

import XCTest
@testable import MCTDataStructures

class MCTQueue_Tests: XCTestCase {
    
    var testQueue = MCTQueue<Int>!()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        testQueue = MCTQueue<Int>(capacity: 10)
        testQueue.pushObject(-1)
        testQueue.pushObject(3)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Initializers
    
    func testInit() {
        let sampleSize = 7
        let newQueue = MCTQueue<Int>(capacity: sampleSize)
        
        XCTAssertNotNil(newQueue)
    }
    
    // MARK: - Properties
    
    func testSize() {
        testQueue.pushObject(4)
        
        XCTAssertEqual(testQueue.size, 3)
        
        testQueue.popObject()
        
        XCTAssertEqual(testQueue.size, 2)
        
        testQueue.popAll()
        
        XCTAssertEqual(testQueue.size, 0)
    }
    
    func testDescription() {
        XCTAssertEqual(testQueue.description, "::-1::3")
    }
    
    // MARK: - Methods
    
    func testPopObject() {
        XCTAssertEqual(testQueue.popObject(), -1)
        XCTAssertEqual(testQueue.popObject(), 3)
        
        XCTAssertNil(testQueue.popObject())
    }
    
    func testPushObject() {
        let newQueue = MCTQueue<Int>(capacity: 2)
        
        newQueue.pushObject(-1)
        
        XCTAssertEqual(newQueue.peek(), -1)
        
        newQueue.pushObject(3)
        newQueue.pushObject(4)
        
        XCTAssertEqual(newQueue.size, 2)
        XCTAssertEqual(newQueue.peek(), 3)
    }
    
    func testPopAll() {
        testQueue.popAll()
        
        XCTAssertEqual(testQueue.size, 0)
    }
    
    func testPeek() {
        XCTAssertEqual(testQueue.peek(), -1)
        
        testQueue.popAll()
        
        XCTAssertNil(testQueue.peek())
    }
    
    func testBottomPeek() {
        XCTAssertEqual(testQueue.bottomPeek(), 3)
        
        testQueue.popAll()
        
        XCTAssertNil(testQueue.bottomPeek())
    }
    
    func testQueueAsArray() {
        let testArray = testQueue.queueAsArray()
        
        XCTAssertEqual(testArray.count, 2)
        XCTAssertEqual(testArray[0], -1)
        XCTAssertEqual(testArray[1], 3)
    }
    
    func testGenerator() {
        var result = 0
        
        for item in testQueue {
            result += item
        }
        
        XCTAssertEqual(result, 2)
    }
    
    func testCopy() {
        let newQueue = testQueue.copy()
        
        testQueue.pushObject(4)
        
        XCTAssertEqual(testQueue.size, 3)
        XCTAssertEqual(newQueue.size, 2)
        XCTAssertEqual(newQueue.popObject(), -1)
        XCTAssertEqual(newQueue.popObject(), 3)
    }
    
}
