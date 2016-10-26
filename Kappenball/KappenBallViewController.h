//
//  ViewController.h
//  Kappenball
//
//  Created by Darren Vong on 25/10/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameModel.h"
#import "BallModel.h"

@interface KappenBallViewController : UIViewController

@property (strong) GameModel* gameModel;
@property (strong) BallModel* ballModel;

//Timer for animating the position of the ball
@property (strong) NSTimer* timer;

@property (weak) IBOutlet UIImageView* background;

// Score labels
@property (weak) IBOutlet UILabel* score;
@property (weak) IBOutlet UILabel* average;
@property (weak) IBOutlet UILabel* energy;

// Slider to control randomness factor
@property (weak) IBOutlet UISlider* randFactor;

@property (weak) IBOutlet UIButton* reset;

-(void)update;
-(IBAction)sliderMoved:(id)sender;

@end

