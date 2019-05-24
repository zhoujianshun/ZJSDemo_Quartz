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
@property (nonatomic, strong) CALayer *imagePointLayer;
@property (nonatomic, strong) CALayer *imagePoint2Layer;

@property (nonatomic, assign) CFTimeInterval duration1;
@property (nonatomic, assign) CFTimeInterval duration2;


/// 光圈缩放动画
@property (nonatomic, copy) NSArray *animationLayers;;
@property (nonatomic, strong) CAShapeLayer *image1AnimationLayer;
@property (nonatomic, strong) CAShapeLayer *image2AnimationLayer;
@property (nonatomic, strong) CAShapeLayer *image3AnimationLayer;
@property (nonatomic, strong) CAShapeLayer *image4AnimationLayer;
@property (nonatomic, assign) CFTimeInterval imageAnimationDuration;

@property (nonatomic, strong) UIColor *imageAnimationColor;
@property (nonatomic, copy) NSArray *imagesLayerArray;
@property (nonatomic, strong) CALayer *image1Layer;
@property (nonatomic, strong) CALayer *image2Layer;
@property (nonatomic, strong) CALayer *image3Layer;
@property (nonatomic, strong) CALayer *image4Layer;


// Wi-Fi波浪动画
@property (nonatomic, copy) NSArray *waveAnimationLayers;;
@property (nonatomic, strong) CAShapeLayer *wave1AnimationLayer;
@property (nonatomic, strong) CAShapeLayer *wave2AnimationLayer;
@property (nonatomic, strong) CAShapeLayer *wave3AnimationLayer;
@property (nonatomic, assign) CFTimeInterval waveAnimationduration;



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
    
    _duration1 = 6;
    _duration2 = 5;
    
    _imageAnimationDuration = 2.f;
    _waveAnimationduration = 2.f;
    
    _mainColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    _imageAnimationColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    
    
    
    ////////////////////
    _image1AnimationLayer = [[CAShapeLayer alloc] init];
    _image2AnimationLayer = [[CAShapeLayer alloc] init];
    _image3AnimationLayer = [[CAShapeLayer alloc] init];
    _image4AnimationLayer = [[CAShapeLayer alloc] init];
    
    _animationLayers = @[_image1AnimationLayer, _image2AnimationLayer,_image3AnimationLayer, _image4AnimationLayer];
    
    [_animationLayers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAShapeLayer *layer = obj;
        [layer setFillColor:self.imageAnimationColor.CGColor];
        [self.layer addSublayer:layer];
    }];
    
    
    ////////////////////////
    _wave1AnimationLayer = [[CAShapeLayer alloc] init];
    _wave2AnimationLayer = [[CAShapeLayer alloc] init];
    _wave3AnimationLayer = [[CAShapeLayer alloc] init];
    
    _waveAnimationLayers = @[_wave1AnimationLayer, _wave2AnimationLayer, _wave3AnimationLayer];
    
    [_waveAnimationLayers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAShapeLayer *layer = obj;
        layer.backgroundColor = [UIColor clearColor].CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor whiteColor].CGColor;
        layer.lineCap = kCALineCapRound;
        [self.layer addSublayer:layer];
    }];
    
    
    ////////////////
    
    _image1Layer = [[CALayer alloc] init];
    _image2Layer = [[CALayer alloc] init];
    _image3Layer = [[CALayer alloc] init];
    _image4Layer = [[CALayer alloc] init];
    
    _imagesLayerArray = @[_image1Layer, _image2Layer, _image3Layer, _image4Layer];
    [_imagesLayerArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CALayer *layer = obj;
        [self.layer addSublayer:layer];
    }];
    
    
    
    
    /////////////////////
    _imagePointLayer = [[CALayer alloc] init];
    
    if ([UIImage imageNamed:@"security_center_animation_flash_point"]) {
        _imagePointLayer.contents = (__bridge id)[UIImage imageNamed:@"security_center_animation_flash_point"].CGImage;
    }else{
        _imagePointLayer.backgroundColor = [UIColor redColor].CGColor;
    }
    
    [self.layer addSublayer:_imagePointLayer];
    
    
    _imagePoint2Layer = [[CALayer alloc] init];
    if ([UIImage imageNamed:@"security_center_animation_flash_point"]) {
        _imagePoint2Layer.contents = (__bridge id)[UIImage imageNamed:@"security_center_animation_flash_point"].CGImage;
    }else{
        _imagePoint2Layer.backgroundColor = [UIColor blueColor].CGColor;
    }
    
    [self.layer addSublayer:_imagePoint2Layer];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.frame) - 2 * kInterSpace;
    CGFloat height = CGRectGetHeight(self.frame) - 2 * kInterSpace;
    
    CGFloat radius = width > height ? height/2.f : width/2.f;
    
    //    CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2.f, CGRectGetHeight(self.frame)/2.f);
    
    CGFloat w = 44/270.f * (2*radius);
    CGFloat h = 44/270.f * (2*radius);
    self.imagePointLayer.frame = CGRectMake(CGRectGetWidth(self.frame)/2.f - w/2, CGRectGetHeight(self.frame)/2 - radius - h/2.f, w, h);
    
    
    CGFloat  radius2 = radius  - 45.f/270.f*(radius*2);
    self.imagePoint2Layer.frame = CGRectMake(CGRectGetWidth(self.frame)/2.f - w/2, CGRectGetHeight(self.frame)/2 - radius2 - h/2.f, w, h);
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self.mainColor setFill];
    [self.mainColor setStroke];
    
    [self drawCenter:rect];
    [self drawPath1:rect];
    [self drawPath2:rect];
    [self drawPath3:rect];
    
}

