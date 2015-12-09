//
//  Test1ViewController.m
//  Demo_Quartz
//
//  Created by 周建顺 on 15/10/7.
//  Copyright © 2015年 周建顺. All rights reserved.
//

#import "Test1ViewController.h"
#import "Test1View.h"
#import "MyLayerDelegate1.h"

@interface Test1ViewController ()
@property (nonatomic,strong) Test1View *test1View;
@property (nonatomic,strong) Test1View *test1View2;
@property (nonatomic,strong) UIView *test1View3;

@property (nonatomic,strong) MyLayerDelegate1 *layerDelegate;
@property (nonatomic,strong) CALayer *myLayer;


@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.test1View = [[Test1View alloc] init];
    self.test1View.isUIKitDraw = YES;
    self.test1View.frame = CGRectMake(50, 80, 100, 100);
    [self.view addSubview:self.test1View];
    
    self.test1View2 = [[Test1View alloc] init];
    self.test1View2.isUIKitDraw = NO;
    self.test1View2.frame = CGRectMake(50, 200, 100, 100);
    [self.view addSubview:self.test1View2];
    
    self.layerDelegate = [[MyLayerDelegate1 alloc] init];
    self.test1View3 = [[UIView alloc] init];
    self.test1View3.backgroundColor = [UIColor grayColor];
    self.test1View3.frame = CGRectMake(50, 320, 100, 100);
    [self.view addSubview:self.test1View3];
    self.myLayer = [CALayer layer];
    self.myLayer.backgroundColor = [UIColor greenColor].CGColor;
    self.myLayer.frame = CGRectMake(0, 0, 50, 50);
    self.myLayer.delegate = self.layerDelegate;
    [self.test1View3.layer addSublayer:self.myLayer];
    [self.myLayer setNeedsDisplay];

    [self draw];
    
}

-(void)draw{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100,100), NO, 0);
    
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(con, CGRectMake(0,0,100,100));
    CGContextSetFillColorWithColor(con, [UIColor blueColor].CGColor);
    CGContextFillPath(con);
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 80, 100, 100)];
    imageView.backgroundColor = [UIColor yellowColor];
    imageView.image = im;
    [self.view addSubview:imageView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    self.myLayer.delegate = nil;
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
