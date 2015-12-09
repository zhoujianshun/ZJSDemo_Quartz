//
//  Test3ViewController.m
//  Demo_Quartz
//
//  Created by 周建顺 on 15/10/14.
//  Copyright © 2015年 周建顺. All rights reserved.
//

#import "Test3ViewController.h"
#import "ZJSStrokeLable.h"

@interface Test3ViewController ()


@property (nonatomic,strong) ZJSStrokeLable *label;

@end

@implementation Test3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.label = [[ZJSStrokeLable alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.label.text = @"sadasdasd你100";
    self.label.textColor = [UIColor purpleColor];
    self.label.storkeColor = [UIColor blueColor];
    
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:@"32131231fcxzc" attributes:@{NSFontAttributeName:self.label.font,NSStrokeColorAttributeName:[UIColor greenColor],NSStrokeWidthAttributeName:@-2,NSForegroundColorAttributeName:[UIColor redColor]}];
    self.label.attributedText = attStr;
    [self.view addSubview:self.label];
    
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
