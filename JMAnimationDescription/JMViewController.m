//
//  JMViewController.m
//  JMAnimationDescription
//
//  Created by jerome morissard on 14/09/14.
//  Copyright (c) 2014 jerome morissard. All rights reserved.
//

#import "JMViewController.h"
#import "JMAnimationDescription.h"

@interface JMViewController ()
@property (weak, nonatomic) IBOutlet UIView *animatedView;
@property (strong, nonatomic)  JMAnimationDescription *animation;
@end

@implementation JMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.animatedView.backgroundColor = [UIColor redColor];
    
    self.animation = [[JMAnimationDescription alloc] initWithAnimationBlock:^{
        self.animatedView.frame = CGRectMake(10.0f, 10.0f, 100.0f, 100.0f);
    } duration:1.0];
    
    [self.animation thenExecuteAnimationBlock:^{
        self.animatedView.frame = CGRectMake(10.0f, 100.0f, 100.0f, 100.0f);
    } duration:2.0];
    
    [self.animation thenExecuteAnimationBlock:^{
        self.animatedView.frame = CGRectMake(10.0f, 300.0f, 100.0f, 100.0f);
    } duration:2.0];
    
    [self.animation thenExecuteAnimationBlock:^{
        self.animatedView.frame = CGRectMake(220.0f, 20.0f, 100.0f, 100.0f);
    } afterDelay:2.0 duration:1.0];
}

- (IBAction)startAnimation:(id)sender
{
    [self.animation startAnimation];
}

- (IBAction)startReverseAnimation:(id)sender
{
    [self.animation startReverseAnimation];
}

@end
