//
//  JMAnimationStep.m
//  JMAnimationDescription
//
//  Created by jerome morissard on 14/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMAnimationStep.h"

@implementation JMAnimationStep

+ (instancetype)stepWithBlock:(JMAnimationBlock)block delay:(NSTimeInterval)delay duration:(NSTimeInterval)duration
{
    JMAnimationStep *step = [JMAnimationStep new];
    step->_block = [block copy];
    step->_delay = delay;
    step->_duration = duration;
    return step;
}

@end
