//
//  ScoreSubmissionViewController.m
//  Kappenball
//
//  Created by Darren Vong on 05/11/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import "ScoreSubmissionViewController.h"

@interface ScoreSubmissionViewController ()

@end

@implementation ScoreSubmissionViewController

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void)dismissKeyboard {
    [self.username resignFirstResponder];
}

-(IBAction)submitPressed:(id)sender {
    if (self.username.text.length == 0) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Invalid Name"
                                                                       message:@"Did you forget to enter your name?"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:confirmAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    else {
        // Load existing highscore into memory
        NSString* path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"highscore.archive"];
        NSFileManager* fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:path]) { // No existing score found
            self.highscores = [[NSMutableArray alloc]init];
        }
        else {
            self.highscores = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        }
        
        // Build score data from what's being submitted by user
        HighScorePlayer* player = [[HighScorePlayer alloc]init];
        player.name = self.username.text;
        player.averageEnergy = [self getScore:self.average.text];
        player.score = [self getScore:self.score.text];
        
        // Add this new score to the existing highscores array
        [self.highscores addObject:player];
        // Sort the data in order first before writing back to file
        NSSortDescriptor* pointSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO];
        NSSortDescriptor* energySortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"averageEnergy" ascending:YES];
        [self.highscores sortUsingDescriptors:[NSArray arrayWithObjects:pointSortDescriptor, energySortDescriptor, nil]];
        BOOL didWriteToFile = [NSKeyedArchiver archiveRootObject:self.highscores toFile:path];
        if (!didWriteToFile) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Submission Error"
                                            message:@"Sorry, there was an error when you tried to submit your score. Please try again!"
                                            preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:nil];
            [alert addAction:confirmAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else {
            //Score submitted successfully, so dismiss view and reset the game
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success"
                                            message:@"Your score has been successfully submitted."
                                            preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction* action) {
                                                    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                                                    [self.delegate resetGame];
                                                }];
            [alert addAction:confirmAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}

-(IBAction)cancelPressed:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Cancel Confirmation"
                                    message:@"Are you sure you do not want to submit your score? Tapping 'Yes' will bring you back to the game."
                                    preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction* action) {
                                            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                                            [self.delegate resumeGame];
                                        }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:confirmAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

//Helper method to extract the average and points scored as a NSNumber object from the label in view
-(int)getScore:(NSString*)text {
    NSString* scoreString = [text componentsSeparatedByString:@":"][1];
    scoreString = [scoreString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [scoreString intValue];
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
    // View loaded, so pause the game in background in case user wants to go back to it if they got here by mistake
    if (!self.model.isGamePaused) {
        [self.delegate pauseGame];
        self.model.isGamePaused = YES;
    }
    // Update the text labels with the scores the user is about to submit
    self.average.text = [NSString stringWithFormat:@"Average Energy Expended: %1.0f", self.model.average];
    self.score.text = [NSString stringWithFormat:@"Points: %d", self.model.score];
    
    // Set up tap gesture recogniser to dismiss keyboard when user tap away from the text field
    UITapGestureRecognizer* tapRecogniser = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tapRecogniser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
