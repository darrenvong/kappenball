//
//  HighScorePlayer.h
//  Kappenball
//
//  Created by Darren Vong on 06/11/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HighScorePlayer : NSObject <NSCoding>

@property (strong) NSString* name;
@property (assign) int averageEnergy;
@property (assign) int score;

@end
