//
//  BallModel.m
//  Kappenball
//
//  Created by Darren Vong on 29/10/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import "BallModel.h"

#define DT 0.1
#define DECAY 0.95
#define DY 0.3 // Constant y falling speed of the ball

@implementation BallModel

-(id)initWithScreenWidth:(float)width {
    self = [super init];
    if (self) {
        _velocity = 0.0;
        _acceleration = 0.0;
        _randFactor = 0.0;
        _RAND = (arc4random() % 41) - 20;
        _x = width / 2.0;
        _y = 0.0;
    }
    return self;
}

-(void)updateBallPos {
    [self updateVelocity];
    
    //Do some checks here to see if the ball is near the edge of screen or traps
    
    //
    
    self.x = self.x + self.velocity * DT;
    self.y += DY;
}

-(void)updateVelocity {
    self.velocity = self.velocity*DECAY + self.acceleration + self.randFactor * self.RAND;
}

@end
