//
//  Test1View.m
//  Demo_Quartz
//
//  Created by 周建顺 on 15/10/7.
//  Copyright © 2015年 周建顺. All rights reserved.
//

#import "Test1View.h"

@implementation Test1View


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // 两种绘制方法 UIKik 和 CG
    
    // Drawing code
    if (self.isUIKitDraw) {
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [[UIColor blueColor] setFill];
        [[UIColor purpleColor] setStroke];
        [path fill];
        [path stroke];
    }else{
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));

        CGContextSetStrokeColorWithColor(ctx, [UIColor blueColor].CGColor);
        CGContextSetLineWidth(ctx, 5);
        //CGContextStrokePath(ctx);
        CGContextSetFillColorWithColor(ctx, [UIColor purpleColor].CGColor);
       // CGContextFillPath(ctx);
        CGContextDrawPath(ctx, kCGPathFillStroke);

    }
    
}


@end
