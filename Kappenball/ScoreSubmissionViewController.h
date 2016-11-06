//
//  ScoreSubmissionViewController.h
//  Kappenball
//
//  Created by Darren Vong on 05/11/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreSubmissionViewControllerDelegate.h"
#import "KappenballViewController.h"
#import "GameModel.h"

@interface ScoreSubmissionViewController : UIViewController <UITextFieldDelegate>

@property (weak) id<ScoreSubmissionViewControllerDelegate> delegate;
@property (weak) GameModel* model;

@property (weak) IBOutlet UILabel* textFieldLabel;
@property (weak) IBOutlet UITextField* username;
@property (weak) IBOutlet UILabel* average;
@property (weak) IBOutlet UILabel* score;

@property (weak) IBOutlet UIButton* submit;
@property (weak) IBOutlet UIButton* cancel;

-(IBAction)submitPressed:(id)sender;
-(IBAction)cancelPressed:(id)sender;

@end
