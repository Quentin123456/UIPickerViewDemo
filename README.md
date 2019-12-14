# UIPickerViewDemo
This is a demo about picker view, including two programming languages, swift and Objective-C.


Objectvie-C写法：
//懒加载picker view
- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        self.pickerView =  [[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 400)];
        _pickerView.layer.masksToBounds = YES;
        _pickerView.layer.borderWidth = 1;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    
    return _pickerView;
}

实现UIPickerView的代理方法
//设置列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

//设置指定列包含的项数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    }
    
    return [self.dictionary[self.selectedProvince] count];
    
}

//设置每个选项显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray[row];
    }
    return [self.dictionary[self.selectedProvince] objectAtIndex:row];
}

//用户进行选择
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedProvince = self.provinceArray[row];
        [self.pickerView reloadComponent:1];
        //设置第二列首选的始终是第一个
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
    }
}


swift写法

初始化参数
  var label : UILabel!
    var pickerView : UIPickerView!
    var pickerData:[String : [String]] = ["放假":["写代码","玩游戏","泡妹子"],"旅游":["马尔代夫","火星","迪拜","月球"],"上班":["加班","不加班"]]
    
    //保存全部数据
    var pickerFirstData: [String] = ["放假","旅游","上班"] //第一级数据
    var pickerSecondData: [String] = ["写代码","玩游戏","泡妹子"]//第二级数据
    
    实现UIPickerView的代理方法
    
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
    
    //设置每行选项的高度
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45
    }
 
    
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
    
    
