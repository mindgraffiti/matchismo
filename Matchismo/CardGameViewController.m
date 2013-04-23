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
#import "PausedViewController.h"
#import "TopScoresViewController.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

// create a pointer to the CardMatchingGame class (Model) so you can reference it in the CardGameViewController (Controller).
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (nonatomic) BOOL running;
@property (nonatomic) NSTimeInterval elapsed;
@property (nonatomic) NSTimeInterval startsTime;
@property (strong, nonatomic) NSDate *startDate;
@property (nonatomic) NSTimeInterval secondsAlreadyRun;
@property (nonatomic) int pressedCount;

@end

@implementation CardGameViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.timerLabel.text = @"0:00.0";
    self.running = NO;
    self.title = @"Memory";
    [self.cardButtons setValue: [NSNumber numberWithBool:YES] forKey:@"hidden"];
}
// init the game
- (CardMatchingGame *)game
{   // get the card count from however many buttons are in the view.
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}

- (void) setCardButtons:(NSArray *)cardButtons
{
    // make the setter set!
    _cardButtons = cardButtons;
    [self updateUI];
}

// This method is an excellent example of the Controller telling the View what to do.
- (void) updateUI
{
    // loop through the IBOutletCollection of UIButtons
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

// it's ok for purely UI item to update themselves in their own setter. /philosophy
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

- (IBAction)topScoresPressed:(id)sender
{
    TopScoresViewController *scoresView;
    scoresView = [[TopScoresViewController alloc] initWithNibName:@"TopScoresViewController" bundle:nil];
    [self setTitle: @"back"];
    [self.navigationController pushViewController:scoresView animated:YES];
}


- (IBAction)playButtonPressed:(id)sender
{
    self.pressedCount++;
    if (self.pressedCount == 0) {
        [self.cardButtons setValue: [NSNumber numberWithBool:YES] forKey:@"hidden"];
    } else {
        [self.cardButtons setValue:[NSNumber numberWithBool:NO] forKey:@"hidden"];
    }
    if (self.running == NO) {
        self.running = YES;
        self.startDate = [[NSDate alloc] init];
        self.startsTime = [NSDate timeIntervalSinceReferenceDate];
        [sender setTitle:@"Pause" forState:UIControlStateNormal];
        
        [self updateTime];
    } else {
        self.secondsAlreadyRun += [[NSDate date] timeIntervalSinceDate:self.startDate];
        self.startDate = [[NSDate alloc] init];
        [sender setTitle:@"Play" forState:UIControlStateNormal];
        self.running = NO;
        
        PausedViewController *pauseView;
        pauseView = [[PausedViewController alloc] initWithNibName:@"PausedViewController" bundle:nil];
        [self setTitle: @"back"];
        [self.navigationController pushViewController:pauseView animated:YES];
        
    }
}
- (void)updateTime
{
    if (self.running == NO) {
        
        return;
    }
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = self.secondsAlreadyRun + currentTime - self.startsTime;
    
    int mins = (int) (elapsed / 60.0);
    elapsed -= mins * 60;
    int secs = (int) (elapsed);
    elapsed -= secs;
    int fraction = elapsed *10.0;
    
    self.timerLabel.text = [NSString stringWithFormat:@"%u:%02u.%u", mins, secs, fraction];
    
    [self performSelector:@selector(updateTime) withObject:self afterDelay:0.1];
}
- (void)saveScore
{
    NSMutableArray *scores = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"scores"] mutableCopy];
    if(!scores) scores = [[NSMutableArray alloc] init];
    // get the score for the game and save it to the array
    //[scores addObject:[NSNumber numberWithDouble:self.scores]];
    [[NSUserDefaults standardUserDefaults] setValue:scores forKey:@"scores"];
}

@end
