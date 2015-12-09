//
//  Test2ViewController.m
//  Demo_Quartz
//
//  Created by 周建顺 on 15/10/11.
//  Copyright © 2015年 周建顺. All rights reserved.
//

#import "Test2ViewController.h"
#import "Test2View.h"
#import "Test2View2.h"

@interface Test2ViewController ()

@property (nonatomic,strong) Test2View *test2View;
@property (nonatomic,strong) Test2View2 *test2View2;

@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.test2View = [[Test2View alloc] init];
    self.test2View.backgroundColor = [UIColor clearColor];
    self.test2View.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:self.test2View];
    
    
    self.test2View2 = [[Test2View2 alloc] init];
    self.test2View2.layer.shouldRasterize = YES;
    self.test2View2.frame = CGRectMake(100, 250, 100, 100);
    self.test2View2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.test2View2];
    
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
