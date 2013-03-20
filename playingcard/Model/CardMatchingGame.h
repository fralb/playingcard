//
//  CardMatchingGame.h
//  playingcard
//
//  Created by Frederik on 19/03/13.
//  Copyright (c) 2013 Frederik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject


- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void) resetGame;

@property (readonly, nonatomic) int score;
@property (strong, nonatomic, readonly) NSString *status;
@property (nonatomic) NSUInteger gameMode;
@property (nonatomic) BOOL gameState;

@end
