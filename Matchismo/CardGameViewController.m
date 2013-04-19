//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Thuy Copeland on 4/9/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation CardGameViewController

// since we don't have a viewDidLoad to init classes and methods, we need to instantiate the game here.
- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    // get the card count from however many buttons are in the view.
    return _game;
}

- (void) setCardButtons:(NSArray *)cardButtons
{
    // make the setter set!
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        // set the title in the button's selected state to be card contents
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        // set the title when the button is selected / disabled, so the apple logo doesn't reappear
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        // select the card only if faceUp
        cardButton.selected = card.isFaceUp;
        // disable the card if isUnplayable
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
}
- (void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d",self.flipCount];
}
- (IBAction)flipCard:(UIButton *)sender
{
    // toggle the button's state 
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

@end
