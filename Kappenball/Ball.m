//
//  BallView.m
//  Kappenball
//
//  Created by aca13kcv on 26/10/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import "Ball.h"

#define DT 0.1
#define DECAY 0.95

@implementation Ball

-(id)initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        _velocity = 0.0;
        _acceleration = 0.0;
        _randFactor = 0.0;
        _RAND = (arc4random()%41) - 20;
    }
    return self;
}

-(float)updateX {
    return self.center.x + [self updateVelocity] * DT;
}

-(float)updateVelocity {
    return self.velocity*DECAY + self.acceleration + self.randFactor * self.RAND;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    [self.ball drawAtPoint:CGPointMake(20,100)];
//}


@end
