//
//  PushButton.m
//  Snap
//
//  Created by Jason Garrett on 9/13/13.
//  Copyright (c) 2013 Ulnar Nerve LLC. All rights reserved.
//

#import "PushButton.h"
#import "UIButton+Animations.h"

@implementation PushButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}

-(void)awakeFromNib {
    [self setUpView];
}

-(void)dealloc {
    [self removeTarget:self action:@selector(_animateButtonDown:) forControlEvents:UIControlEventTouchDown];
}

-(void)setUpView {
    
//    [self addTarget:self action:@selector(_animateButtonDown:) forControlEvents:UIControlEventTouchDown];

    self.backgroundColor = COLOR_BUTTON_BLUE;
    //[UIColor colorWithRed:0.996 green:0.922 blue:0.176 alpha:1.000];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
//    self.title = self.titleLabel.text;
//    [self setTitle:@"" forState:UIControlStateNormal];
    
}

-(void)_animateButtonDown:(UIButton*)button {
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration = 0.075;
    anim.repeatCount = 1;
    anim.autoreverses = YES;
    anim.removedOnCompletion = YES;
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6, 0.6, 0.6)];
    [self.layer addAnimation:anim forKey:nil];
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self _animateButtonDown:nil];
}
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    //// General Declarations
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    //// Color Declarations
//    UIColor* gradientColor2 = [UIColor colorWithRed: 0 green: 0.698 blue: 0.322 alpha: 1];
//    UIColor* gradientColor = [UIColor colorWithRed: 0.031 green: 0.796 blue: 0.384 alpha: 1];
//    UIColor* shadowColor2 = [UIColor colorWithRed: 0.176 green: 0.192 blue: 0.208 alpha: 0.196];
//    
//    //// Gradient Declarations
//    NSArray* greenGradientColors = [NSArray arrayWithObjects:
//                                    (id)gradientColor.CGColor,
//                                    (id)gradientColor2.CGColor, nil];
//    CGFloat greenGradientLocations[] = {0, 1};
//    CGGradientRef greenGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)greenGradientColors, greenGradientLocations);
//    
//    //// Shadow Declarations
//    UIColor* shadow = shadowColor2;
//    CGSize shadowOffset = CGSizeMake(0.1, 2.1);
//    CGFloat shadowBlurRadius = 3;
//    
//    //// Frames
//    CGRect frame = rect;
//    
//    
//    //// Join Button Drawing
//    CGRect joinButtonRect = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame));
//    UIBezierPath* joinButtonPath = [UIBezierPath bezierPathWithRoundedRect: joinButtonRect cornerRadius: 4];
//    CGContextSaveGState(context);
//    [joinButtonPath addClip];
//    CGContextDrawLinearGradient(context, greenGradient,
//                                CGPointMake(CGRectGetMidX(joinButtonRect), CGRectGetMinY(joinButtonRect)),
//                                CGPointMake(CGRectGetMidX(joinButtonRect), CGRectGetMaxY(joinButtonRect)),
//                                0);
//    CGContextRestoreGState(context);
//    
//    ////// Join Button Inner Shadow
//    CGRect joinButtonBorderRect = CGRectInset([joinButtonPath bounds], -shadowBlurRadius, -shadowBlurRadius);
//    joinButtonBorderRect = CGRectOffset(joinButtonBorderRect, -shadowOffset.width, -shadowOffset.height);
//    joinButtonBorderRect = CGRectInset(CGRectUnion(joinButtonBorderRect, [joinButtonPath bounds]), -1, -1);
//    
//    UIBezierPath* joinButtonNegativePath = [UIBezierPath bezierPathWithRect: joinButtonBorderRect];
//    [joinButtonNegativePath appendPath: joinButtonPath];
//    joinButtonNegativePath.usesEvenOddFillRule = YES;
//    
//    CGContextSaveGState(context);
//    {
//        CGFloat xOffset = shadowOffset.width + round(joinButtonBorderRect.size.width);
//        CGFloat yOffset = shadowOffset.height;
//        CGContextSetShadowWithColor(context,
//                                    CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
//                                    shadowBlurRadius,
//                                    shadow.CGColor);
//        
//        [joinButtonPath addClip];
//        CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(joinButtonBorderRect.size.width), 0);
//        [joinButtonNegativePath applyTransform: transform];
//        [[UIColor grayColor] setFill];
//        [joinButtonNegativePath fill];
//    }
//    CGContextRestoreGState(context);
//    
//    [[UIColor whiteColor] setFill];
//    [self.title drawInRect: CGRectInset(joinButtonRect, 0, 15) withFont: [UIFont fontWithName: @"MuseoSlab-500" size: 18] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
//    
//    
//    //// Cleanup
//    CGGradientRelease(greenGradient);
//    CGColorSpaceRelease(colorSpace);
//    
//    
//
//}




@end
