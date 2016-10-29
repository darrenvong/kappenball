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

// Useful constants for wall/trap/goal detection
#define WALL_WIDTH 15
#define SIDE_TRAPS_WIDTH 142
#define BALL_SIZE 31
#define GAME_WINDOW_WIDTH 611
#define GAME_WINDOW_HEIGHT 322

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
    
    self.x = self.x + self.velocity * DT;
    
    float xOrigin = self.x - (BALL_SIZE/2.0);
    // Left wall detection
    if (xOrigin <= WALL_WIDTH) {
        self.x = WALL_WIDTH + (0.5 * BALL_SIZE);
    }
    // Right wall detection
    else if (xOrigin + BALL_SIZE >= GAME_WINDOW_WIDTH - WALL_WIDTH) {
        self.x = GAME_WINDOW_WIDTH - WALL_WIDTH - (0.5 * BALL_SIZE);
    }
    
    self.y += DY;
}

-(void)updateVelocity {
    self.velocity = self.velocity*DECAY + self.acceleration + self.randFactor * self.RAND;
}

@end
