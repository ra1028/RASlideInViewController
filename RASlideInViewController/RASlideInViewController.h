//
//  RACardViewController.h
//  RACardViewController
//
//  Created by Ryo Aoyama on 4/28/14.
//  Copyright (c) 2014 Ryo Aoyama. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RASlideViewSlideInDirection)
{
    RASlideInDirectionBottomToTop,
    RASlideInDirectionRightToLeft,
    RASlideInDirectionTopToBottom,
    RASlideInDirectionLeftToRight
};

@interface RASlideInViewController : UIViewController

@property (nonatomic, assign) CGFloat animationDuration; //recommend 0.1f - 1.0f
@property (nonatomic, assign) CGFloat backdropViewScaleReductionRatio; //recommend 0.9f - 1.0f
@property (nonatomic, assign) RASlideViewSlideInDirection slideInDirection;

@end
