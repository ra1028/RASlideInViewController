//
//  RACardViewController.m
//  RACardViewController
//
//  Created by Ryo Aoyama on 4/28/14.
//  Copyright (c) 2014 Ryo Aoyama. All rights reserved.
//

#import "RASlideInViewController.h"

@interface RASlideInViewController ()

@property (nonatomic, assign) BOOL appered;

@end

@implementation RASlideInViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //do any setup
        [self initialSetup];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //configre
    [self configure];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!_appered)
    {
        //alpha
        self.view.alpha = 1.0f;
        //animation
        [UIView animateWithDuration:_animationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            CGSize viewSize = self.view.bounds.size;
            self.view.frame = [self appearedAnimationStandbyPosition];
            self.view.frame = CGRectMake(0.0f, 0.0f, viewSize.width, viewSize.height);
            self.view.window.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
            [self backdropView].alpha = 0.0f;
            [self backdropView].transform = CGAffineTransformMakeScale(_backdropViewScaleReductionRatio, _backdropViewScaleReductionRatio);
        }completion:^(BOOL finished){
            _appered = YES;
            //User intraction of superView
            [self backdropView].userInteractionEnabled = NO;
        }];
    }
}

- (CGRect)appearedAnimationStandbyPosition
{
    CGSize viewSize = self.view.bounds.size;
    switch (_slideInDirection) {
        case RASlideInDirectionBottomToTop:
            return CGRectMake(0.0f, viewSize.height, viewSize.width, viewSize.height);
            break;
        case RASlideInDirectionRightToLeft:
            return CGRectMake(viewSize.width, 0.0f, viewSize.width, viewSize.height);
            break;
        case RASlideInDirectionTopToBottom:
            return CGRectMake(0.0f, -viewSize.height, viewSize.width, viewSize.height);
            break;
        case RASlideInDirectionLeftToRight:
            return CGRectMake(-viewSize.width, 0.0f, viewSize.width, viewSize.height);
            break;
        default:
            return CGRectMake(0.0f, viewSize.height, viewSize.width, viewSize.height);
            break;
    }
}

- (void)initialSetup
{
    //initial animation duration
    _animationDuration = 0.3f;
    
    //initial back drop view scale ratio
    _backdropViewScaleReductionRatio = 0.95f;
    
    //initial slide in Direction
    _slideInDirection = RASlideInDirectionBottomToTop;
}

- (void)configure
{
    //initial alpha
    self.view.alpha = 0.0f;
    
    //modal style
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    //shadow
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    self.view.layer.shadowOffset = [self shadowOffsetByDirection];
    self.view.layer.shadowOpacity = 0.5f;
    self.view.layer.shadowRadius = 2.0f;
    self.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
    self.view.layer.shouldRasterize = YES;
    self.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    //pan Gesture
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panTransitionView:)];
    [self.view addGestureRecognizer:pan];
}

- (CGSize)shadowOffsetByDirection
{
    switch (_slideInDirection) {
        case RASlideInDirectionBottomToTop:
            return CGSizeMake(0.0f, -4.0f);
            break;
        case RASlideInDirectionRightToLeft:
            return CGSizeMake(-4.0f, 0.0f);
            break;
        case RASlideInDirectionTopToBottom:
            return CGSizeMake(0.0f, 4.0f);
            break;
        case RASlideInDirectionLeftToRight:
            return CGSizeMake(4.0f, 0.0f);
            break;
        default:
            return CGSizeMake(0.0f, -4.0f);
            break;
    }
}

- (UIView *)backdropView
{
    UIView *superView;
    if (self.presentingViewController)
    {
        superView = self.presentingViewController.view;
        return superView;
    }
    else
    {
        NSArray *windows = [UIApplication sharedApplication].windows;
        NSInteger index = [windows indexOfObject:self.view.window];
        superView = ((UIWindow *)[windows objectAtIndex:index - 1]).rootViewController.view;
        return superView;
    }
}

- (void)panTransitionView:(UIPanGestureRecognizer *)sender
{
    CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            //transition
            [self viewTransition:translation];
            [self transformSuperViewControllerViewWithPercentage:[self calcPercentage]];
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            if ([self didEndDragingHandllerWithVelocity:velocity])
            {
                [self forwardTransitedView];
            }
            else
            {
                [self reverseTransitedView];
            }
            break;
        default:
            break;
    }
}

- (BOOL)didEndDragingHandllerWithVelocity:(CGPoint)velocity
{
    switch (_slideInDirection) {
        case RASlideInDirectionBottomToTop:
            if (velocity.y >= 500.0f)
            {
                return YES;
            }
            return NO;
            break;
        case RASlideInDirectionRightToLeft:
            if (velocity.x >= 500.0f)
            {
                return YES;
            }
            return NO;
            break;
        case RASlideInDirectionTopToBottom:
            if (velocity.y <= -500.0f)
            {
                return YES;
            }
            return NO;
            break;
        case RASlideInDirectionLeftToRight:
            if (velocity.x <= -500.0f)
            {
                return YES;
            }
            return NO;
            break;
        default:
            if (velocity.y >= 500.0f)
            {
                return YES;
            }
            return NO;
            break;
    }
}

