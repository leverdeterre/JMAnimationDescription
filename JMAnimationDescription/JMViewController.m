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
@property (weak, nonatomic) IBOutlet UIView *animatedViewBlue;

@property (strong, nonatomic)  JMAnimationDescription *animation;
@end

@implementation JMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
    self.animation = [[JMAnimationDescription alloc] initWithAnimationBlock:^{
        self.animatedView.frame = CGRectMake(20.0f, 40.0f, 100.0f, 100.0f);
        self.animatedViewBlue.frame = CGRectMake(90.0f, 140.0f, 30.0f, 30.0f);

    } duration:1.0];
    
    [self.animation thenExecuteAnimationBlock:^{
        self.animatedView.frame = CGRectMake(20.0f, CGRectGetMaxY([UIScreen mainScreen].bounds)-140.0f, 100.0f, 100.0f);
        self.animatedViewBlue.frame = CGRectMake(90.0f, 160.0f, 30.0f, 30.0f);

    } duration:2.0];
    
    [self.animation thenExecuteAnimationBlock:^{
        self.animatedView.frame = CGRectMake(CGRectGetMaxX([UIScreen mainScreen].bounds)-140.0f, CGRectGetMaxY([UIScreen mainScreen].bounds)-140.0f, 100.0f, 100.0f);
        self.animatedViewBlue.frame = CGRectMake(200.0f, 160.0f, 30.0f, 30.0f);

    } duration:2.0];
    
    [self.animation thenExecuteAnimationBlock:^{
        self.animatedView.frame = CGRectMake(CGRectGetMaxX([UIScreen mainScreen].bounds)-140.0f, 40.0f, 100.0f, 100.0f);
        self.animatedViewBlue.frame = CGRectMake(90.0f, 160.0f, 30.0f, 30.0f);

    } afterDelay:1.0 duration:1.0];
    
    [self.animation thenExecuteAnimationBlock:^{
        self.animatedView.frame = CGRectMake(20.0f, 40.0f, 100.0f, 100.0f);
        self.animatedViewBlue.frame = CGRectMake(20.0f, 140.0f, 30.0f, 30.0f);

    } duration:1.0];
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
