//
//  TopScoresViewController.h
//  Matchismo
//
//  Created by Thuy Copeland on 4/22/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopScoresViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
