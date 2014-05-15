RASlideInViewController
=======================

#### RASlideInViewController has an transition effect expressing the depth, and you can dismiss it by draging.


### Screen shots
![screen shot1](https://github.com/ra1028/RASlideInViewController/raw/master/Assets/screenshot1.png)
![screen shot2](https://github.com/ra1028/RASlideInViewController/raw/master/Assets/screenshot2.png)
![screen shot3](https://github.com/ra1028/RASlideInViewController/raw/master/Assets/screenshot3.png)


### Example animation
![animated gif](https://github.com/ra1028/RASlideInViewController/raw/master/Assets/animation.gif)

### Usage

Please add the library into your project, and create subclass of this class.

#### Example
```Objective-C
    UIStoryboard *storyboard = self.storyboard;
    RANewSlideInViewController *slideViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([RANewSlideInViewController class])];
    
    self.modalPresentationStyle = UIModalPresentationCurrentContext;  //***
    
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
```

### License
RASlideInViewController is released under the MIT License, see LICENSE.txt.
