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
    [self.gameModel updateGameState];
    CGPoint pos = self.ball.center;
    pos.x = self.gameModel.ballXPos;
    pos.y = self.gameModel.ballYPos;
    self.ball.center = pos;
    
    [self updateAllScoreLabels];
    
//    NSLog(@"(%1.1f, %1.1f)", self.ball.center.x, self.ball.center.y);
//    NSLog(@"ball origin: (%1.1f, %1.1f), RAND: %d", self.ball.frame.origin.x, self.ball.frame.origin.y, self.gameModel.ball.RAND);
    NSLog(@"velocity: %f, acceleration: %f, rand product: %f", self.gameModel.velocity, self.gameModel.acceleration, self.gameModel.randFactor * self.gameModel.RAND);
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
    
    // Customise the look and feel of the slider
    [self.randFactor setThumbImage:[UIImage imageNamed:@"thumb.png"] forState:UIControlStateNormal];
    [self.randFactor setMinimumTrackImage:[[UIImage imageNamed:@"slider2.png"]
                                           resizableImageWithCapInsets:UIEdgeInsetsZero
                                           resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [self.randFactor setMaximumTrackImage:[[UIImage imageNamed:@"slider1.png"]
                                           resizableImageWithCapInsets:UIEdgeInsetsZero
                                           resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    
    // initialise slider's randomness factor to 0 to begin with
    self.randFactor.value = self.gameModel.randFactor;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(updateView) userInfo:nil repeats:YES];
    NSLog(@"RAND: %d", self.gameModel.RAND);
}

//-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
//}
//
//-(void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event{
//}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent*)event {
//    NSSet<UITouch *> *taps = [event touchesForView:self.background];
    for (UITouch* tap in touches) {
        
        CGPoint tapLocation = [tap locationInView:self.background];
        NSLog(@"Tapped location: (%.1f, %.1f)", tapLocation.x, tapLocation.y);
        if (tapLocation.x <= self.gameModel.ballXPos) { // Tap is to the left of the ball
            [self.gameModel updateAcceleration:YES];
            self.gameModel.energy += 1;
        }
        else {
            [self.gameModel updateAcceleration:NO];
            self.gameModel.energy += 1;
        }
        
    }
    
}

//-(void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event {
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
