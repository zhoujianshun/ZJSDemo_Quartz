//
//  Test4View2.m
//  Demo_Quartz
//
//  Created by 周建顺 on 15/12/2.
//  Copyright © 2015年 周建顺. All rights reserved.
//

#import "Test4View2.h"

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

@implementation Test4View2

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    self.backgroundColor = [UIColor whiteColor];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    CGFloat lineWidth = SINGLE_LINE_WIDTH;
    
//    CGFloat xPos = 0;
//    CGFloat yPos = 0;
//    while (xPos < self.bounds.size.width) {
//        CGContextMoveToPoint(context, xPos, 0);
//        CGContextAddLineToPoint(context, xPos, self.bounds.size.height);
//        xPos += 10;
//    }
//    
//    while (yPos < self.bounds.size.height) {
//        CGContextMoveToPoint(context, 0, yPos);
//        CGContextAddLineToPoint(context, self.bounds.size.width, yPos);
//        yPos += 10;
//    }
    /**
     *  https://developer.apple.com/library/ios/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/GraphicsDrawingOverview/GraphicsDrawingOverview.html
     * 仅当要绘制的线宽为奇数像素时，绘制位置需要调整
     */
    CGFloat pixelAdjustOffset = 0;
    
    
    if (self.useOffset) {
        if (((int)(lineWidth * [UIScreen mainScreen].scale) + 1) % 2 == 0) {
            pixelAdjustOffset = SINGLE_LINE_ADJUST_OFFSET;
        }
    }
    
    CGContextMoveToPoint(context, 0 , 1 + pixelAdjustOffset);
    CGContextAddLineToPoint(context, rect.size.width, 1 + pixelAdjustOffset);
    
    CGContextMoveToPoint(context, 0, rect.size.height - 1 - pixelAdjustOffset);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height - 1 - pixelAdjustOffset);
//    CGFloat lineMargin = 5;
//    CGFloat xPos = lineMargin - pixelAdjustOffset;
//    CGFloat yPos = lineMargin - pixelAdjustOffset;
//    while (xPos < self.bounds.size.width) {
//        CGContextMoveToPoint(context, xPos, 0);
//        CGContextAddLineToPoint(context, xPos, self.bounds.size.height);
//        xPos += lineMargin;
//    }
//    
//    while (yPos < self.bounds.size.height) {
//        CGContextMoveToPoint(context, 0, yPos);
//        CGContextAddLineToPoint(context, self.bounds.size.width, yPos);
//        yPos += lineMargin;
//    }
    
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextStrokePath(context);
}


@end
