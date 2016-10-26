//
//  BallModel.h
//  Kappenball
//
//  Created by Darren Vong on 25/10/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BallView.h"

@interface BallModel : NSObject

@property (strong) BallView* ball;

@property (assign) float velocity;
@property (assign) float acceleration;
@property (assign) float randFactor;

-(id)initWithFrame:(CGRect)frame;

@end
