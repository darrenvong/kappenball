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

-(IBAction)submitPressed:(id)sender {
    // Load existing highscore into memory
    NSString* path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"highscore.plist"];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSMutableArray* highscores;
    if (![fileManager fileExistsAtPath:path]) { // No existing score found
        highscores = [[NSMutableArray alloc]init];
    }
    else {
        highscores = [[NSMutableArray alloc]initWithContentsOfFile:path];
    }
    
    // Print out what's in the existing high score (for debugging)
//    for (NSArray* row in highscores) {
//        NSLog(@"Name: %@, average: %@, score: %@", row[0], row[1], row[2]);
//    }
    
    // Build score data from what's being submitted by user
    NSMutableArray* userSubmittedData = [[NSMutableArray alloc]init];
    [userSubmittedData addObject:self.username.text];
    [userSubmittedData addObject:[self getScore:self.average.text]];
    [userSubmittedData addObject:[self getScore:self.score.text]];
    
    // Add this new score to the existing highscores array and write it back to file
    [highscores addObject:userSubmittedData];
    bool didWriteToFile = [highscores writeToFile:path atomically:YES];
    if (!didWriteToFile) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Submission Error"
                                        message:@"Sorry, there was an error when you tried to submit your score. Please try again!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:nil];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        //Score submitted successfully, so dismiss view and resume game
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success"
                                        message:@"Your score has been successfully submitted."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {
                                                [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                                                [self.delegate resumeGame];
                                            }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(IBAction)cancelPressed:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Cancel Confirmation"
                                    message:@"Are you sure you do not want to submit your score?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction* action) {
                                            [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                                            [self.delegate resumeGame];
                                        }];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

//Helper method to extract the average and points scored as a NSNumber object from the label in view
-(NSNumber*)getScore:(NSString*)text {
    NSString* scoreString = [text componentsSeparatedByString:@":"][1];
    scoreString = [scoreString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [NSNumber numberWithInt:[scoreString intValue]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.average.text = [NSString stringWithFormat:@"Average Energy Expended: %1.0f", self.model.average];
    self.score.text = [NSString stringWithFormat:@"Points: %d", self.model.score];
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
