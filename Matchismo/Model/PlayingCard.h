//
//  PlayingCard.h
//  Matchismo
//
//  Created by Thuy Copeland on 4/9/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
