//
//  RAViewController.m
//  RACardViewController
//
//  Created by Ryo Aoyama on 4/28/14.
//  Copyright (c) 2014 Ryo Aoyama. All rights reserved.
//

#import "RAViewController.h"
#import "RANewSlideInViewController.h"

@interface RAViewController ()

@property (nonatomic, strong) UIWindow *subWindow;

@end

@implementation RAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
}
- (IBAction)addNewView:(UIButton *)sender
{
    UIStoryboard *storyboard = self.storyboard;
    RANewSlideInViewController *cardViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([RANewSlideInViewController class])];
    
    [self presentViewController:cardViewController animated:NO completion:nil];
}

- (IBAction)addNewWindow:(UIButton *)sender
{
    UIStoryboard *storyboard = self.storyboard;
    RANewSlideInViewController *cardViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([RANewSlideInViewController class])];
    cardViewController.slideInDirection = RASlideInDirectionLeftToRight;
    
    _subWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _subWindow.windowLevel = UIWindowLevelStatusBar;
    _subWindow.rootViewController = cardViewController;
    [_subWindow makeKeyAndVisible];
}

@end
