//
//  ViewController.swift
//  UIPickerViewSwift
//
//  Created by ChuangLan on 2019/12/11.
//  Copyright © 2019 QuentinZang. All rights reserved.
//

import UIKit

//UIPickerView 的委托协议是 UIPickerViewDelegate，数据源是 UIPickerViewDataSource。我们需要在视图控制器中声明实现 UIPiekerViewDelegate 和 UIPickerViewDataSource 协议。
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var label : UILabel!
    var pickerView : UIPickerView!
    var pickerData:[String : [String]] = ["放假":["写代码","玩游戏","泡妹子"],"旅游":["马尔代夫","火星","迪拜","月球"],"上班":["加班","不加班"]]
    
    //保存全部数据
    var pickerFirstData: [String] = ["放假","旅游","上班"] //第一级数据
    var pickerSecondData: [String] = ["写代码","玩游戏","泡妹子"]//第二级数据
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       // 创建视图
       let screen = UIScreen.main.bounds
       // 设置 根视图背景色
       self.view.backgroundColor = UIColor.white
        
       // 选择器
       let pickerViewWidth:CGFloat = 320
       let pickerViewHeight:CGFloat = 162
       self.pickerView = UIPickerView(frame: CGRect(x:0, y: 0,width: pickerViewWidth, height: pickerViewHeight))
    //因为该Controller中实现了UIPickerViewDataSource接口所以将dataSource设置成自己
        self.pickerView.dataSource = self
        //将delegate设置成自己
        self.pickerView.delegate = self
        self.view.addSubview(self.pickerView)
        
        //添加标签
        let labelWidth : CGFloat = 200
        let labelHeight : CGFloat = 21
        let labelTopView : CGFloat = 281
        self.label = UILabel(frame: CGRect(x: (screen.size.width - labelWidth) / 2, y: labelTopView, width: labelWidth, height: labelHeight))
        self.label.text = "Label"
        //字体左右居中
        self.label.textAlignment = .center
        self.view.addSubview(self.label)
        
        //button 按钮
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 150, y: 400, width: 50, height: 50)
        button.backgroundColor = .red
        button.setTitle("确定", for: .normal)
        button.addTarget(self, action: #selector(ViewController.getPickerViewValue), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    @objc func getPickerViewValue() {
        //获得2列选取值的下标
        let row1 = self.pickerView.selectedRow(inComponent: 0)
        let row2 = self.pickerView.selectedRow(inComponent: 1)
        //根据下标获取值
        let selected1 = self.pickerFirstData[row1] as String
        let selected2 = self.pickerSecondData[row2] as String
        //拼接值
        let title = selected1 + " " + selected2
        self.label.text = title
    }
    
    //设置选择框的总列数,继承于UIPickViewDataSource协议
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 2
    }
    
    //设置选择框的总行数,继承于UIPickViewDataSource协议
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //总行数设置为数据源的总长度。component :为0 表示第一列，1 表示第二列
        //根据不同的数据源设置不同的个数
        if component == 0 {
            return self.pickerFirstData.count
        } else {
            return self.pickerSecondData.count
        }
    }
    
    //设置选项框各选项的内容,继承于UIPickViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {//选择第一级数据
            return self.pickerFirstData[row]
        } else {//选择第二级数据
            return self.pickerSecondData[row]
        }
    }
    
//    //设置列宽
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        if component == 0 {
//            return 100
//        } else {
//            return 200
//        }
//    }
    
    //设置每行选项的高度
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45
    }
    
//    //修改PickerView选项
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        //将图片设为PickerView选型
//        let image = UIImage(named: "icon"+String(row))
//        let imageView = UIImageView(image:image)
//        //修改字体，大小，颜色
//        var pickerLabel = view as? UILabel
//        if pickerLabel == nil {
//            pickerLabel = UILabel()
//            pickerLabel?.font = UIFont.systemFont(ofSize: 16)
//            pickerLabel?.textAlignment = .center
//        }
//
//        pickerLabel?.text = String(row)+"-"+String(component)
//        pickerLabel?.textColor = UIColor.blue
//        return imageView//pickerLabel！(选择其一)
//    }
    
    //检测响应选项的选择状态
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            //记录用户选择的值
            let selectedFirst = self.pickerFirstData[row] as String
            // 根据第一列选择的值，获取第二列数据
            self.pickerSecondData = self.pickerData[selectedFirst]!
            //刷新第二列的数据源
            self.pickerView.reloadComponent(1)
            //刷新数据源后将第二组数据转到下标为0,并且开启动画效果
            self.pickerView.selectRow(0, inComponent: 1, animated: true)
        }
    }

}

