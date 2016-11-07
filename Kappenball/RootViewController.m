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


// #pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
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
