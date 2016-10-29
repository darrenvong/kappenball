//
//  ViewController.m
//  Kappenball
//
//  Created by Darren Vong on 25/10/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import "KappenBallViewController.h"

#define GAME_WINDOW_WIDTH 611
#define GAME_WINDOW_HEIGHT 322
#define TRAP_HEIGHT 58
#define WALL_WIDTH 20
#define BALL_SIZE 31

@implementation KappenBallViewController

-(void)updateAllScoreLabels {
    self.score.text = [NSString stringWithFormat:@"Score: %d", self.gameModel.score];
    self.average.text = [NSString stringWithFormat:@"Average: %1.0f", self.gameModel.average];
    self.energy.text = [NSString stringWithFormat:@"Energy: %d", self.gameModel.energy];
}

-(void)updateView {
    [self.ballModel updateBallPos];
    CGPoint pos = self.ball.center;
    pos.x = self.ballModel.x;
    pos.y = self.ballModel.y;
    self.ball.center = pos;
    
    NSLog(@"(%1.1f, %1.1f)", self.ball.center.x, self.ball.center.y);
    NSLog(@"Ball velocity: %f, acceleration: %f", self.ballModel.velocity, self.ballModel.acceleration);
    NSLog(@"random factor: %f, RAND: %d", self.ballModel.randFactor, self.ballModel.RAND);
}

-(IBAction)sliderMoved:(id)sender {
    // Change the randomness factor when slider changes
    self.ballModel.randFactor = self.randFactor.value;
}

-(IBAction)resetButtonPressed:(id)sender {
    // Reset the label score when reset button is pressed
    [self.gameModel reset];
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
    
    self.ballModel = [[BallModel alloc]initWithScreenWidth:GAME_WINDOW_WIDTH];
    self.ball = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ball.png"]];
    [self.background addSubview:self.ball];
    
    //Set the ball's initial x coordinate
    NSLog(@"Background bounds over 2 = %f", self.background.bounds.size.width / 2);
    CGPoint pos = self.ball.center;
    pos.x = self.ballModel.x;
    self.ball.center = pos;
    
    
    // initialise slider's randomness factor to 0 to begin with
    self.randFactor.value = self.ballModel.randFactor;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(updateView) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
