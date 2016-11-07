//
//  HighScorePlayer.m
//  Kappenball
//
//  Created by Darren Vong on 06/11/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import "HighScorePlayer.h"

@implementation HighScorePlayer

-(id)init {
    self = [super init];
    if (self) {
        _name = @"";
        _averageEnergy = 0;
        _score = 0;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.averageEnergy = [decoder decodeIntForKey:@"averageEnergy"];
        self.score = [decoder decodeIntForKey:@"score"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeInt:self.averageEnergy forKey:@"averageEnergy"];
    [encoder encodeInt:self.score forKey:@"score"];
}



@end
