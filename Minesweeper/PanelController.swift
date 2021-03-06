//
//  PanelController.swift
//  Minesweeper
//
//  Created by wmoodn on 2018/07/26.
//  Copyright © 2018年 wmoodn. All rights reserved.
//

import Foundation
import UIKit
class PanelController{
    
    var panel = [[Panel]]()
    
    init() {
        
    }
    
    func Initialize(view:UIView,XY:Int,bom:Int) {
        for p1 in panel {
            for p in p1{
                p.removeFromSuperview()
            }
        }
        panel = [[Panel]](repeating: [Panel](repeating: Panel(), count: XY), count: XY)
        let size = Double(UIScreen.main.bounds.width-10) / Double(XY+2)
        var posX = Double(UIScreen.main.bounds.width)/2 - (size * Double(XY))  / 2 + size
        if XY == 30 { posX -= size }
        let posY = Double(UIScreen.main.bounds.height / 2) - (size * Double(XY))  / 2 - Double(XY) / 2 - 75
        for x in 1...XY {
            for y in 1...XY {
                let TestView = Panel()
                TestView.Initialize(frame: CGRect.init(x: posX + (size + 1) * Double(x-2), y: Double(posY +
                    (size + 1 ) * Double(y-2)), width: size, height: size),x:x-1,y:y-1)
                let bgColor = UIColor.lightGray
                TestView.backgroundColor = bgColor
                view.addSubview(TestView)
                panel[x-1][y-1] = TestView
            }
        }
        var count = 1
        while  count <= bom  {
            let x = Int(arc4random_uniform(UInt32(XY-1)))+1// Int.random(in: 1 ... XY)-1
            let y = Int(arc4random_uniform(UInt32(XY-1)))+1//Int.random(in: 1 ... XY)-1

            if panel[x][y].bom == false
            {
                panel[x][y].bom = true
                count += 1
            }
        }
        for x in panel {
            for y in x {
                y.update(panels: panel)
            }
        }
        
    }
    
}
