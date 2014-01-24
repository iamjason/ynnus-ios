//
//  UIButton+Animations.m
//  Snap
//
//  Created by Jason Garrett on 9/17/13.
//  Copyright (c) 2013 Ulnar Nerve LLC. All rights reserved.
//

#import "UIButton+Animations.h"

@implementation UIButton (Animations)

-(void)scaleDown {
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration = 0.125;
    anim.repeatCount = 1;
    anim.autoreverses = YES;
    anim.removedOnCompletion = YES;
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 0.6)];
    [self.layer addAnimation:anim forKey:nil];
    
}

-(void)scaleReset {
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration = 0.125;
    anim.repeatCount = 1;
//    anim.autoreverses = YES;
    anim.removedOnCompletion = YES;
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    [self.layer addAnimation:anim forKey:nil];
    
}
@end
