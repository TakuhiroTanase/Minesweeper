//
//  Panel.swift
//  LifeGame
//
//  Created by wmoodn on 2018/07/18.
//  Copyright © 2018年 wmoodn. All rights reserved.
//

import Foundation
import UIKit

class Panel: UIButton {
    var bom = false
    var checkCount = 0
    var check = false
    var x = 0
    var y = 0
    var lock = false
    var panels = [[Panel]]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    func Initialize(frame: CGRect,x:Int,y:Int){
        self.frame = frame
        self.x = x
        self.y = y
        self.addTarget(self, action: #selector(buttonEvent(_:)), for: UIControl.Event.touchUpInside)
        
    }
    @objc func buttonEvent(_ sender: UIButton) {
        if gameover
        { return }
        if flag && !check {
            lock = !lock
            self.setTitle( lock ? "◯" : "", for:.normal)
            self.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            bomCount -= lock ? 1:-1
        }
        else if !lock{
            if bom{
                gameover = true
            }
            else {
                Check(panel:self)
            }
        }
    }
    
    func update(panels:[[Panel]]){
        self.panels = panels
        var count = 0
        if y != 0 {
            count += panels[x][y-1].bom ? 1 : 0
        }
        if y < panels[x].count-1 {
            count += panels[x][y+1].bom ? 1 : 0
        }
        if x != 0 {
            count += panels[x-1][y].bom ? 1 : 0
            if y < panels[x].count-1 {
                count += panels[x-1][y+1].bom ? 1 : 0
            }
            if y != 0 {
                count += panels[x-1][y-1].bom ? 1 : 0
            }
        }
        if x < panels.count-1 {
            count += panels[x+1][y].bom ? 1 : 0
            if y != 0 {
                count += panels[x+1][y-1].bom ? 1 : 0
            }
            if y < panels[x].count-1 {
                count += panels[x+1][y+1].bom ? 1 : 0
            }
        }
        checkCount = count
        
    }
    func Check(panel:Panel){
        
        
        if !panel.check && !panel.bom && !panel.lock {
            panel.check = true
            panel.backgroundColor = UIColor.white
            
            if panel.checkCount == 0 {
                panel.BomCheck()
            }
            else {
                panel.setTitle("\(panel.checkCount)", for:.normal)
                panel.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            }
            
        }
    }
    func BomCheck(){
            if y != 0 {
                Check(panel:panels[x][y-1])
            }
            if y < panels[x].count-1 {
                Check(panel:panels[x][y+1])
            }
            if x != 0 {
               Check(panel:panels[x-1][y])
                if y < panels[x].count-1 {
                   Check(panel:panels[x-1][y+1])
                }
                if y != 0 {
                    Check(panel:panels[x-1][y-1])
                }
            }
            if x < panels.count-1 {
                Check(panel:panels[x+1][y])
                if y != 0 {
                    Check(panel:panels[x+1][y-1])
                }
                if y < panels[x].count-1 {
                    Check(panel:panels[x+1][y+1])
                }
            }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
