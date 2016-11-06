//
//  KappenballViewController.h
//  Kappenball
//
//  Created by Darren Vong on 05/11/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameModel.h"
#import "ScoreSubmissionViewController.h"
#import "ScoreSubmissionViewControllerDelegate.h"

@interface KappenballViewController : UIViewController <ScoreSubmissionViewControllerDelegate>

@property (strong) GameModel* model;

//Timer for animating the position of the ball
@property (strong) NSTimer* ballTimer;

@property (weak) IBOutlet UIImageView* background;
@property (strong) UIImageView* ball;
@property (strong) UIImageView* blob;

// Score labels
@property (weak) IBOutlet UILabel* score;
@property (weak) IBOutlet UILabel* average;
@property (weak) IBOutlet UILabel* energy;

@property (weak) IBOutlet UILabel* pausedLabel;
@property (weak) IBOutlet UIButton* pause;

// Slider to control randomness factor
@property (weak) IBOutlet UISlider* randFactor;

@property (weak) IBOutlet UIButton* reset;

// Button to allow users to submit their score
@property (weak) IBOutlet UIButton* submit;

-(void)updateView;
-(void)updateAllScoreLabels;

// Actions that can be sent from UI elements from the storyboard
-(IBAction)sliderMoved:(id)sender;
-(IBAction)resetButtonPressed:(id)sender;
-(IBAction)pauseButtonPressed:(id)sender;
-(IBAction)submitButtonPressed:(id)sender;

-(void)setUpTimers;
-(void)pauseTimers;
-(void)customiseSlider;
-(void)setUpTouchBlob;

@end

