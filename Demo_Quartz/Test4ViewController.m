//
//  Test4ViewController.m
//  Demo_Quartz
//
//  Created by 周建顺 on 15/12/2.
//  Copyright © 2015年 周建顺. All rights reserved.
//

#import "Test4ViewController.h"
#import "Test4View1.h"
#import "Test4View2.h"

@interface Test4ViewController ()

@end

@implementation Test4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"1像素的线";
    
    Test4View1 *view1 = [[Test4View1 alloc] init];
    view1.frame = CGRectMake(20, 80, 100, 100);
    [self.view addSubview:view1];
    
    Test4View2 *view2 = [Test4View2 new];
    view2.frame =CGRectMake(20, 201, 100, 100);
    [self.view addSubview:view2];
    
    Test4View1 *view3 = [[Test4View1 alloc] init];
    view3.useOffset = YES;
    view3.frame =  CGRectMake(140, 80, 100, 100);
    [self.view addSubview:view3];
    
    Test4View2 *view4 = [[Test4View2 alloc] init];
    view4.useOffset = YES;
    view4.frame =  CGRectMake(140, 201, 100, 100);
    [self.view addSubview:view4];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
