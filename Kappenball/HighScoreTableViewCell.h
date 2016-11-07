//
//  HighScoreTableViewCell.h
//  Kappenball
//
//  Created by Darren Vong on 06/11/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoreTableViewCell : UITableViewCell

@property (weak) IBOutlet UILabel* rank;
@property (weak) IBOutlet UILabel* name;
@property (weak) IBOutlet UILabel* energy;
@property (weak) IBOutlet UILabel* score;

@end
