//
//  GameModel.m
//  Kappenball
//
//  Created by Darren Vong on 29/10/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import "GameModel.h"

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

// Put helper methods that won't be called publicly here to de-clutter the header file
@interface GameModel ()

-(BOOL)isInTrapRange;
-(void)updateVelocity;
-(void)updateScore;

@end

@implementation GameModel

-(id)init {
    self = [super init];
    if (self) {
        _velocity = 0.0;
        _acceleration = 0.0;
        _randFactor = 0.0;
        _RAND = (arc4random() % 41) - 20;
        _absMaxVelocity = 20.0;
        _ballXPos = GAME_WINDOW_WIDTH / 2.0;
        _ballYPos = 0.0;
        _score = 0;
        _average = 0.0;
        _energy = 0;
        _isInGoal = NO;
        _isGamePaused = NO;
    }
    return self;
}

// Gets the x coordinate of the leftmost side of the ball
-(float)getLeftX {
    return self.ballXPos - (0.5 * BALL_SIZE);
}

// Gets the x coordinate of the rightmost side of the ball
-(float)getRightX {
    return self.ballXPos + (0.5 * BALL_SIZE);
}

// Gets the y coordinate of the bottom of the ball
-(float)getBottomY {
    return self.ballYPos + (0.5 * BALL_SIZE);
}

// This method checks whether the ball is against one of the side (or goal) walls. If it is, the method
// adjusts the ball's x-coordinate value to ensure it does not go through the wall.
-(void)adjustForWalls {
    float leftMostX = [self getLeftX];
    float rightMostX = [self getRightX];
    // Left wall detection
    if (leftMostX <= WALL_WIDTH) {
        self.ballXPos = WALL_WIDTH + (0.5 * BALL_SIZE);
    }
    // Right wall detection
    else if (leftMostX + BALL_SIZE >= GAME_WINDOW_WIDTH - WALL_WIDTH) {
        self.ballXPos = GAME_WINDOW_WIDTH - WALL_WIDTH - (0.5 * BALL_SIZE);
    }
    else if (self.isInGoal) {
        // Left goal left wall
        if (leftMostX <= SIDE_TRAPS_WIDTH) {
            self.ballXPos = SIDE_TRAPS_WIDTH + (0.5 * BALL_SIZE);
            NSLog(@"1");
        }
        // Left goal right wall
        else if (rightMostX >= SIDE_TRAPS_WIDTH + GOAL_WIDTH && rightMostX <= SIDE_TRAPS_WIDTH + GOAL_WIDTH + DELTA) {
            self.ballXPos = SIDE_TRAPS_WIDTH + GOAL_WIDTH - (0.5 * BALL_SIZE);
            NSLog(@"2");
        }
        // Right goal left wall
        else if (leftMostX <= GAME_WINDOW_WIDTH - SIDE_TRAPS_WIDTH - GOAL_WIDTH &&
                 leftMostX >= GAME_WINDOW_WIDTH - SIDE_TRAPS_WIDTH - GOAL_WIDTH - DELTA) {
            self.ballXPos = GAME_WINDOW_WIDTH - SIDE_TRAPS_WIDTH - GOAL_WIDTH + (0.5 * BALL_SIZE);
            NSLog(@"3");
        }
        // Right goal right wall
        else if (rightMostX >= GAME_WINDOW_WIDTH - SIDE_TRAPS_WIDTH) {
            self.ballXPos = GAME_WINDOW_WIDTH - SIDE_TRAPS_WIDTH - (0.5 * BALL_SIZE);
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

// Checks whether the ball has dropped through the trap spikes when it drops below a certain y-coordinate level.
// If it has, the position of the ball is reset to the top centre of the screen and the energy expended for the
// current attempt is reset. Otherwise, it sets the flag isInGoal to YES (true) to keep track of
// the fact the ball is safe from being spiked.
-(void)adjustForTraps {
    // The bottom of the ball has passed the "y-threshold line" - i.e. it could have hit a trap or in goal
    if ([self getBottomY] >= GAME_WINDOW_HEIGHT - TRAPS_HEIGHT) {
        // Reset ball position only if the ball was not in goal in the previous game tick
        if ([self isInTrapRange] && !self.isInGoal) {
            NSLog(@"Ball spiked!");
            self.energy = 0;
            [self resetBallState];
        }
        else {
            self.isInGoal = YES;
        }
    }
}

// Checks whether the ball has dropped through the goal and if it has, then the position of the ball is
// reset to the top centre of the screen and the respective scores are updated.
-(void)adjustForGoals {
    if (self.isInGoal && [self getBottomY] >= GAME_WINDOW_HEIGHT) {
        NSLog(@"Point scored!");
        [self updateScore];
        [self resetBallState];
    }
}

-(void)updateGameState {
    [self updateVelocity];
    
    self.ballXPos = self.ballXPos + self.velocity * DT;
    self.ballYPos += DY;
    [self adjustForTraps];
    [self adjustForWalls];
    [self adjustForGoals];
}

-(void)updateVelocity {
    self.RAND = (arc4random() % 41) - 20;
    float potentialNewVelocity = self.velocity*DECAY + self.acceleration + self.randFactor * self.RAND;
    // Restricting the potential velocity to an upper limit to make the game more playable to begin with.
    // Also provides a basis for altering the difficulty of the game later on.
    if (potentialNewVelocity > self.absMaxVelocity) {
        self.velocity = self.absMaxVelocity;
        
    }
    else if (potentialNewVelocity < -self.absMaxVelocity) {
        self.velocity = -self.absMaxVelocity;
    }
    else {
        self.velocity = potentialNewVelocity;
    }
}

-(void)updateAcceleration:(BOOL)positive {
    if (positive) { // User tapped to the left of the ball
        self.acceleration = (self.acceleration > 0)? self.acceleration + 1.2 : 1.2;
    }
    else { // User tapped to the right of the ball
        self.acceleration = (self.acceleration < 0)? self.acceleration - 1.2 : -1.2;
    }
}

-(void)updateScore {
    self.average = (self.score * self.average + self.energy) / (self.score + 1);
    self.score += 1;
    self.energy = 0;
    // Increases the maximum velocity after every five points scored by player
    if (self.score % 5 == 0) {
        self.absMaxVelocity *= 1.25;
    }
}

-(void)resetBallState {
    self.ballXPos = GAME_WINDOW_WIDTH / 2.0;
    self.ballYPos = 0.0;
    self.acceleration = 0.0;
    self.isInGoal = NO;
}

-(void)resetScores {
    self.score = 0;
    self.average = 0.0;
    self.energy = 0;
}

@end
