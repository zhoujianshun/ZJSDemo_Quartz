//
//  ZJSTest6View.m
//  Demo_Quartz
//
//  Created by 周建顺 on 2019/5/22.
//  Copyright © 2019 周建顺. All rights reserved.
//

#import "ZJSTest6View.h"

//弧度转角度
#define Radians_To_Degrees(radians) ((radians) * (180.0 / M_PI))
//角度转弧度
#define Degrees_To_Radians(angle) ((angle) / 180.0 * M_PI)

#define kInterSpace 15

#define k_my_scale

@interface ZJSIntervalF : NSObject

@property (nonatomic, assign) CGFloat start;
@property (nonatomic, assign) CGFloat end;

-(instancetype)initWithStart:(CGFloat)start end:(CGFloat)end;
-(BOOL)containsInOpenIntervalWithInput:(CGFloat)input;

@end


@implementation ZJSIntervalF

- (instancetype)initWithStart:(CGFloat)start end:(CGFloat)end{
    self = [super init];
    if (self) {
        _start = start;
        _end = end;
    }
    return self;
}


- (BOOL)containsInOpenIntervalWithInput:(CGFloat)input{
    if (self.start < input && self.end > input) {
        return YES;
    }
    return NO;
}

- (BOOL)containsInClosedIntervalWithInput:(CGFloat)input{
    if (self.start <= input && self.end >= input) {
        return YES;
    }
    return NO;
}

@end


@interface ZJSTest6View()

@property (nonatomic, strong) CAShapeLayer *bgLayer;
@property (nonatomic, strong) CALayer *imageLayer;
@property (nonatomic, strong) CALayer *image2Layer;

@property (nonatomic, assign) CFTimeInterval duration1;
@property (nonatomic, assign) CFTimeInterval duration2;

@property (nonatomic, copy) NSArray *animationLayers;;

@property (nonatomic, strong) CAShapeLayer *image1AnimationLayer;
@property (nonatomic, strong) CAShapeLayer *image2AnimationLayer;
@property (nonatomic, strong) CAShapeLayer *image3AnimationLayer;
@property (nonatomic, strong) CAShapeLayer *image4AnimationLayer;

@property (nonatomic, strong) UIColor *mainColor;

@end

@implementation ZJSTest6View

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    
    return self;
}


-(void)commonInit{
    
    _duration1 = 2.5;
    _duration2 = 3;
    
    _mainColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    
    _imageLayer = [[CALayer alloc] init];

    if ([UIImage imageNamed:@"security_center_animation_flash_point"]) {
        _imageLayer.contents = (id)[UIImage imageNamed:@"security_center_animation_flash_point"].CGImage;
    }else{
        _imageLayer.backgroundColor = [UIColor redColor].CGColor;
    }

    [self.layer addSublayer:_imageLayer];
    
    _image2Layer = [[CALayer alloc] init];
//
    if ([UIImage imageNamed:@"security_center_animation_flash_point"]) {
        _image2Layer.contents = (id)[UIImage imageNamed:@"security_center_animation_flash_point"].CGImage;
    }else{
        _image2Layer.backgroundColor = [UIColor blueColor].CGColor;
    }

    [self.layer addSublayer:_image2Layer];
    

    _image1AnimationLayer = [[CAShapeLayer alloc] init];
    _image2AnimationLayer = [[CAShapeLayer alloc] init];
    _image3AnimationLayer = [[CAShapeLayer alloc] init];
    _image4AnimationLayer = [[CAShapeLayer alloc] init];
    

    
    _animationLayers = @[_image1AnimationLayer, _image2AnimationLayer,_image3AnimationLayer, _image4AnimationLayer];
    
    [_animationLayers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAShapeLayer *layer = obj;
        [layer setFillColor:_mainColor.CGColor];
        [self.layer addSublayer:layer];
    }];
}

