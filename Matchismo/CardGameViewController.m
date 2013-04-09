//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Thuy Copeland on 4/9/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@end

@implementation CardGameViewController

- (void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    // toggle the button's state in the setter
    sender.selected = !sender.selected;
    self.flipCount++;
}
@end
