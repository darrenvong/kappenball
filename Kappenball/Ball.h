//
//  BallView.h
//  Kappenball
//
//  Created by aca13kcv on 26/10/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Ball : UIImageView

@property (assign) int RAND;

@property (assign) float velocity;
@property (assign) float acceleration;
@property (assign) float randFactor;

-(float)updateX;
-(float)updateVelocity;

@end
