//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Thuy Copeland on 4/17/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// initializer
- (id) initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;

- (void) flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

// readonly means there is NO setter.
@property (nonatomic, readonly) int score;

@end
