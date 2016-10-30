//
//  ViewController.m
//  Kappenball
//
//  Created by Darren Vong on 25/10/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import "KappenBallViewController.h"

@implementation KappenBallViewController

-(void)updateAllScoreLabels {
    self.score.text = [NSString stringWithFormat:@"Score: %d", self.gameModel.score];
    self.average.text = [NSString stringWithFormat:@"Average: %1.0f", self.gameModel.average];
    self.energy.text = [NSString stringWithFormat:@"Energy: %d", self.gameModel.energy];
}

-(void)updateView {
    [self.gameModel updateBallPos];
    CGPoint pos = self.ball.center;
    pos.x = self.gameModel.ballXPos;
    pos.y = self.gameModel.ballYPos;
    self.ball.center = pos;
    
//    NSLog(@"(%1.1f, %1.1f)", self.ball.center.x, self.ball.center.y);
//    NSLog(@"ball origin: (%1.1f, %1.1f), RAND: %d", self.ball.frame.origin.x, self.ball.frame.origin.y, self.gameModel.ball.RAND);
//    NSLog(@"Ball velocity: %f, acceleration: %f", self.gameModel.ball.velocity, self.gameModel.ball.acceleration);
//    NSLog(@"random factor: %f, RAND: %d", self.gameModel.ball.randFactor, self.gameModel.ball.RAND);
}

-(IBAction)sliderMoved:(id)sender {
    // Change the randomness factor when slider changes
    self.gameModel.randFactor = self.randFactor.value;
}

-(IBAction)resetButtonPressed:(id)sender {
    // Reset the label score when reset button is pressed
    [self.gameModel resetScores];
    [self updateAllScoreLabels];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.gameModel = [[GameModel alloc]init];
    [self updateAllScoreLabels];
    
    self.ball = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ball.png"]];
    [self.background addSubview:self.ball];
    
    //Set the ball's initial x coordinate
    CGPoint pos = self.ball.center;
    pos.x = self.gameModel.ballXPos;
    self.ball.center = pos;
    
    
    // initialise slider's randomness factor to 0 to begin with
    self.randFactor.value = self.gameModel.randFactor;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(updateView) userInfo:nil repeats:YES];
    NSLog(@"RAND: %d", self.gameModel.RAND);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)flipped:(id)sender {
    self.gameModel.RAND = -self.gameModel.RAND;
    NSLog(@"RAND: %d", self.gameModel.RAND);
}

@end
