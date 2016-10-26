//
//  BallView.m
//  Kappenball
//
//  Created by aca13kcv on 26/10/2016.
//  Copyright © 2016 Darren Vong. All rights reserved.
//

#import "BallView.h"

@implementation BallView

-(id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        _ball = [UIImage imageNamed:@"ball.png"];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    [self.ball drawAtPoint:CGPointMake(20,100)];
//}


@end
