//
//  BallModel.m
//  Kappenball
//
//  This BallModel class contains the extra data such as the
//  kappenball's current acceleration, velocity and randomness
//  factor that cannot be determined by inspecting the view's
//  position alone.
//
//  Created by Darren Vong on 25/10/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import "BallModel.h"

@implementation BallModel

-(id)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        // Placeholder values for now...
        _velocity = 0.0;
        _acceleration = 0.0;
        _randFactor = 0.0;
        
        _ball = [[BallView alloc]initWithFrame:frame];
    }
    
    return self;
}

@end