-(void)startAnimation{
    
    CGFloat width = CGRectGetWidth(self.frame) - 2 * kInterSpace;
    CGFloat height = CGRectGetHeight(self.frame) - 2 * kInterSpace;
    CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2.f, CGRectGetHeight(self.frame)/2.f);
    
    CGFloat radius = width > height ? height/2.f : width/2.f;
    
    //初始化圆点层
    UIBezierPath* path = [[UIBezierPath alloc] init];
    [path addArcWithCenter:center
                    radius:radius
                startAngle:0
                  endAngle:2 * M_PI
                 clockwise:1];
  

    [self addAnimationTo:_imageLayer path:path duration:self.duration1];
    
    
    CGFloat  radius2 = radius  - 45.f/270.f*(radius*2);
    
    UIBezierPath* path2 = [[UIBezierPath alloc] init];
    [path2 addArcWithCenter:center
                    radius:radius2
                startAngle:M_PI_2
                  endAngle:2 * M_PI + M_PI_2
                 clockwise:1];
    
      [self addAnimationTo:_image2Layer path:path2 duration:self.duration2];
    
    
    [self.animations  enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAShapeLayer *layer =   self.animationLayers[idx];
        if ([obj boolValue]) {
            
            [self setupAnimationInLayer:layer];
        }else{
            [self removeAnimationInLayer:layer];
        }
    }];
    
}
-(void)addAnimationTo:(CALayer*)layer path:(UIBezierPath*)path duration:(CFTimeInterval)duration {
    
    
    //创建一个帧动画需要 的圆周 路径，这个路径 与外圆圈一一致
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animation];
    animation1.keyPath = @"position";
    animation1.path = path.CGPath;
    animation1.duration = duration;
    animation1.repeatCount = MAXFLOAT;
    
    
    [layer addAnimation:animation1 forKey:nil];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.frame) - 2 * kInterSpace;
    CGFloat height = CGRectGetHeight(self.frame) - 2 * kInterSpace;
    
    CGFloat radius = width > height ? height/2.f : width/2.f;
    
//    CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2.f, CGRectGetHeight(self.frame)/2.f);
    
    CGFloat w = 44/270.f * (2*radius);
    CGFloat h = 44/270.f * (2*radius);
    self.imageLayer.frame = CGRectMake(CGRectGetWidth(self.frame)/2.f - w/2, CGRectGetHeight(self.frame)/2 - radius - h/2.f, w, h);
    
    
    CGFloat  radius2 = radius  - 45.f/270.f*(radius*2);
    
    self.image2Layer.frame = CGRectMake(CGRectGetWidth(self.frame)/2.f - w/2, CGRectGetHeight(self.frame)/2 - radius2 - h/2.f, w, h);
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self.mainColor setFill];
    [self.mainColor setStroke];
    
    [self drawPath1:rect];
    [self drawPath2:rect];
    [self drawPath3:rect];
    
}

-(void)drawPath3:(CGRect)rect{
    CGFloat width = CGRectGetWidth(rect) - 2 * kInterSpace;
    CGFloat height = CGRectGetHeight(rect) - 2 * kInterSpace;
    CGPoint center = CGPointMake(CGRectGetWidth(rect)/2.f, CGRectGetHeight(rect)/2.f);
    
    CGFloat radius = width > height ? height/2.f : width/2.f;
   
    CGFloat  radius2 = radius  - 78.f/270.f*(radius*2);
    
    UIBezierPath* path2 = [[UIBezierPath alloc] init];
    [path2 addArcWithCenter:center
                     radius:radius2
                 startAngle:M_PI_2
                   endAngle:2 * M_PI + M_PI_2
                  clockwise:1];
    
    [path2 stroke];
    
    
    UIBezierPath *path1 = [self pathWithCenter:center radius:2.5 orbitRadius:radius2 degrees:15];
    [path1 fill];
    
    UIBezierPath *path4 = [self pathWithCenter:center radius:4.5 orbitRadius:radius2 degrees:120];
    [path4 fill];
    
    UIBezierPath *path3 = [self pathWithCenter:center radius:3 orbitRadius:radius2 degrees:280];
    [path3 fill];
}


