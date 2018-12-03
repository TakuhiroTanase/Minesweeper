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

class ViewController: UIViewController,UIPickerViewDelegate ,UIPickerViewDataSource{

    
  
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var bomNum: UITextField!
    @IBOutlet weak var bomCountLabel: UILabel!
    @IBOutlet weak var gameEnd: UIButton!
    var pickerView = UIPickerView()
    
    var dataList = ["10X10","20X20","30X30",]
    
    @IBOutlet weak var stageSize: UITextField!
    var panel = PanelController()
    var bom = 0
    var size = 100
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameEnd.titleLabel?.adjustsFontSizeToFitWidth = true
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        toolbar.setItems([cancelItem, doneItem], animated: true)
        
        stageSize.inputView = pickerView
        stageSize.inputAccessoryView = toolbar
        
        initialize()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            self.bomCountLabel.text = "\(bomCount)"
            
            var panelCount = self.size*self.size - self.bom
            for x in self.panel.panel {
                for y in x {
                    panelCount -=  y.backgroundColor == UIColor.white ? 1:0;
                }
            }
            print(panelCount)
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
        size = stageSize.text == "10X10" ?10:stageSize.text == "20X20" ?20:stageSize.text == "30X30" ?30:10
        bom = bom >= size*size ?size*size-1:bom
        panel.Initialize(view: self.view,XY: size,bom:bom)
        
        bomCount = Int(bom)
        bomCountLabel.text = "\(bom)"
        
        self.view.bringSubviewToFront(gameEnd)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return dataList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        return dataList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //コンポーネントごとに現在選択されているデータを取得する。
        let data = self.pickerView(pickerView, titleForRow: pickerView.selectedRow(inComponent: 0),forComponent: 0)
        stageSize.text = data
    }
    @IBAction func Reset(_ sender: Any) {
        initialize()
    }
    
    @IBAction func Chenge(_ sender: Any) {
        flag  = !flag
    }
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    @objc func cancel() {
        self.stageSize.text = ""
        self.stageSize.endEditing(true)
    }
    @objc func done() {
        self.stageSize.endEditing(true)
    }
    
}

