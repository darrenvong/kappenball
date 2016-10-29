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
#define SIDE_TRAPS_WIDTH 140
#define MIDDLE_TRAP_WIDTH 205
#define TRAPS_HEIGHT 50
#define BALL_SIZE 31
#define GAME_WINDOW_WIDTH 611
#define GAME_WINDOW_HEIGHT 322
const int GOAL_WIDTH = (GAME_WINDOW_WIDTH - MIDDLE_TRAP_WIDTH - (2 * SIDE_TRAPS_WIDTH)) / 2;

@implementation BallModel

-(id)init {
    self = [super init];
    if (self) {
        _velocity = 0.0;
        _acceleration = 0.0;
        _randFactor = 0.0;
        _RAND = (arc4random() % 41) - 20;
        _x = GAME_WINDOW_WIDTH / 2.0;
        _y = 0.0;
    }
    return self;
}

// Gets the x coordinate of the leftmost side of the ball
-(float)getLeftX {
    return self.x - (0.5 * BALL_SIZE);
}

// Gets the x coordinate of the rightmost side of the ball
-(float)getRightX {
    return self.x + (0.5 * BALL_SIZE);
}

// Gets the y coordinate of the bottom of the ball
-(float)getBottomY {
    return self.y + (0.5 * BALL_SIZE);
}

// This method checks whether the ball is near one of the side walls and
// ensures it does not go through the wall
-(void)checkForWalls {
    float leftmostX = [self getLeftX];
    // Left wall detection
    if (leftmostX <= WALL_WIDTH) {
        self.x = WALL_WIDTH + (0.5 * BALL_SIZE);
    }
    // Right wall detection
    else if (leftmostX + BALL_SIZE >= GAME_WINDOW_WIDTH - WALL_WIDTH) {
        self.x = GAME_WINDOW_WIDTH - WALL_WIDTH - (0.5 * BALL_SIZE);
    }
    // Left goal left wall
    // Left goal right wall
    // Right goal left wall
    // Right goal right wall
}

-(void)checkForTraps {
    float leftMostX = [self getLeftX];
    float rightMostX = [self getRightX];
    float bottomY = [self getBottomY];
    
    if ( (leftMostX <= SIDE_TRAPS_WIDTH) || //Left trap
        (rightMostX >= GAME_WINDOW_WIDTH - SIDE_TRAPS_WIDTH) || //Right trap
        (SIDE_TRAPS_WIDTH+GOAL_WIDTH <= leftMostX <= SIDE_TRAPS_WIDTH+GOAL_WIDTH+MIDDLE_TRAP_WIDTH)) { // Middle trap
        
        // Checks if the bottom of the ball is about to fall through the trap
        if (bottomY >= GAME_WINDOW_HEIGHT - TRAPS_HEIGHT) {
            NSLog(@"Ball spiked!");
            [self resetBallPos];
        }
    }
    
}

-(void)checkForGoals {
    float leftMostX = [self getLeftX];
    float rightMostX = [self getRightX];
    float bottomY = [self getBottomY];
    
    if ( (SIDE_TRAPS_WIDTH < leftMostX < SIDE_TRAPS_WIDTH + GOAL_WIDTH &&
          SIDE_TRAPS_WIDTH < rightMostX < SIDE_TRAPS_WIDTH + GOAL_WIDTH) || // Ball is in between the left goal x position
        ((GAME_WINDOW_WIDTH - SIDE_TRAPS_WIDTH - GOAL_WIDTH < leftMostX &&
          leftMostX < GAME_WINDOW_WIDTH - SIDE_TRAPS_WIDTH) &&
         (GAME_WINDOW_WIDTH - SIDE_TRAPS_WIDTH - GOAL_WIDTH < rightMostX &&
          rightMostX < GAME_WINDOW_WIDTH - SIDE_TRAPS_WIDTH)) ) { // Ball is in between the right goal x position
        
        if (bottomY >= GAME_WINDOW_HEIGHT) {
            NSLog(@"Scores!");
            [self resetBallPos];
        }
    }
}

-(void)updateBallPos {
    [self updateVelocity];
    
    self.x = self.x + self.velocity * DT;
    self.y += DY;
    [self checkForWalls];
    [self checkForGoals];
    [self checkForTraps];
    
}

-(void)updateVelocity {
    self.velocity = self.velocity*DECAY + self.acceleration + self.randFactor * self.RAND;
}

-(void)resetBallPos {
    self.x = GAME_WINDOW_WIDTH / 2.0;
    self.y = 0.0;
}

@end
