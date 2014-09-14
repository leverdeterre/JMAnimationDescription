//
//  JMAnimationDescription.m
//  JMAnimationDescription
//
//  Created by jerome morissard on 14/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMAnimationDescription.h"
NSString * const JMAnimationDidFinishNotification = @"JMAnimationDidFinishNotification";

typedef NS_ENUM(NSUInteger, JMAnimationOrder) {
    JMAnimationOrderNormal,
    JMAnimationOrderReverse
};

@interface JMAnimationDescription()
@property (strong, nonatomic) NSMutableArray *steps;
@property (assign, nonatomic) NSInteger currentIndex;
@property (assign, nonatomic) JMAnimationOrder order;
@end

@implementation JMAnimationDescription

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.order = JMAnimationOrderNormal;
        self.repeatCount = 1;
    }
    return self;
}

- (JMAnimationDescription *)initWithAnimationBlock:(JMAnimationBlock)block duration:(NSTimeInterval)duration;
{
    self = [self init];
    if (self) {
        self.steps = [NSMutableArray new];
        [self.steps addObject:[JMAnimationStep stepWithBlock:block delay:0.0 duration:duration]];
    }

    return self;
}

- (void)thenExecuteAnimationBlock:(JMAnimationBlock)block duration:(NSTimeInterval)duration
{
    [self.steps addObject:[JMAnimationStep  stepWithBlock:block delay:0.0 duration:duration]];
}

- (void)thenExecuteAnimationBlock:(JMAnimationBlock)block afterDelay:(NSTimeInterval)delay duration:(NSTimeInterval)duration
{
    [self.steps addObject:[JMAnimationStep  stepWithBlock:block delay:delay duration:duration]];
}

- (void)startAnimation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.order = JMAnimationOrderNormal;
        [self continueAnimation];
    });
}

- (void)startReverseAnimation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.order = JMAnimationOrderReverse;
        self.repeatCount = 1;
        [self continueAnimation];
    });
}

- (void)continueAnimation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self computeNextIndex] != NSNotFound) {
            JMAnimationStep *step = [self currentStep];
            [UIView animateWithDuration:step.duration delay:step.delay options:0 animations:^{
                step.block();
            } completion:^(BOOL finished) {
                [self continueAnimation];
            }];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:JMAnimationDidFinishNotification object:nil];
        }
    });
}

- (NSInteger)computeNextIndex
{
    if (self.order == JMAnimationOrderNormal) {
        //Repeat
        if (self.currentIndex + 1 >= self.steps.count) {
            if (self.repeatCount > 1) {
                self.repeatCount--;
                self.currentIndex--;
                self.order = JMAnimationOrderReverse;
                return self.currentIndex;
            }
        } else {
            self.currentIndex++;
            return (self.currentIndex);
        }
        
    } else {
        if (self.currentIndex - 1 < 0) {
            if (self.repeatCount > 1) {
                self.repeatCount--;
                self.currentIndex++;
                self.order = JMAnimationOrderNormal;
                return self.currentIndex;
            }
        } else {
            self.currentIndex--;
            return (self.currentIndex);
        }
    }
    
    return NSNotFound;
}

- (JMAnimationStep *)currentStep
{
    return [self.steps objectAtIndex:self.currentIndex];
}

@end
