//
//  Test6ViewController.m
//  Demo_Quartz
//
//  Created by 周建顺 on 2019/5/22.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "Test6ViewController.h"
#import "ZJSTest6View.h"

@interface Test6ViewController ()

@property (nonatomic, strong) ZJSTest6View *test6View;

@end

@implementation Test6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
    ZJSTest6View *test6 = [[ZJSTest6View alloc] init];
    test6.backgroundColor = [UIColor colorWithRed:63./255. green:141./255. blue:246./255. alpha:1];
    test6.frame = CGRectMake(0, 100, 400, 400);
    
    [self.view addSubview:test6];
    
    test6.images = @[[UIImage imageNamed:@"security_center_animation_light_cam_highlight"],
                     [UIImage imageNamed:@"security_center_animation_gas_highlight"],
                     [UIImage imageNamed:@"security_center_animation_sens8_highlight"],
                     [UIImage imageNamed:@"security_center_animation_smoke_highlight"],
                     ];
    
    test6.animations = @[@YES,@YES,@YES,@YES];
    [test6 startAnimation];
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
