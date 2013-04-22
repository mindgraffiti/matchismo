//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Thuy Copeland on 4/17/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "CardMatchingGame.h"
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;

// provides a means for creating a setter in this class through its private API
@property (readwrite, nonatomic) int score;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards // of the class Card
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

// our initializer
- (id) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self){
        for(int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if (!card){
                self = nil;
            } else {
                // a nicer way to say setObjectAtIndex:index
                self.cards[i] = card;
            }
        }
    }
    return self;
}
- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    // get the card
    Card *card = [self cardAtIndex:index];
    
    // check to see if the card exists and is playable
    if (card && !card.isUnplayable){
        // if the card is not already faceUp
        // ensures that a card is not comparing against itself.
        if(!card.isFaceUp)
        {
            // loop through the other cards for a match.
            for (Card *otherCard in self.cards){
                // if the other card is faceUp and playble...
                if (otherCard.isFaceUp && !otherCard.isUnplayable){
                    // score it to see how good of a match it was.
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        // make the matching pair unplayable
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        // add up the score
                        self.score += matchScore * MATCH_BONUS;
                    } else {
                        // flip the other card face down
                        otherCard.faceUp = NO;
                        // apply a penalty to the score
                        self.score -= MISMATCH_PENALTY;
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
    }
    card.faceUp = !card.isFaceUp;
}



@end
