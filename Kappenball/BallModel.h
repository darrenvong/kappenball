//
//  BallModel.h
//  Kappenball
//
//  Created by Darren Vong on 29/10/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BallModel : NSObject

@property (assign) int RAND;

// These keep track of the ball's position using the ball's center
@property (assign) float x;
@property (assign) float y;

@property (assign) float velocity;
@property (assign) float acceleration;
@property (assign) float randFactor;

-(id)initWithScreenWidth:(float)width;
-(void)updateBallPos;
-(void)updateVelocity;

@end
