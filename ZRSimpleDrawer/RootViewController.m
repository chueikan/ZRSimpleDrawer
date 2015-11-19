//
//  RootViewController.m
//  ZRSimpleDrawer
//
//  Created by vanish on 15/11/19.
//  Copyright (c) 2015年 HZR. All rights reserved.
//

#import "RootViewController.h"
#import "LeftViewController.h"
#import "CenterViewController.h"

@interface RootViewController ()

@property (nonatomic, strong) CenterViewController *centerVC;//中间的视图控制器
@property (nonatomic, strong) LeftViewController *leftVC;//抽屉的视图控制器
@property (nonatomic, assign) BOOL isShowingDrawer;//标记抽屉是否出现的状态
@property (nonatomic, strong) UISwipeGestureRecognizer *swipe;//滑动手势

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     添加导航控制器的leftBarButtonItem
     */
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(leftItemClicked)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    /**
     添加进入程序后所看到的中间视图
     */
    _centerVC = [[CenterViewController alloc] init];
    _centerVC.view.backgroundColor = [UIColor greenColor];
    _centerVC.view.frame = self.view.bounds;
    [self.view addSubview:_centerVC.view];

    /**
     为中间视图添加向右滑动的手势
     */
    _swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipping:)];
    //设定监听向右滑动的手势，即向右滑动时触发滑动手势方法
    _swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [_centerVC.view addGestureRecognizer:_swipe];
    
}

/**
 *  leftBarButtonItem的点击事件
 */
- (void)leftItemClicked{
    if (!_isShowingDrawer) {
        [self showDrawer];//抽屉未显示时，调用使抽屉显示的方法

    }else
        [self hideDrawer];//抽屉已经显示时，调用让抽屉隐藏的方法
}

//向右滑动手势的方法
- (void)swipping:(UISwipeGestureRecognizer *)swipe {
        [self showDrawer];//向右滑动拉出抽屉视图
        NSLog(@"swipe to right");
}

/**
 *  抽屉出现
 */
- (void)showDrawer{
    /**
     抽屉出现时，初始化抽屉视图控制器，并把抽屉视图添加到RootViewController视图上
     */
    _leftVC = [[LeftViewController alloc] init];
    _leftVC.view.frame = self.view.bounds;
    [self.view addSubview:_leftVC.view];
    [self.view addSubview:_leftVC.view];
    [self.view sendSubviewToBack:_leftVC.view];
    
    /**
     *  设定抽屉视图出现的动画
     */
    [UIView animateWithDuration:0.3 animations:^{
        _centerVC.view.frame = CGRectMake(self.view.frame.origin.x + 220, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        self.navigationController.navigationBar.frame = CGRectMake(self.view.frame.origin.x + 220, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
    }];
    _isShowingDrawer = YES;//抽屉出现，把抽屉状态设为“已出现”
}

/**
 *  抽屉隐藏
 */
- (void)hideDrawer{
    /**
     *  抽屉状态为“已出现时”，才使抽屉消失。否则什么都不执行
     */
    if (_isShowingDrawer == YES) {
        [UIView animateWithDuration:0.3 animations:^{
                _centerVC.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                self.navigationController.navigationBar.frame = CGRectMake(self.view.frame.origin.x, self.navigationController.navigationBar.frame.origin.y, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
            } completion:^(BOOL finished) {
            [_leftVC.view removeFromSuperview];
                NSLog(@"remove leftVC");
            }];
        _isShowingDrawer = NO;
        }
}

/**
 点击center视图时，调用此方法
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self hideDrawer];
}

@end
