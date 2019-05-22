//
//  ViewController.m
//  Demo_Quartz
//
//  Created by 周建顺 on 15/10/7.
//  Copyright © 2015年 周建顺. All rights reserved.
//

#import "ViewController.h"
#import "Test1ViewController.h"
#import "Test2ViewController.h"
#import "Test3ViewController.h"
#import "Test4ViewController.h"
#import "Test5ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataSource = @[@"UIKit和Core Graphics",@"画弧度",@"storke label",@"1像素的线", @"ProgressRing"];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (row == 0) {
        Test1ViewController *vc = [[Test1ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (row ==1){
        Test2ViewController *vc = [[Test2ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(row == 2){
        Test3ViewController *vc = [[Test3ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(row == 3){
        Test4ViewController *vc = [[Test4ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(row == 4){
        Test5ViewController *vc = [[Test5ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
