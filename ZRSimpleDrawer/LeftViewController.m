//
//  LeftViewController.m
//  ZRSimpleDrawer
//
//  Created by vanish on 15/11/19.
//  Copyright (c) 2015年 HZR. All rights reserved.
//

#import "LeftViewController.h"
#define COLORWITHRBG colorWithRed:235 / 255.00 green:235 / 255.00 blue:241 / 255.00 alpha:1
@interface LeftViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor COLORWITHRBG];
    _table = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 150, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _table.delegate = self;
    _table.dataSource = self;
     _dataSource = @[@"我的信息", @"我的评论", @"我的收藏"];
    [self.view addSubview:_table];
    
    _table.scrollEnabled = NO;


}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
