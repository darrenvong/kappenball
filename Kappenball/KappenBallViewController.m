//
//  ViewController.m
//  Kappenball
//
//  Created by Darren Vong on 25/10/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import "KappenBallViewController.h"

#define TRAP_HEIGHT 58
#define WALL_WIDTH 20

@implementation KappenBallViewController

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
    //Set the game labels to model data (possibly put this in a method?)
    
    //
    self.ballModel = [[BallModel alloc]initWithScreenWidth:self.background.bounds.size.width];
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
