//
//  TopScoresViewController.m
//  Matchismo
//
//  Created by Thuy Copeland on 4/22/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "TopScoresViewController.h"
#import "CardMatchingGame.h"
@interface TopScoresViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation TopScoresViewController

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
    self.title = @"Top Scores";
    //self.game.scores = [[NSUserDefaults standardUserDefaults] arrayForKey:@"scores"];
    // reload table data
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return self.game.scores.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    //id score = self.game.scores[indexPath.row];
    
    //cell.textLabel.text = [NSString stringWithFormat:@"%@", score];
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
