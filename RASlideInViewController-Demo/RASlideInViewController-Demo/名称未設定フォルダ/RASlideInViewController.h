//
//  RACardViewController.h
//  RACardViewController
//
//  Created by Ryo Aoyama on 4/28/14.
//  Copyright (c) 2014 Ryo Aoyama. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RASlideViewSlideInDirection){
    RASlideInDirectionBottomToTop,
    RASlideInDirectionRightToLeft,
    RASlideInDirectionTopToBottom,
    RASlideInDirectionLeftToRight
};

@interface RASlideInViewController : UIViewController

@property (nonatomic, assign) RASlideViewSlideInDirection slideInDirection; //default RASlideInDirectionBottomToTop;
@property (nonatomic, assign) BOOL shiftBackDropView; //default NO
@property (nonatomic, assign) CGFloat animationDuration; //default .3f
@property (nonatomic, assign) CGFloat backdropViewScaleReductionRatio; //default .9f
@property (nonatomic, assign) CGFloat shiftBackDropViewValue; //default 100.f
@property (nonatomic, assign) CGFloat backDropViewAlpha; //default 0

@end
