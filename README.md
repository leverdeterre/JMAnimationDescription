JMAnimationDescription
======================

Describe your animation, i'm doing it

```objc
//Describe your animation
    self.animation = [[JMAnimationDescription alloc] initWithAnimationBlock:^{
        self.animatedView.frame = CGRectMake(10.0f, 10.0f, 100.0f, 100.0f);
    } duration:0.0];
    
    [self.animation thenExecuteAnimationBlock:^{
        self.animatedView.frame = CGRectMake(10.0f, 100.0f, 100.0f, 100.0f);
    } duration:1.0];
    
    [self.animation thenExecuteAnimationBlock:^{
        self.animatedView.frame = CGRectMake(250.0f, 300.0f, 100.0f, 100.0f);
    } duration:1.0];
    
    [self.animation thenExecuteAnimationBlock:^{
        self.animatedView.frame = CGRectMake(10.0f, 10.0f, 100.0f, 100.0f);
    } duration:1.0];
    
    //Execute it 
    [self.animation startAnimation];

```
