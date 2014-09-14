//
//  JMAnimationStep.h
//  JMAnimationDescription
//
//  Created by jerome morissard on 14/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^JMAnimationBlock)();

@interface JMAnimationStep : NSObject
@property (readonly, copy, nonatomic) JMAnimationBlock block;
@property (readonly, assign, nonatomic) NSTimeInterval duration;
@property (readonly, assign, nonatomic) NSTimeInterval delay;

+ (instancetype)stepWithBlock:(JMAnimationBlock)block delay:(NSTimeInterval)delay duration:(NSTimeInterval)duration;

@end
