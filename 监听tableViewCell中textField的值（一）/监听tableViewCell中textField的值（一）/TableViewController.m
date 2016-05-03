//
//  TableViewController.m
//  监听tableViewCell中textField的值（一）
//
//  Created by wangsong on 16/5/3.
//  Copyright © 2016年 alibaba. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"

@interface TableViewController ()
/**
 *  标题
 */
@property(nonatomic, strong) NSArray *titles;
/**
 *  占位文字
 */
@property(nonatomic, strong) NSArray *placeHolders;

/**
 *  姓名
 */
@property(nonatomic, weak) UITextField *nameTextField;

/**
 *  年龄
 */
@property(nonatomic, weak) UITextField *ageTextField;

/**
 *  地址
 */
@property(nonatomic, weak) UITextField *addressTextField;
@end

@implementation TableViewController
    static NSString * const ID = @"textFieldCell";
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSubmitButton];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 在这里把每个cell的textField 赋值给 事先声明好的UITextField类型的属性
    // 以后直接操作控制器的这些属性就可以拿到每个textField的值
    switch (indexPath.row) {
        case 0:
            // 姓名
            self.nameTextField = cell.contentTextField;
            break;
        case 1:
            // 年龄
            self.ageTextField = cell.contentTextField;
            break;
        case 2:
            // 地址
            self.addressTextField = cell.contentTextField;
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *customCell = (TableViewCell *)cell;
    customCell.titleLabel.text = self.titles[indexPath.row];
    customCell.contentTextField.placeholder = self.placeHolders[indexPath.row];
}

#pragma mark - private method
- (void)setupSubmitButton
{
    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 60)];
    [self.view addSubview:submitButton];
    [submitButton setBackgroundColor:[UIColor redColor]];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didClickButton:(UIButton *)button
{
    NSLog(@"姓名：%@,年龄：%@，地址：%@",self.nameTextField.text,self.ageTextField.text,self.addressTextField.text);
}

- (NSArray *)titles
{
    if (!_titles) {
        _titles = @[@"姓名",@"年龄",@"地址"];
    }
    return _titles;
}

- (NSArray *)placeHolders
{
    if (!_placeHolders) {
        _placeHolders = @[@"请输入姓名",@"请输入年龄",@"请输入地址"];
    }
    return _placeHolders;
}

@end
