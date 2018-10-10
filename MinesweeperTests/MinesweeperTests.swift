//
//  MinesweeperTests.swift
//  MinesweeperTests
//
//  Created by wmoodn on 2018/07/26.
//  Copyright © 2018年 wmoodn. All rights reserved.
//

import XCTest
@testable import Minesweeper

class MinesweeperTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        let panel = PanelController()
        panel.Initialize(view: UIView(), XY: 10, bom: 1000)
        panel.Initialize(view: UIView(), XY: 10, bom: 0)
  
    }
    
}
