//
//  RootViewController.h
//  Kappenball
//
//  Created by Darren Vong on 06/11/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KappenballViewController.h"
#import "HighScoreTableViewController.h"

@interface RootViewController : UIViewController

@property (weak) IBOutlet UIButton* play;
@property (weak) IBOutlet UIButton* viewHighscore;

-(IBAction)goHome:(UIStoryboardSegue*) segue;

@end