- (CGFloat)calcPercentage
{
    switch (_slideInDirection) {
        case RASlideInDirectionBottomToTop:
            return self.view.frame.origin.y / [UIScreen mainScreen].bounds.size.height;
            break;
        case RASlideInDirectionRightToLeft:
            return self.view.frame.origin.x / [UIScreen mainScreen].bounds.size.width;
            break;
        case RASlideInDirectionTopToBottom:
            return (-self.view.frame.origin.y) / [UIScreen mainScreen].bounds.size.height;
            break;
        case RASlideInDirectionLeftToRight:
            return (-self.view.frame.origin.x) / [UIScreen mainScreen].bounds.size.width;
            break;
        default:
            return self.view.frame.origin.y / [UIScreen mainScreen].bounds.size.height;
            break;
    }
}

- (void)viewTransition:(CGPoint)translation
{
    //transition
    switch (_slideInDirection) {
        case RASlideInDirectionBottomToTop:
            self.view.transform = CGAffineTransformMakeTranslation(0, translation.y);
            if (self.view.frame.origin.y <= 0)
            {
                self.view.transform = CGAffineTransformIdentity;
            }
            break;
        case RASlideInDirectionRightToLeft:
            self.view.transform = CGAffineTransformMakeTranslation(translation.x, 0);
            if (self.view.frame.origin.x <= 0)
            {
                self.view.transform = CGAffineTransformIdentity;
            }
            break;
        case RASlideInDirectionTopToBottom:
            self.view.transform = CGAffineTransformMakeTranslation(0, translation.y);
            if (self.view.frame.origin.y >= 0)
            {
                self.view.transform = CGAffineTransformIdentity;
            }
            break;
        case RASlideInDirectionLeftToRight:
            self.view.transform = CGAffineTransformMakeTranslation(translation.x, 0);
            if (self.view.frame.origin.x >= 0)
            {
                self.view.transform = CGAffineTransformIdentity;
            }
            break;
        default:
            self.view.transform = CGAffineTransformMakeTranslation(0, translation.y);
            if (self.view.frame.origin.y <= 0)
            {
                self.view.transform = CGAffineTransformIdentity;
            }
            break;
    }
}

- (void)transformSuperViewControllerViewWithPercentage:(CGFloat)percentage
{
    [self backdropView].alpha = percentage;
    [self backdropView].transform = CGAffineTransformMakeScale(_backdropViewScaleReductionRatio + ((1.0f - _backdropViewScaleReductionRatio)*percentage), _backdropViewScaleReductionRatio + ((1.0f - _backdropViewScaleReductionRatio)*percentage));
    if (!self.presentingViewController)
    {
        self.view.window.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    }
}

- (void)reverseTransitedView
{
    [UIView animateWithDuration:_animationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.view.transform = CGAffineTransformIdentity;
        [self backdropView].alpha = 0;
        [self backdropView].transform = CGAffineTransformMakeScale(_backdropViewScaleReductionRatio, _backdropViewScaleReductionRatio);
    }completion:^(BOOL finished){
        self.view.window.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    }];
}

- (void)forwardTransitedView
{
    [UIView animateWithDuration:_animationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (self.presentingViewController)
        {
            self.view.transform = [self forwardTransformByDirection];
        }
        else
        {
            self.view.transform = CGAffineTransformIdentity;
            self.view.window.transform = [self forwardTransformByDirection];
        }
        [self backdropView].alpha = 1.0;
        [self backdropView].transform = CGAffineTransformIdentity;
    }completion:^(BOOL finised){
        [self backdropView].userInteractionEnabled = YES;
        if (self.presentingViewController)
        {
            [self dismissViewControllerAnimated:NO completion:nil];
        }
        else
        {
            self.view.window.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
            self.view.window.hidden = YES;
        }
    }];
}

- (CGAffineTransform)forwardTransformByDirection
{
    switch (_slideInDirection) {
        case RASlideInDirectionBottomToTop:
            return CGAffineTransformMakeTranslation(0.0f, [UIScreen mainScreen].bounds.size.height);
            break;
        case RASlideInDirectionRightToLeft:
            return CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0.0f);
            break;
        case RASlideInDirectionTopToBottom:
            return CGAffineTransformMakeTranslation(0.0f, -[UIScreen mainScreen].bounds.size.height);
            break;
        case RASlideInDirectionLeftToRight:
            return CGAffineTransformMakeTranslation(-[UIScreen mainScreen].bounds.size.width, 0.0f);
            break;
        default:
            return CGAffineTransformMakeTranslation(0.0f, [UIScreen mainScreen].bounds.size.height);
            break;
    }
}

@end
