//
//  CardMatchingGame.m
//  playingcard
//
//  Created by Frederik on 19/03/13.
//  Copyright (c) 2013 Frederik. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards;
@property (strong, nonatomic) Deck *deck;
@property (nonatomic) NSUInteger count;
@property (strong, nonatomic) NSString *status;



@end
@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}
#define MATCH_BONUS 4;
#define MISMATCH_PENALTY 2;
#define FLIP_COST 1;

// Handle which card to flip according to the delt cards.
- (void) flipCardAtIndex:(NSUInteger)index
{
    self.gameState = YES;
    NSMutableArray *otherCards = [[NSMutableArray alloc] init];
    Card *card = [self cardAtIndex:index];
    
    // Checks if pushed cards is accessible to play.
    if (card && !card.isUnplayable){
        
        if(!card.isFaceUp)
        {
            for(Card *otherCard in self.cards){
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    [otherCards addObject:otherCard];
                }
            }
            
            // Handles the choose of game. 2-card or 3-card.
            if([otherCards count] == self.gameMode)
            {
                // Matches the cards and sets points and labels
                int matchScore = [card match:otherCards];
                if (matchScore){
                    NSString *statusStr = @"";
                    for (Card *otherCard in otherCards){
                        otherCard.Unplayable = YES;
                        statusStr = [NSString stringWithFormat:@" %@ & %@ ", statusStr, otherCard.contents];
                }
                    
                card.Unplayable = YES;
                self.status = [NSString stringWithFormat:@"Matched %@ %@ for 4 points", card.contents, statusStr];
                self.score += matchScore * MATCH_BONUS;
            } else
                {
                    NSString *statusStr = @"";
                    for (Card *otherCard in otherCards){
                        otherCard.faceUp = NO;
                        statusStr = [NSString stringWithFormat:@"%@ & %@ ", statusStr, otherCard.contents];
                    }
                    self.status = [NSString stringWithFormat:@"%@ %@ don't match! 2 point penalty", card.contents, statusStr];
                    self.score -= MISMATCH_PENALTY;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

// reset the game score, state and redeal the cards.
- (void) resetGame
{
    self.score = 0;
    [self dealCards];
    self.gameState = NO;
}

// Deal the cards random according to the arrays with suit and ranks in 'PlayingCard.m'.
- (void) dealCards
{
    for (int i = 0; i < self.count; i++){
        Card *card = [self.deck drawRandomCard];
        if(card){
            self.cards[i] = card;
        }else{
            break;
        }
    }
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self.gameMode = 1;
    self = [super init];
    self.deck = deck;
    self.count = count;
    if (self){
        [self dealCards];
    }
    return self;
}

@end
