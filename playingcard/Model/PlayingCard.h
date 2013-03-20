//
//  PlayingCard.h
//  playingcard
//
//  Created by Frederik on 13/03/13.
//  Copyright (c) 2013 Frederik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard: Card

@property (strong, nonatomic)NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