-(void)drawPath2:(CGRect)rect{
    CGFloat width = CGRectGetWidth(rect) - 2 * kInterSpace;
    CGFloat height = CGRectGetHeight(rect) - 2 * kInterSpace;
    CGPoint center = CGPointMake(CGRectGetWidth(rect)/2.f, CGRectGetHeight(rect)/2.f);
    CGFloat radius = width > height ? height/2.f : width/2.f;
    CGFloat scale = ((radius*2)/270.f);
    
    
    CGFloat orbitRadius = radius  - 45.f*scale;
    
    CGFloat pointRadius = 1;
    CGFloat pointRadius2 = 1.5;
    CGFloat pointRadius3 = 3;
    CGFloat pointRadius4 = 5;
    
    
    ZJSIntervalF *interval1 = [[ZJSIntervalF alloc] initWithStart:31.5 end:66.5];
    ZJSIntervalF *interval2 = [[ZJSIntervalF alloc] initWithStart:311.5 end:328.5];
    NSArray *intervals = @[interval1, interval2];

   // image 3
    CGFloat image1Radius = (60.f * scale)/2.f;
    CGFloat image1Degrees =(interval1.start + (interval1.end - interval1.start)/2.f);
    
    
    if ([self.animations[3] boolValue]) {
        [self setupLayer:self.animationLayers[3] center:center radius:((33*scale/2.f) + 2) orbitRadius:orbitRadius degrees:image1Degrees];
    }
    
    if (self.images[3]) {
        [self drawImageWithImage:self.images[3] imageRadius:image1Radius orbitRadius:orbitRadius center:center degrees:image1Degrees];
    }
    
    
    
    // draw points
    for (int i = 0; i < 360; i = i + 2) {
        CGFloat currentRadius;
        BOOL needDraw = YES;;
        for (ZJSIntervalF *interval in intervals) {
            if ([interval containsInOpenIntervalWithInput:i]) {
                needDraw = NO;
                break;
            }
        }
        
        
        if (needDraw) {
            if (i%2 == 0) {
                currentRadius = pointRadius;
                UIBezierPath *path = [self pathWithCenter:center radius:currentRadius orbitRadius:orbitRadius degrees:i];
                [path fill];
            }
        }
        
    }
    
    
    for (ZJSIntervalF *interval in intervals) {

        UIBezierPath *path1L = [self pathWithCenter:center radius:pointRadius2 orbitRadius:orbitRadius degrees:(interval.start + 0.5)];
        [path1L fill];
        
        UIBezierPath *path1R = [self pathWithCenter:center radius:pointRadius2 orbitRadius:orbitRadius degrees:(interval.end - 0.5)];
        [path1R fill];
        
        
        UIBezierPath *path2L = [self pathWithCenter:center radius:pointRadius3 orbitRadius:orbitRadius degrees:(interval.start + 3.5)];
        [path2L fill];
        
        UIBezierPath *path2R = [self pathWithCenter:center radius:pointRadius3 orbitRadius:orbitRadius degrees:(interval.end - 3.5)];
        [path2R fill];
        
    }
    
    UIBezierPath *path1C = [self pathWithCenter:center radius:pointRadius4 orbitRadius:orbitRadius degrees:(interval2.start + (interval2.end - interval2.start)/2.f)];
    [path1C fill];

}


