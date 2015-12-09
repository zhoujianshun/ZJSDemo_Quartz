//
//  Test2View2.m
//  Demo_Quartz
//
//  Created by 周建顺 on 15/10/11.
//  Copyright © 2015年 周建顺. All rights reserved.
//

#import "Test2View2.h"

@implementation Test2View2


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // 使用layer 可以解决，直接使用UIBezierPath绘制导致线粗细不等的问题
    CAShapeLayer *sLayer = [[CAShapeLayer alloc] init];
    sLayer.frame = self.bounds;
    // Drawing code
    CGFloat topPadding = 10;
    
    CGFloat height = rect.size.height;
    CGFloat width = rect.size.width;
    CGFloat radius = (width + height) * 0.05;
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 4;
   // [[UIColor redColor] setStroke];
    
    // 起点
    [path moveToPoint:CGPointMake(radius, topPadding)];
    
    [path addLineToPoint:CGPointMake((width - topPadding)/2, topPadding)];
    [path addLineToPoint:CGPointMake((width)/2, 0)];
    [path addLineToPoint:CGPointMake((width)/2+topPadding/2, topPadding)];
    // 上横线
    [path addLineToPoint:CGPointMake(width - radius, topPadding)];
    //右上的弧度
    [path addArcWithCenter:CGPointMake(width - radius, radius + topPadding) radius:radius startAngle:1.5*M_PI endAngle:0 clockwise:YES];
    
    // 右边的线
    //[path addLineToPoint:CGPointMake(width, height-radius)];
    [path addArcWithCenter:CGPointMake(width - radius, height - radius) radius:radius startAngle:0 endAngle:0.5*M_PI clockwise:YES];
    
    // 下边线
   // [path addLineToPoint:CGPointMake(radius, height)];
    [path addArcWithCenter:CGPointMake(radius, height-radius) radius:radius startAngle:0.5*M_PI endAngle:M_PI clockwise:YES];
    
    // 左边线
   // [path addLineToPoint:CGPointMake(0, radius+topPadding)];
    [path addArcWithCenter:CGPointMake(radius, radius+topPadding) radius:radius startAngle:M_PI endAngle:1.5*M_PI clockwise:YES];
    
    sLayer.path = path.CGPath;
    sLayer.strokeColor = [UIColor redColor].CGColor;
    sLayer.fillColor = [UIColor clearColor].CGColor;
    //[path stroke];
    [self.layer addSublayer: sLayer];
}


@end
