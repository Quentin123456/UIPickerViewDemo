//
//  ViewController.m
//  UIPickerViewObjC
//
//  Created by ChuangLan on 2019/12/11.
//  Copyright © 2019 QuentinZang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSDictionary *dictionary;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSString *selectedProvince;

@end

@implementation ViewController

//懒加载
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dictionary = @{@"江苏":@[@"南京",@"苏州",@"徐州",@"镇江",@"无锡",@"常州"],@"河南":@[@"郑州",@"洛阳",@"开封",@"南阳",@"安阳",@"新乡",@"周口"]};
    //获取字典中所有的省份并排序保存
    self.provinceArray = [[self.dictionary allKeys] sortedArrayUsingSelector:@selector(compare:)];
    self.selectedProvince = self.provinceArray[0];
    
    [self.view addSubview:self.pickerView];
    
}

#pragma mark ------- dateSource&&Delegate --------

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

@end
