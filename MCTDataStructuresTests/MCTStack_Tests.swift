//
//  MCTStack_Tests.swift
//  MCTDataStructures
//
//  Created by opensource on 8/13/15.
//  Copyright © 2015 Aaron McTavish. All rights reserved.
//

import XCTest
@testable import MCTDataStructures

class MCTStack_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
    
}
