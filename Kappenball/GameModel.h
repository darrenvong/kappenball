//
//  GameModel.h
//  Kappenball
//
//  Created by Darren Vong on 29/10/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameModel : NSObject

@property (assign) int RAND;

// These keep track of the ball's position using the ball's center
@property (assign) float ballXPos;
@property (assign) float ballYPos;

@property (assign) BOOL isInGoal;

@property (assign) float velocity;
@property (assign) float acceleration;
@property (assign) float randFactor;

@property (assign) int score;
@property (assign) float average;
@property (assign) int energy;

// Convenient coordinate conversion helpers from the center of the ball to the different position of the ball
-(float)getLeftX;
-(float)getRightX;
-(float)getBottomY;

-(void)adjustForWalls;
-(BOOL)isInTrapRange;
-(void)adjustForTraps;
-(void)adjustForGoals;

-(void)updateGameState;
-(void)updateVelocity;
-(void)updateAcceleration:(BOOL)p;

-(void)resetBallState;

-(void)resetScores;

@end
