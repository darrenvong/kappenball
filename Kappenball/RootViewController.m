//
//  RootViewController.m
//  Kappenball
//
//  Created by Darren Vong on 06/11/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

// Unwind segue to allow the user to go back to this home screen from the main game
-(IBAction)goHome:(UIStoryboardSegue *)segue {
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"viewScore"]) {
        HighScoreTableViewController* hsvc = [segue destinationViewController];
        
        // Load existing highscore into memory
        NSString* path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"highscore.archive"];
        NSFileManager* fileManager = [NSFileManager defaultManager];
        NSArray* tableHeader = @[@"Rank", @"Name", @"Average Energy", @"Points"];
        if (![fileManager fileExistsAtPath:path]) {
            // No existing score found, so just passing in table heading and will display an empty table
            hsvc.highscores = [[NSArray alloc]initWithObjects:tableHeader, nil];
        }
        else {
            // Existing score found
            NSMutableArray* highscores = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
            [highscores insertObject:tableHeader atIndex:0];
            hsvc.highscores = highscores;
        }
    }
}

@end
