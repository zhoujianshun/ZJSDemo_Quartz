//
//  MyLayerDelegate1.m
//  Demo_Quartz
//
//  Created by 周建顺 on 15/10/7.
//  Copyright © 2015年 周建顺. All rights reserved.
//

#import "MyLayerDelegate1.h"
#import <UIKit/UIKit.h>

@implementation MyLayerDelegate1

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    
    // 两种绘制方法 UIKik 和 CG
    UIGraphicsPushContext(ctx);
    CGContextAddEllipseInRect(ctx, layer.bounds);
    CGContextSetFillColorWithColor(ctx, [UIColor yellowColor].CGColor);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIGraphicsPopContext();
    
}

@end
