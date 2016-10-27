//
//  ViewController.m
//  Kappenball
//
//  Created by Darren Vong on 25/10/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import "KappenBallViewController.h"

#define SCREEN_WIDTH 736
#define SCREEN_HEIGHT 414
#define TRAP_HEIGHT 58
#define WALL_WIDTH 20

#define DY 0.1 // Constant y falling speed of the ball

@implementation KappenBallViewController

-(void)updateBallPos {
    CGPoint pos = self.ball.center;
    
    //Do some checks here to see if the ball is near the edge of screen or traps
    
    //
    
    pos.x = [self.ball updateX];
    pos.y += DY;
    self.ball.center = pos;
    
    NSLog(@"(%1.1f, %1.1f)", self.ball.center.x, self.ball.center.y);
    NSLog(@"random factor: %f, RAND: %d", self.ball.randFactor, self.ball.RAND);
}

-(IBAction)sliderMoved:(id)sender {
    // Change the randomness factor when slider changes
    self.ball.randFactor = self.randFactor.value;
}

-(IBAction)resetButtonPressed:(id)sender {
    // Reset the label score when reset button is pressed
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.gameModel = [[GameModel alloc]init];
    //Set the game labels to model data (possibly put this in a method?)
    
    //
    
    self.ball = [[Ball alloc]initWithImage:[UIImage imageNamed:@"ball.png"]];
    [self.background addSubview:self.ball];
    //Set the ball's initial x coordinate
    NSLog(@"Background bounds over 2 = %f", self.background.bounds.size.width / 2);
    CGPoint pos = self.ball.center;
    pos.x = self.background.bounds.size.width / 2.0;
    self.ball.center = pos;
    
    
    // initialise slider's randomness factor to 0 to begin with
    self.randFactor.value = self.ball.randFactor;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(updateBallPos) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
