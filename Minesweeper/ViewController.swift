//
//  ViewController.swift
//  Minesweeper
//
//  Created by wmoodn on 2018/07/26.
//  Copyright © 2018年 wmoodn. All rights reserved.
//

import UIKit
var flag = false
var bomCount = 0
var gameover = false
class ViewController: UIViewController {
  
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var bomNum: UITextField!
    @IBOutlet weak var bomCountLabel: UILabel!
    @IBOutlet weak var gameEnd: UIButton!

    var panel = PanelController()
    var bom = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            self.bomCountLabel.text = "\(bomCount)"
            
            var panelCount = 100 - self.bom
            for x in self.panel.panel {
                for y in x {
                    panelCount -=  y.backgroundColor == UIColor.white ? 1:0;
                }
            }
            if panelCount == 0
            {
                self.gameEnd.setTitle("GameClear", for: .normal)
                self.gameEnd.isHidden = false
            }
            if gameover
            {
                self.gameEnd.setTitle("GameOver", for: .normal)
                for x in self.panel.panel {
                    for y in x {
                        if y.bom {
                            y.setTitle("×", for:.normal)
                            y.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
                        }
                    }
                }
                self.gameEnd.isHidden = false
            }
        })
    }
    func initialize(){
        self.gameEnd.isHidden = true
        gameover = false
        bom = Int(bomNum.text!)!
        bom = bom >= 100 ?99:bom
        panel.Initialize(view: self.view,XY: 10,bom:bom)
        
        bomCount = Int(bom)
        bomCountLabel.text = "\(bom)"
        
        self.view.bringSubview(toFront: gameEnd)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Reset(_ sender: Any) {
        initialize()
    }
    
    @IBAction func Chenge(_ sender: Any) {
        flag  = !flag
    }
    
}

