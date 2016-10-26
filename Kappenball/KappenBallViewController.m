//
//  ViewController.m
//  Kappenball
//
//  Created by Darren Vong on 25/10/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import "KappenBallViewController.h"

@implementation KappenBallViewController

-(void)update {
    self.ball.transform = CGAffineTransformTranslate(self.ball.transform, 0.0, 1.0);
    // Alternative method to move ball below... obviously needs to be updated to match model & given formula in assignment later
//    CGPoint pos = self.ball.center;
//    pos.y += 2;
//    self.ball.center = pos;
    NSLog(@"(%1.1f, %1.1f)", self.ball.frame.origin.x, self.ball.frame.origin.y);
    
}

-(IBAction)sliderMoved:(id)sender {
    // Change the randomness factor
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(update) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
