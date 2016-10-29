//
//  GameModel.m
//  Kappenball
//
//  The game model holds score data of the current game.
//
//  Created by Darren Vong on 25/10/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import "GameModel.h"

@implementation GameModel

-(id)init {
    self = [super init];
    if (self) {
        _score = 0;
        _average = 0.0;
        _energy = 0;
    }
    return self;
}

-(void)reset {
    self.score = 0;
    self.average = 0.0;
    self.energy = 0;
}

@end
