//
//  JMAnimationDescription.h
//  JMAnimationDescription
//
//  Created by jerome morissard on 14/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMAnimationStep.h"

FOUNDATION_EXPORT NSString * const JMAnimationDidFinishNotification;

@interface JMAnimationDescription : NSObject

- (JMAnimationDescription *)initWithAnimationBlock:(JMAnimationBlock)block duration:(NSTimeInterval)duration;

- (void)thenExecuteAnimationBlock:(JMAnimationBlock)block duration:(NSTimeInterval)duration;
- (void)thenExecuteAnimationBlock:(JMAnimationBlock)block afterDelay:(NSTimeInterval)delay duration:(NSTimeInterval)duration;

- (void)startAnimation;

@end