-(void)drawPath1:(CGRect)rect{
    CGFloat width = CGRectGetWidth(rect) - 2 * kInterSpace;
    CGFloat height = CGRectGetHeight(rect) - 2 * kInterSpace;
    CGPoint center = CGPointMake(CGRectGetWidth(rect)/2.f, CGRectGetHeight(rect)/2.f);
    
    
    CGFloat orbitRadius = width > height ? height/2.f : width/2.f;
    CGFloat scale = ((orbitRadius*2)/270.f);
    
    CGFloat pointRadius = 1;
    CGFloat pointRadius2 = 1.5;
    CGFloat pointRadius3 = 3;
    CGFloat pointRadius4 = 5;
    

    ZJSIntervalF *interval1 = [[ZJSIntervalF alloc] initWithStart:7 end:30.5];
    ZJSIntervalF *interval2 = [[ZJSIntervalF alloc] initWithStart:103 end:129.5];
    ZJSIntervalF *interval3 = [[ZJSIntervalF alloc] initWithStart:163 end:174.5];
    ZJSIntervalF *interval4 = [[ZJSIntervalF alloc] initWithStart:214 end:251];
    NSArray *intervals = @[interval1, interval2, interval3, interval4];
    
    
    // image 1
    
    CGFloat image3Radius = (60.f*scale)/2.f;
    CGFloat image3Degrees =(interval1.start + (interval1.end - interval1.start)/2.f);
    
    if ([self.animations[0] boolValue]) {
        [self setupLayer:self.animationLayers[0] center:center radius:(((33.f*scale)/2.f) + 2) orbitRadius:orbitRadius degrees:image3Degrees];
    }
    
    if (self.images[0]) {

        
        [self drawImageWithImage:self.images[0] imageRadius:image3Radius orbitRadius:orbitRadius center:center degrees:image3Degrees];
    }

    
    // image 2
    CGFloat image2Radius = (60*scale)/2.f;
    CGFloat image2Degrees =(interval2.start + (interval2.end - interval2.start)/2.f);
    
    if ([self.animations[1] boolValue]) {
        [self setupLayer:self.animationLayers[1] center:center radius:(((40.f*scale)/2.f) + 2) orbitRadius:orbitRadius degrees:image2Degrees];
    }
    
    if (self.images[1]) {
     
        [self drawImageWithImage:self.images[1] imageRadius:image2Radius orbitRadius:orbitRadius center:center degrees:image2Degrees];
    }
   
    
    // image 3
    CGFloat image1Radius = (60*scale)/2.f;
    CGFloat image1Degrees =(interval4.start + (interval4.end - interval4.start)/2.f);
    
    if ([self.animations[2] boolValue]) {
        [self setupLayer:self.animationLayers[2] center:center radius:(image1Radius + 2) orbitRadius:orbitRadius degrees:image1Degrees];
    }
    

    if (self.images[2]) {
        [self drawImageWithImage:self.images[2] imageRadius:image1Radius orbitRadius:orbitRadius center:center degrees:image1Degrees];
    }
    
    for (CGFloat i = 0; i < 360; i = i + 1.5) {
        CGFloat currentRadius;
        BOOL needDraw = YES;;
        for (ZJSIntervalF *interval in intervals) {
            if ([interval containsInOpenIntervalWithInput:i]) {
                needDraw = NO;
                break;
            }
        }
        
        if (needDraw) {
            if ((int)(i*10)%(15) == 0) {
                currentRadius = pointRadius;
                UIBezierPath *path = [self pathWithCenter:center radius:currentRadius orbitRadius:orbitRadius degrees:i];
                [path fill];
            }
        }
        
    }
    
    for (ZJSIntervalF *interval in intervals) {
        
        UIBezierPath *path1L = [self pathWithCenter:center radius:pointRadius2 orbitRadius:orbitRadius degrees:(interval.start + 0.5)];
        [path1L fill];
        
        UIBezierPath *path1R = [self pathWithCenter:center radius:pointRadius2 orbitRadius:orbitRadius degrees:(interval.end - 0.5)];
        [path1R fill];
        
        
        UIBezierPath *path2L = [self pathWithCenter:center radius:pointRadius3 orbitRadius:orbitRadius degrees:(interval.start + 2.5)];
        [path2L fill];
        
        UIBezierPath *path2R = [self pathWithCenter:center radius:pointRadius3 orbitRadius:orbitRadius degrees:(interval.end - 2.5)];
        [path2R fill];
        
    }
    
    
    UIBezierPath *path = [self pathWithCenter:center radius:pointRadius4 orbitRadius:orbitRadius degrees:(interval3.start + (interval3.end - interval3.start)/2.f)];
    [path fill];
}

