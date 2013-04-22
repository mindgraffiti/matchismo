//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Thuy Copeland on 4/17/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer. Need it to tell the game how many cards we want to use.
- (id) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
- (void) flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

// readonly means there is NO setter.
@property (nonatomic, readonly) int score;


@end