-(void)drawCenter:(CGRect)rect{
    CGFloat width = CGRectGetWidth(rect) - 2 * kInterSpace;
    CGFloat height = CGRectGetHeight(rect) - 2 * kInterSpace;
    CGPoint center = CGPointMake(CGRectGetWidth(rect)/2.f, CGRectGetHeight(rect)/2.f);
    
    CGFloat radius = width > height ? height/2.f : width/2.f;
    CGFloat scale = ((radius*2)/270.f);
    
    // center image
    CGFloat offset = 3*scale;
    CGFloat imageWidth = 50 * scale;
    CGFloat imageHeight = 60 * scale ;
    CGRect imageRect = CGRectMake(center.x - imageWidth/2.f, center.y - imageHeight/2.f + offset, imageWidth, imageHeight);
    
    // oval
    CGFloat  ovalHeight = 12 * scale;
    CGFloat  ovalWidth = 60 * scale;
    CGRect ovalRect = CGRectMake(center.x - ovalWidth/2.f, center.y + imageHeight/2.f - offset, ovalWidth, ovalHeight);
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
    [ovalPath fill];
    
    // draw center image
    [[UIImage imageNamed:@"security_center_animation_shield"] drawInRect:imageRect];
    
    
    CGFloat image2Width = 30 * scale;
    CGFloat image2Height = 15 * scale ;
    CGRect image2Rect = CGRectMake(CGRectGetMinX(imageRect) - image2Width/2.f, CGRectGetMinY(imageRect) - 3*scale, image2Width, image2Height);
    [[UIImage imageNamed:@"security_center_animation_hours"] drawInRect:image2Rect];
    //
    
    CGPoint waveCenter = CGPointMake(center.x + imageWidth/2.f - 1.5*scale, center.y - imageHeight/2.f + 6*scale);
    CGFloat waveBorderWidth = 2*scale;
    CGFloat wave1Radius = 5*scale;
    CGFloat wave2Radius = wave1Radius + 4*scale;
    CGFloat wave3Radius = wave2Radius + 4*scale;
    
    
    [self drawArcInLayer:self.wave1AnimationLayer arcCenter:waveCenter radius:wave1Radius lineWidth:waveBorderWidth];
    [self drawArcInLayer:self.wave2AnimationLayer arcCenter:waveCenter radius:wave2Radius lineWidth:waveBorderWidth];
    [self drawArcInLayer:self.wave3AnimationLayer arcCenter:waveCenter radius:wave3Radius lineWidth:waveBorderWidth];
}

