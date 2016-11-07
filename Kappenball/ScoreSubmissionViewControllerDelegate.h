//
//  ScoreSubmissionViewControllerDelegate.h
//  Kappenball
//
//  Created by Darren Vong on 05/11/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import <Foundation/Foundation.h>

// This delegate protocol essentially allows the ScoreSubmissionViewController to pass message
// back to the delegate (the main game controller, i.e. KappenballViewController) mainly when it's
// about to be dismissed.
@protocol ScoreSubmissionViewControllerDelegate <NSObject>

-(void)resumeGame;
-(void)pauseGame;
-(void)resetGame;

@end