#pragma mark -

-(UIBezierPath*)pathWithCenter:(CGPoint)center radius:(CGFloat)radius orbitRadius:(CGFloat)orbitRadius degrees:(CGFloat)degrees{

    CGFloat arc = M_PI*2 * (degrees/360.f) - M_PI_2;
    CGFloat cx = orbitRadius * cosf(arc);
    CGFloat cy = orbitRadius * sinf(arc);
    CGFloat x = center.x + cx - radius;
    CGFloat y = center.y + cy - radius;
  
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, 2*radius, 2*radius) cornerRadius:radius];
    return path;
}

-(CGRect)getRectWithCenter:(CGPoint)center radius:(CGFloat)radius orbitRadius:(CGFloat)orbitRadius degrees:(CGFloat)degrees{
    
    CGFloat arc = M_PI*2 * (degrees/360.f) - M_PI_2;
    CGFloat cx = orbitRadius * cosf(arc);
    CGFloat cy = orbitRadius * sinf(arc);
    CGFloat x = center.x + cx - radius;
    CGFloat y = center.y + cy - radius;
    
    return   CGRectMake(x, y, 2*radius, 2*radius);
}

-(void)drawImageWithImage:(UIImage*)image imageRadius:(CGFloat)imageRadius orbitRadius:(CGFloat)orbitRadius center:(CGPoint)center degrees:(CGFloat)degrees{

    
    CGRect image1Rect =   [self getRectWithCenter:center radius:imageRadius orbitRadius:orbitRadius degrees:degrees];
    [image drawInRect:image1Rect];
}


-(void)setupAnimationInLayer:(CALayer*)layer {
    CFTimeInterval duration = 1;
    CFTimeInterval beginTime = CACurrentMediaTime();
//    NSArray *beginTimes = @[@0, @0.2, @0.4];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.duration = duration;
    scaleAnimation.fromValue = @0;
    scaleAnimation.toValue = @1;
    scaleAnimation.removedOnCompletion = NO;
    
   CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    
    opacityAnimation.duration = duration;
    opacityAnimation.keyTimes = @[@0, @0.05,@1];
    opacityAnimation.values = @[@0, @1, @0];
    opacityAnimation.removedOnCompletion = NO;
    
   CAAnimationGroup *animation = [[CAAnimationGroup alloc] init];
   animation.animations = @[scaleAnimation, opacityAnimation];
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

    animation.duration = duration;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    
    animation.beginTime = beginTime;
    
    [layer addAnimation:animation forKey:@"scaleAnimation"];
}

-(void)removeAnimationInLayer:(CALayer*)layer {
    [layer removeAnimationForKey:@"scaleAnimation"];
}

-(void)setupLayer:(CAShapeLayer*)layer center:(CGPoint)center radius:(CGFloat)radius orbitRadius:(CGFloat)orbitRadius degrees:(CGFloat)degrees{
    
    UIBezierPath *image1BgPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2*radius, 2*radius) cornerRadius:radius];
    
    CGRect image1Rect = [self getRectWithCenter:center radius:radius orbitRadius:orbitRadius degrees:degrees];
    
    layer.path = image1BgPath.CGPath;
    layer.frame = image1Rect;
 
}


#pragma mark -

-(void)setImages:(NSArray *)images{
    _images = [images copy];
    [self setNeedsDisplay];
}

-(void)setAnimations:(NSArray *)animations{
    _animations = [animations copy];
    [self setNeedsDisplay];
}
//-(NSMutableArray *)animationLayers{
//    if (!_animationLayers) {
//        animationLayers = [[NSMutableArray alloc] init];
//    }
//
//    return animationLayers;
//}
@end