-(void)drawArcInLayer:(CAShapeLayer*)layer arcCenter:(CGPoint)center radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth{
    UIBezierPath *wavePath3 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(0, radius) radius:radius startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    layer.frame = CGRectMake(center.x, center.y - radius, radius, radius);
    layer.lineWidth = lineWidth;
    layer.path = wavePath3.CGPath;
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
    
    
    
    [self setupAtIndex:3 center:center radius:((33*scale/2.f) + 2) orbitRadius:orbitRadius degrees:image1Degrees];
    
    if (self.images[3]) {
        [self drawImageAtIndex:3 imageRadius:image1Radius orbitRadius:orbitRadius center:center degrees:image1Degrees];
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
    
    
    [self setupAtIndex:0 center:center radius:(((33.f*scale)/2.f) + 2) orbitRadius:orbitRadius degrees:image3Degrees];
    
    
    if (self.images[0]) {
        [self drawImageAtIndex:0 imageRadius:image3Radius orbitRadius:orbitRadius center:center degrees:image3Degrees];
    }
    
    
    // image 2
    CGFloat image2Radius = (60*scale)/2.f;
    CGFloat image2Degrees =(interval2.start + (interval2.end - interval2.start)/2.f);
    
    
    [self setupAtIndex:1 center:center radius:(((40.f*scale)/2.f) + 2) orbitRadius:orbitRadius degrees:image2Degrees];
    
    
    if (self.images[1]) {
        [self drawImageAtIndex:1 imageRadius:image2Radius orbitRadius:orbitRadius center:center degrees:image2Degrees];
    }
    
    
    // image 3
    CGFloat image1Radius = (60*scale)/2.f;
    CGFloat image1Degrees =(interval4.start + (interval4.end - interval4.start)/2.f);
    
    
    [self setupAtIndex:2 center:center radius:(image1Radius + 2) orbitRadius:orbitRadius degrees:image1Degrees];
    
    
    if (self.images[2]) {
        [self drawImageAtIndex:2 imageRadius:image1Radius orbitRadius:orbitRadius center:center degrees:image1Degrees];
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

-(void)drawImageAtIndex:(NSInteger)index imageRadius:(CGFloat)imageRadius orbitRadius:(CGFloat)orbitRadius center:(CGPoint)center degrees:(CGFloat)degrees{
    
    UIImage *image = self.images[index];
    CALayer *layer = self.imagesLayerArray[index];
    CGRect image1Rect =   [self getRectWithCenter:center radius:imageRadius orbitRadius:orbitRadius degrees:degrees];
    layer.frame = image1Rect;
    layer.contents = (__bridge id)image.CGImage;
    
    
}

#pragma mark - 动画


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
    
    
    [self addAnimationTo:_imagePointLayer path:path duration:self.duration1];
    
    
    CGFloat  radius2 = radius  - 45.f/270.f*(radius*2);
    
    UIBezierPath* path2 = [[UIBezierPath alloc] init];
    [path2 addArcWithCenter:center
                     radius:radius2
                 startAngle:M_PI_2
                   endAngle:2 * M_PI + M_PI_2
                  clockwise:1];
    
    [self addAnimationTo:_imagePoint2Layer path:path2 duration:self.duration2];
    
    
    
    [self startImagesScaleAnimation];
    
    [self removeWaveAnimation];
    [self setupWaveAnimation];
    
}

-(void)startImagesScaleAnimation{
    // 光圈缩放动画
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
    animation1.removedOnCompletion = NO;
    
    if (![layer.animationKeys containsObject:@"position"]) {
        [layer addAnimation:animation1 forKey:@"position"];
    }
}

-(void)setupAnimationInLayer:(CALayer*)layer {
    CFTimeInterval duration = _imageAnimationDuration;
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
    
    if (![layer.animationKeys containsObject:@"scaleAnimation"]) {
        [layer addAnimation:animation forKey:@"scaleAnimation"];
    }
}

-(void)removeAnimationInLayer:(CALayer*)layer {
    [layer removeAnimationForKey:@"scaleAnimation"];
}



-(void)setupWaveAnimation{
    CFTimeInterval duration = _waveAnimationduration;
    CFTimeInterval beginTime = CACurrentMediaTime();
    
    NSArray *values = @[@[@0.5, @0.5, @1, @1],
                        @[@0.5, @0.5, @0.5, @1, @1],
                        @[@0.5, @0.5, @0.5, @0.5, @1]];
    
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    
    opacityAnimation.duration = duration;
    opacityAnimation.keyTimes = @[@0, @0.25, @0.5, @0.75, @1];
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.duration = duration;
    opacityAnimation.repeatCount = MAXFLOAT;
    opacityAnimation.removedOnCompletion = NO;
    
    opacityAnimation.beginTime = beginTime;
    
    [self.waveAnimationLayers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        opacityAnimation.values = values[idx];
        CAShapeLayer *layer = obj;
        if (![layer.animationKeys containsObject:@"waveAnimation"]) {
            [layer addAnimation:opacityAnimation forKey:@"waveAnimation"];
        }
        
    }];
    
}

-(void)removeWaveAnimation{
    [self.waveAnimationLayers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAShapeLayer *layer = obj;
        [layer removeAnimationForKey:@"waveAnimation"];
    }];
}

-(void)setupAtIndex:(NSInteger)index center:(CGPoint)center radius:(CGFloat)radius orbitRadius:(CGFloat)orbitRadius degrees:(CGFloat)degrees{
    
    CAShapeLayer *layer = self.animationLayers[index];
    BOOL animation = [self.animations[index] boolValue];
    
    UIBezierPath *image1BgPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2*radius, 2*radius) cornerRadius:radius];
    
    CGRect image1Rect = [self getRectWithCenter:center radius:radius orbitRadius:orbitRadius degrees:degrees];
    layer.frame = image1Rect;
    layer.path = image1BgPath.CGPath;
    layer.hidden = !animation;
    
}


#pragma mark -

-(void)setImages:(NSArray *)images{
    _images = [images copy];
    [self setNeedsDisplay];
}

-(void)setAnimations:(NSArray *)animations{
    _animations = [animations copy];
    [self startImagesScaleAnimation];
}



@end
