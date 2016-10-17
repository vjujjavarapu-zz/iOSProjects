//
//  PresentDetailTransition.m
//  FinalApp
//
//  Created by Venkatesh Jujjavarapu on 10/29/15.
//  Copyright © 2015 sitacorp. All rights reserved.
//

#import "PresentDetailTransition.h"

@implementation PresentDetailTransition

// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.3;
    
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *detail = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    UIView *containerView = [transitionContext containerView];
    
    detail.view.alpha = 0.0;
    
    CGRect frame = containerView.bounds;
    
    frame.origin.y+=20;
    frame.size.height-=20;
    
    detail.view.frame = frame;

    
    [containerView addSubview:detail.view];
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        detail.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
   
    
}



@end
