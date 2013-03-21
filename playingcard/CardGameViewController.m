//
//  CardGameViewController.m
//  playingcard
//
//  Created by Frederik on 12/03/13.
//  Copyright (c) 2013 Frederik. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *FlipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic)CardMatchingGame * game;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic)CardMatchingGame *gameMode;
@property (weak, nonatomic) IBOutlet UISegmentedControl *switchBtn;
@end

@implementation CardGameViewController

- (CardMatchingGame *) game;
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}
- (IBAction)switch:(UISegmentedControl *)sender
{
    self.game.gameMode = (sender.selectedSegmentIndex == 1 ? 2 : 1);
}

/*- (IBAction)switch:(UISegmentedControl *)sender {
    //self.game.gameMode = (sender.selectedSegmentIndex == 1 ? 1 : 2);
}
*/

- (IBAction)deal:(id)sender {
    [self.game resetGame];
    [self updateUI];
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
    
}
- (void) updateUI
{
    for (UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        [cardButton setBackgroundImage: [UIImage imageNamed:@"cardbackside.jpg"] forState:UIControlStateNormal];
        [cardButton setBackgroundImage: [UIImage imageNamed:@""] forState:UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
        
        
    }
    
    self.switchBtn.enabled = !self.game.gameState;
        
    
    self.resultLabel.text = self.game.status;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}
- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.FlipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}
- (IBAction)flipCard:(UIButton *)sender {
    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

@end
