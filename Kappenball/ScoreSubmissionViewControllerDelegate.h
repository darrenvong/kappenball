//
//  ScoreSubmissionViewControllerDelegate.h
//  Kappenball
//
//  Created by Darren Vong on 05/11/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ScoreSubmissionViewControllerDelegate <NSObject>

-(void)resumeGame;
-(void)pauseGame;
-(void)resetGame;

@end
