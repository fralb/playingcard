//
//  PlayingCard.m
//  playingcard
//
//  Created by Frederik on 13/03/13.
//  Copyright (c) 2013 Frederik. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

// Determine is cards match
- (int)match:(NSArray *)otherCards
{
    NSUInteger rankCounter = 0;
    NSUInteger rankSuit = 0;
    int score = 0;
    if ([otherCards count]){
        for(PlayingCard *otherCard in otherCards){
        if ([otherCard.suit isEqualToString:self.suit]){
            rankSuit++;
            score = 1;
            
        }else if (otherCard.rank == self.rank){
            rankCounter++;
            score = 4;
        }
    }
    }
    if([otherCards count] > 0 && (rankCounter == [otherCards count] || rankSuit == [otherCards count])){
        return score;
    }
    
    return 0;
}

- (NSString *)contents;
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
    
}
@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void) setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank { return [self rankStrings].count-1; }

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
