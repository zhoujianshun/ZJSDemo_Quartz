//
//  Test5ViewController.m
//  Demo_Quartz
//
//  Created by 周建顺 on 2019/5/22.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "Test5ViewController.h"
#import "ZJSProgressViewRing.h"



@interface Test5ViewController ()

@property (nonatomic,strong) ZJSProgressViewRing *progressRing;
@property (nonatomic) CGFloat progress;

@end

@implementation Test5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.progressRing = [[ZJSProgressViewRing alloc] init];
    self.progressRing.frame = CGRectMake(100, 100, 100, 100);
    self.progressRing.primaryColor = [UIColor redColor];
    self.progressRing.secondaryColor = [UIColor blueColor];
    
    [self.progressRing setProgressRingWidth:5];
    [self.progressRing setBackgroundRingWidth:10];
    [self.view addSubview:self.progressRing];
    self.progress = 0.1f;
    
    [self.progressRing setProgress:self.progress];
    
    [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(progressChanged) userInfo:nil repeats:YES];
}

-(void)progressChanged{
    self.progress = self.progress+.05;
    [self.progressRing setProgress:self.progress];
    
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
