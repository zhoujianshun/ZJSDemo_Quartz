//
//  ZJSProgressViewRing.m
//  Demo_Quartz
//
//  Created by 周建顺 on 15/10/12.
//  Copyright © 2015年 周建顺. All rights reserved.
//

#import "ZJSProgressViewRing.h"

@interface ZJSProgressViewRing ()

@property (nonatomic,strong) CAShapeLayer *backgroundLayer;
@property (nonatomic,strong) CAShapeLayer *progressLayer;

@end

@implementation ZJSProgressViewRing


- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    
    self.backgroundColor = [UIColor clearColor];
    
    self.primaryColor = [UIColor colorWithRed:0 green:122/255.0 blue:1.0 alpha:1.0];
    self.secondaryColor = self.primaryColor;
    
    //Set up the number formatter
//    _percentageFormatter = [[NSNumberFormatter alloc] init];
//    _percentageFormatter.numberStyle = NSNumberFormatterPercentStyle;
    
    //Set up the background layer
    _backgroundLayer = [CAShapeLayer layer];
    _backgroundLayer.strokeColor = self.secondaryColor.CGColor;
    _backgroundLayer.fillColor = [UIColor clearColor].CGColor;
    _backgroundLayer.lineCap = kCALineCapRound;
    _backgroundLayer.lineWidth = _backgroundRingWidth;
    //_backgroundLayer.lineWidth = 3;
    [self.layer addSublayer:_backgroundLayer];
    
    //Set up the progress layer
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.strokeColor = self.primaryColor.CGColor;
    _progressLayer.fillColor = nil;
    _progressLayer.lineCap = kCALineCapButt;
    _progressLayer.lineWidth = _progressRingWidth;
    // _progressLayer.lineWidth = 3;
    [self.layer addSublayer:_progressLayer];

}


-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    
    [self setNeedsDisplay];
}

- (void)setPrimaryColor:(UIColor *)primaryColor
{
    _primaryColor = primaryColor;
   // [super setPrimaryColor:primaryColor];
    _progressLayer.strokeColor = self.primaryColor.CGColor;
    //_iconLayer.fillColor = self.primaryColor.CGColor;
    [self setNeedsDisplay];
}

- (void)setSecondaryColor:(UIColor *)secondaryColor
{
    _secondaryColor = secondaryColor;
   // [super setSecondaryColor:secondaryColor];
    _backgroundLayer.strokeColor = self.secondaryColor.CGColor;
    [self setNeedsDisplay];
}

-(void)setBackgroundRingWidth:(CGFloat)backgroundRingWidth{
    _backgroundRingWidth = backgroundRingWidth;
    _backgroundLayer.lineWidth = backgroundRingWidth;
    [self setNeedsDisplay];
}

-(void)setProgressRingWidth:(CGFloat)progressRingWidth{
    _progressRingWidth = progressRingWidth;
    _progressLayer.lineWidth = progressRingWidth;
    [self setNeedsDisplay];
}

-(void)layoutSubviews{
    self.backgroundLayer.frame = self.bounds;
    self.progressLayer.frame = self.bounds;
    
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawBackground];
    [self drawProgress];
   
}

- (void)drawBackground
{
    //Create parameters to draw background
    float startAngle = - M_PI_2;
    float endAngle = startAngle + (2.0 * M_PI);
    CGPoint center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.width / 2.0);
    CGFloat radius = (self.bounds.size.width - _backgroundRingWidth) / 2.0;
    
    //If indeterminate, recalculate the end angle
//    if (self.indeterminate) {
//        endAngle = .8 * endAngle;
//    }
    
    //Draw path
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = _progressRingWidth;
    path.lineCapStyle = kCGLineCapRound;
    [path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    //Set the path
    _backgroundLayer.path = path.CGPath;
}

- (void)drawProgress
{
    //Create parameters to draw progress
    float startAngle = - M_PI_2;
    float endAngle = startAngle + (2.0 * M_PI * self.progress);
    CGPoint center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.width / 2.0);
    CGFloat radius = (self.bounds.size.width - _progressRingWidth) / 2.0;
    
    //Draw path
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapButt;
    path.lineWidth = _progressRingWidth;
    [path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    //Set the path
    [_progressLayer setPath:path.CGPath];
    
    //Update label
   // _percentageLabel.text = [_percentageFormatter stringFromNumber:[NSNumber numberWithFloat:self.progress]];
}


@end
