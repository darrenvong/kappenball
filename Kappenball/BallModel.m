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
#define SIDE_TRAPS_WIDTH 135
#define MIDDLE_TRAP_WIDTH 190
#define TRAPS_HEIGHT 50
#define BALL_SIZE 31
#define GAME_WINDOW_WIDTH 611
#define GAME_WINDOW_HEIGHT 322
const int GOAL_WIDTH = (GAME_WINDOW_WIDTH - MIDDLE_TRAP_WIDTH - (2 * SIDE_TRAPS_WIDTH)) / 2;

// Used to provide upper/lower bounds to check if the ball is in the left goal or the right goal
const float DELTA = BALL_SIZE / 2.0;

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
        _isInGoal = NO;
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

// This method checks whether the ball is against one of the side (or goal) walls. If it is, the method
// adjusts the ball's x-coordinate value to ensure it does not go through the wall.
-(void)adjustForWalls {
    float leftMostX = [self getLeftX];
    float rightMostX = [self getRightX];
    // Left wall detection
    if (leftMostX <= WALL_WIDTH) {
        self.x = WALL_WIDTH + (0.5 * BALL_SIZE);
    }
    // Right wall detection
    else if (leftMostX + BALL_SIZE >= GAME_WINDOW_WIDTH - WALL_WIDTH) {
        self.x = GAME_WINDOW_WIDTH - WALL_WIDTH - (0.5 * BALL_SIZE);
    }
    else if (self.isInGoal) {
        // Left goal left wall
        if (leftMostX <= SIDE_TRAPS_WIDTH) {
            self.x = SIDE_TRAPS_WIDTH + (0.5 * BALL_SIZE);
            NSLog(@"1");
        }
        // Left goal right wall
        else if (rightMostX >= SIDE_TRAPS_WIDTH + GOAL_WIDTH && rightMostX <= SIDE_TRAPS_WIDTH + GOAL_WIDTH + DELTA) {
            self.x = SIDE_TRAPS_WIDTH + GOAL_WIDTH - (0.5 * BALL_SIZE);
            NSLog(@"2");
        }
        // Right goal left wall
        else if (leftMostX <= GAME_WINDOW_WIDTH - SIDE_TRAPS_WIDTH - GOAL_WIDTH &&
                 leftMostX >= GAME_WINDOW_WIDTH - SIDE_TRAPS_WIDTH - GOAL_WIDTH - DELTA) {
            self.x = GAME_WINDOW_WIDTH - SIDE_TRAPS_WIDTH - GOAL_WIDTH + (0.5 * BALL_SIZE);
            NSLog(@"3");
        }
        // Right goal right wall
        else if (rightMostX >= GAME_WINDOW_WIDTH - SIDE_TRAPS_WIDTH) {
            self.x = GAME_WINDOW_WIDTH - SIDE_TRAPS_WIDTH - (0.5 * BALL_SIZE);
            NSLog(@"4");
        }
    }
}

// Checks whether the ball's x-coordinate position coincides with the x-coordinate position of
// the traps near the bottom of the game screen
-(BOOL)isInTrapRange {
    float leftMostX = [self getLeftX];
    float rightMostX = [self getRightX];
    
    if ( (leftMostX <= SIDE_TRAPS_WIDTH) || //Left trap
        (rightMostX >= GAME_WINDOW_WIDTH - SIDE_TRAPS_WIDTH) || //Right trap
        (SIDE_TRAPS_WIDTH + GOAL_WIDTH <= rightMostX &&
         leftMostX <= SIDE_TRAPS_WIDTH + GOAL_WIDTH + MIDDLE_TRAP_WIDTH) ) { // Middle trap
        
        return YES;
    }
    else {
        return NO;
    }
    
}

// Returns a boolean indicating whether the ball has passed the trap and into the goal area. True if
// the ball is in goal area and passed the trap, false otherwise.
-(void)adjustForTraps {
    // The bottom of the ball has passed the "y-threshold line" - i.e. it could have hit a trap or in goal
    if ([self getBottomY] >= GAME_WINDOW_HEIGHT - TRAPS_HEIGHT) {
        // Reset ball position only if the ball was not in goal in the previous game tick
        if ([self isInTrapRange] && !self.isInGoal) {
            NSLog(@"Ball spiked!");
            [self resetBallPos];
        }
        else {
            self.isInGoal = YES;
        }
    }
}

-(void)checkForGoals {
    float leftMostX = [self getLeftX];
    float rightMostX = [self getRightX];
    float bottomY = [self getBottomY];
    
    if ( (SIDE_TRAPS_WIDTH < leftMostX && rightMostX < SIDE_TRAPS_WIDTH + GOAL_WIDTH) || // Ball is in between the left goal x position
        (GAME_WINDOW_WIDTH - SIDE_TRAPS_WIDTH - GOAL_WIDTH < leftMostX && rightMostX < GAME_WINDOW_WIDTH - SIDE_TRAPS_WIDTH) ) {
        // Ball is in between the right goal x position
        
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
    [self adjustForTraps];
    [self adjustForWalls];
}

-(void)updateVelocity {
    self.velocity = self.velocity*DECAY + self.acceleration + self.randFactor * self.RAND;
}

-(void)resetBallPos {
    self.x = GAME_WINDOW_WIDTH / 2.0;
    self.y = 0.0;
}

@end
