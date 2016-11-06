//
//  KappenballViewController.m
//  Kappenball
//
//  Created by Darren Vong on 05/11/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import "KappenballViewController.h"

@interface KappenballViewController ()

@end

@implementation KappenballViewController

-(void)updateAllScoreLabels {
    self.score.text = [NSString stringWithFormat:@"Score: %d", self.gameModel.score];
    self.average.text = [NSString stringWithFormat:@"Average: %1.0f", self.gameModel.average];
    self.energy.text = [NSString stringWithFormat:@"Energy: %d", self.gameModel.energy];
}

-(void)updateView {
    // Update the model first
    [self.gameModel updateGameState];
    
    // Spike animation (if applicable)
    // The task of resetting the position of the ball and the energy expended score has been deferred here
    // so that the ball popping animation may happen first.
    if (self.gameModel.hasHitTrap) {
        CGAffineTransform original = self.ball.transform;
        [UIView animateWithDuration:0.3 animations:^{
            self.ball.alpha = 0.0;
            self.ball.transform = CGAffineTransformScale(self.ball.transform, 2.0, 2.0);
        } completion:^(BOOL finished) {
            self.gameModel.energy = 0;
            [self.gameModel resetBallState];
            [self setUpTimers];
            self.ball.alpha = 1.0;
            self.ball.transform = original;
        }];
        
        // Temporarily pause timer to stop this function being erroneously called again (due to animation
        // being run on a different thread) which causes the spike animation and the associated completion
        // callback being executed multiple times
        [self pauseTimers];
    }
    else {
        // Ball hasn't been spiked, so update the ball's position as usual from the updated data in the model
        CGPoint pos = self.ball.center;
        pos.x = self.gameModel.ballXPos;
        pos.y = self.gameModel.ballYPos;
        self.ball.center = pos;
    }
    
    [self updateAllScoreLabels];
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

-(IBAction)pauseButtonPressed:(id)sender {
    if (self.gameModel.isGamePaused) {
        self.gameModel.isGamePaused = NO;
        self.pausedLabel.alpha = 0.0;
        [self setUpTimers];
        [self.pause setTitle:@"Pause" forState:UIControlStateNormal];
    }
    else {
        self.gameModel.isGamePaused = YES;
        [self pauseTimers];
        self.pausedLabel.alpha = 1.0;
        [self.pause setTitle:@"Resume" forState:UIControlStateNormal];
    }
}

-(IBAction)submitButtonPressed:(id)sender {
    
}

// Sets up the method with NSTimer so that the ball and RAND is updated periodically
-(void)setUpTimers {
    self.ballTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(updateView) userInfo:nil repeats:YES];
}

// Invalidate timers which updates the ball and RAND when the user wishes to pause the game (by pressing the 'pause' button)
-(void)pauseTimers {
    [self.ballTimer invalidate];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

// Customise the look and feel of the slider
-(void)customiseSlider {
    [self.randFactor setThumbImage:[UIImage imageNamed:@"thumb.png"] forState:UIControlStateNormal];
    // Insets used to ensure only the central filled part of the image is stretched to fill the slider
    UIEdgeInsets minTrackImgInsets = UIEdgeInsetsMake(2, 2, 2, 0);
    UIEdgeInsets maxTrackImgInsets = UIEdgeInsetsMake(2, 0, 2, 2);
    
    UIImage* minTrackImage = [[UIImage imageNamed:@"slider2.png"] resizableImageWithCapInsets:minTrackImgInsets
                                                                                 resizingMode:UIImageResizingModeStretch];
    UIImage* maxTrackImage = [[UIImage imageNamed:@"slider1.png"] resizableImageWithCapInsets:maxTrackImgInsets
                                                                                 resizingMode:UIImageResizingModeStretch];
    [self.randFactor setMinimumTrackImage:minTrackImage forState:UIControlStateNormal];
    [self.randFactor setMaximumTrackImage:maxTrackImage forState:UIControlStateNormal];
}

// Sets up a glowing blob that shows up under where the user taps the screen each time they do so
-(void)setUpTouchBlob {
    self.blob = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kappenblob.png"]];
    self.blob.alpha = 0.0;
    [self.background addSubview:self.blob];
    // Scale down the blob as it's too large
    self.blob.transform = CGAffineTransformScale(self.blob.transform, 0.5, 0.5);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.gameModel = [[GameModel alloc]init];
    [self updateAllScoreLabels];
    
    self.ball = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ball.png"]];
    [self.background addSubview:self.ball];
    
    // Set the ball's initial x coordinate
    CGPoint pos = self.ball.center;
    pos.x = self.gameModel.ballXPos;
    self.ball.center = pos;
    
    [self customiseSlider];
    [self setUpTouchBlob];
    
    // initialise slider's randomness factor to 0 to begin with
    self.randFactor.value = self.gameModel.randFactor;
    
    [self setUpTimers];
}

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"submitScore"]) {
        ScoreSubmissionViewController* submitScoreView = [segue destinationViewController];
        // Additional set up here
        submitScoreView.delegate = self;
        [self pauseTimers];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch* tap = [touches anyObject];
    CGPoint tapLocation = [tap locationInView:self.background];
    self.blob.center = tapLocation;
    self.blob.alpha = 0.8;
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch* tap = [touches anyObject];
    CGPoint tapLocation = [tap locationInView:self.background];
    self.blob.center = tapLocation;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent*)event {
    UITouch* tap = [touches anyObject];
    CGPoint tapLocation = [tap locationInView:self.background];
    
    // Tap is to the left of the ball
    if (tapLocation.x <= self.gameModel.ballXPos) {
        [self.gameModel updateAcceleration:YES];
        self.gameModel.energy += 1;
    }
    else {
        [self.gameModel updateAcceleration:NO];
        self.gameModel.energy += 1;
    }
    
    // Hide touch blob view now that the touch event has finished
    self.blob.alpha = 0.0;
    
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.blob.alpha = 0.0;
}

-(void)resumeGame {
    [self setUpTimers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
