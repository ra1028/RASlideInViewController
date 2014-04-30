RASlideInViewController
=======================

#### RASlideInViewController has an transition effect expressing the depth, and you can dismiss it by draging.


### Screen shots
![screen shot1](https://github.com/ra1028/RASlideInViewController/raw/master/screenshots/screenshot1.png)
![screen shot2](https://github.com/ra1028/RASlideInViewController/raw/master/screenshots/screenshot2.png)


### Installation

Please add the library into your project, and create subclass of this class.

#### Example
```Objective-C
    UIStoryboard *storyboard = self.storyboard;
    RANewSlideInViewController *slideViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([RANewSlideInViewController class])];
    
    [self presentViewController:slideViewController animated:NO completion:nil];
```

```Objective-C
    UIStoryboard *storyboard = self.storyboard;
    RANewSlideInViewController *slideViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([RANewSlideInViewController class])];
    slideViewController.slideInDirection = RASlideInDirectionLeftToRight;
    
    _subWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _subWindow.windowLevel = UIWindowLevelStatusBar;
    _subWindow.rootViewController = slideViewController;
    [_subWindow makeKeyAndVisible];
```

#### Option
```Objective-C
    typedef NS_ENUM(NSInteger, RASlideViewSlideInDirection)
    {
        RASlideInDirectionBottomToTop,
        RASlideInDirectionRightToLeft,
        RASlideInDirectionTopToBottom,
        RASlideInDirectionLeftToRight
    };

    @interface RASlideInViewController : UIViewController

    @property (nonatomic, assign) CGFloat animationDuration; //recommend 0.1f ~ 1.0f
    @property (nonatomic, assign) CGFloat backdropViewScaleReductionRatio; //recommend 0.9f ~ 1.0f
    @property (nonatomic, assign) RASlideViewSlideInDirection slideInDirection;
    
    @end
```

### License
RASlideInViewController is released under the MIT License, see LICENSE.txt.
