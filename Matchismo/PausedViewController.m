//
//  PausedViewController.m
//  Matchismo
//
//  Created by Thuy Copeland on 4/21/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "PausedViewController.h"
#import "CardGameViewController.h"

@interface PausedViewController ()

@end

@implementation PausedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)continueButton:(id)sender
{
    CardGameViewController *gameView;
    gameView = [CardGameViewController alloc];
    [self presentViewController:gameView animated:YES completion:Nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
