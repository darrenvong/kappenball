//
//  HighScoreTableViewController.h
//  Kappenball
//
//  Created by Darren Vong on 06/11/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScoreTableViewCell.h"
#import "HighScorePlayer.h"

@interface HighScoreTableViewController : UITableViewController

@property (strong) NSArray* highscores;

@end
