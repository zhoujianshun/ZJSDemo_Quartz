//
//  Test2View.m
//  Demo_Quartz
//
//  Created by 周建顺 on 15/10/11.
//  Copyright © 2015年 周建顺. All rights reserved.
//

#import "Test2View.h"

@implementation Test2View


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(15, 5)];
//    path.lineWidth = 4;
//    [[UIColor redColor] setStroke];
//    //[[UIColor purpleColor] setFill];
//    //[path fill];
//    [path stroke];
//    
//}

- (void)drawRect:(CGRect)rect

{
    
    CGFloat width = rect.size.width;
    
    CGFloat height = rect.size.height;
    
    // 简便起见，这里把圆角半径设置为长和宽平均值的1/10
    
    CGFloat radius = (width + height) * 0.05;
    
    // 获取CGContext，注意UIKit里用的是一个专门的函数
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    // 移动到初始点
    
    CGContextMoveToPoint(context, radius, 0);
    
    // 绘制第1条线和第1个1/4圆弧，右上圆弧
    
    CGContextAddLineToPoint(context, width - radius,0);
    
    CGContextAddArc(context, width - radius, radius, radius, -0.5 *M_PI,0.0, 0);
    
    // 绘制第2条线和第2个1/4圆弧，右下圆弧
    
    CGContextAddLineToPoint(context, width, height - radius);
    
    CGContextAddArc(context, width - radius, height - radius, radius,0.0,0.5 * M_PI,0);
    
    // 绘制第3条线和第3个1/4圆弧，左下圆弧
    
    CGContextAddLineToPoint(context, radius, height);
    
    CGContextAddArc(context, radius, height - radius, radius,0.5 *M_PI, M_PI,0);
    
    // 绘制第4条线和第4个1/4圆弧，左上圆弧
    
    CGContextAddLineToPoint(context, 0, radius);
    
    CGContextAddArc(context, radius, radius, radius,M_PI,1.5 * M_PI,0);
    
    // 闭合路径
    
    CGContextClosePath(context);
    
    // 填充半透明红色
    
    //CGContextSetRGBFillColor(context,1.0,0.0,0.0,0.5);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);

    
    CGContextDrawPath(context,kCGPathStroke);
    
}


@end
