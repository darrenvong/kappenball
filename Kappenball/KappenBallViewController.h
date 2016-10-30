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
@property (strong) NSTimer* timer;

@property (weak) IBOutlet UIImageView* background;
@property (strong) UIImageView* ball;

// Score labels
@property (weak) IBOutlet UILabel* score;
@property (weak) IBOutlet UILabel* average;
@property (weak) IBOutlet UILabel* energy;

// Slider to control randomness factor
@property (weak) IBOutlet UISlider* randFactor;

@property (weak) IBOutlet UIButton* reset;

// For testing only. Need to be removed later
@property (weak) IBOutlet UIButton* flip;
@property (weak) IBOutlet UIButton* energyBoost;
-(IBAction)flipped:(id)sender;
-(IBAction)boosted:(id)sender;

-(void)updateView;
-(void)updateAllScoreLabels;
-(IBAction)sliderMoved:(id)sender;
-(IBAction)resetButtonPressed:(id)sender;

@end

