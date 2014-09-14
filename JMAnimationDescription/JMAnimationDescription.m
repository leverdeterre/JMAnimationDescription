//
//  JMAnimationDescription.m
//  JMAnimationDescription
//
//  Created by jerome morissard on 14/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMAnimationDescription.h"
NSString * const JMAnimationDidFinishNotification = @"JMAnimationDidFinishNotification";

@interface JMAnimationDescription()
@property (strong, nonatomic) NSMutableArray *steps;
@property (strong, nonatomic) NSOperationQueue *animationQueue;
@end

@implementation JMAnimationDescription

- (JMAnimationDescription *)initWithAnimationBlock:(JMAnimationBlock)block duration:(NSTimeInterval)duration;
{
    self.steps = [NSMutableArray new];
    [self.steps addObject:[JMAnimationStep stepWithBlock:block delay:0.0 duration:duration]];
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
        [self continueAnimation];
    });
}

- (void)continueAnimation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.steps.count > 0) {
            JMAnimationStep *step = [self.steps firstObject];
            [UIView animateWithDuration:step.duration delay:step.delay options:0 animations:^{
                step.block();
            } completion:^(BOOL finished) {
                [self.steps removeObjectAtIndex:0];
                [self continueAnimation];
            }];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:JMAnimationDidFinishNotification object:nil];
        }
    });
}

@end
