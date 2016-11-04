//
//  ViewController.h
//  Kappenball
//
//  Created by Darren Vong on 25/10/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameModel.h"
#import "GameModel.h"

@interface KappenBallViewController : UIViewController

@property (strong) GameModel* gameModel;

//Timer for animating the position of the ball
@property (strong) NSTimer* ballTimer;

@property (weak) IBOutlet UIImageView* background;
@property (strong) UIImageView* ball;

// Score labels
@property (weak) IBOutlet UILabel* score;
@property (weak) IBOutlet UILabel* average;
@property (weak) IBOutlet UILabel* energy;

@property (weak) IBOutlet UILabel* pausedLabel;
@property (weak) IBOutlet UIButton* pause;

// Slider to control randomness factor
@property (weak) IBOutlet UISlider* randFactor;

@property (weak) IBOutlet UIButton* reset;

-(void)updateView;
-(void)updateAllScoreLabels;
-(IBAction)sliderMoved:(id)sender;
-(IBAction)resetButtonPressed:(id)sender;
-(IBAction)pauseButtonPressed:(id)sender;

@end

