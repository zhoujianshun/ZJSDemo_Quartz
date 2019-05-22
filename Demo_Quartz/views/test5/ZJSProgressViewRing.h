//
//  ZJSProgressViewRing.h
//  Demo_Quartz
//
//  Created by 周建顺 on 15/10/12.
//  Copyright © 2015年 周建顺. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJSProgressViewRing : UIView

@property (nonatomic) CGFloat progress;
@property (nonatomic,strong) UIColor *primaryColor;
@property (nonatomic,strong) UIColor *secondaryColor;
@property (nonatomic) CGFloat backgroundRingWidth;
@property (nonatomic) CGFloat progressRingWidth;


@end
