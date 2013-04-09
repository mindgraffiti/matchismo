//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Thuy Copeland on 4/9/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

// PlayingCardDeck is a subclass of Deck
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

// creating a custom init because the original viewDidLoad that was auto-generated for us was deleted by hand.
- (id)init
{
    self = [super init];
    if (self) {
        for (NSString *suit in [PlayingCard validSuits])
        {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                    PlayingCard *card = [[PlayingCard alloc] init];
                    card.rank = rank;
                    card.suit = suit;
                    [self addCard:card atTop:YES];
            }
        }
    }
    return self;
}

@end
