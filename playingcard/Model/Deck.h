//
//  Deck.h
//  playingcard
//
//  Created by Frederik on 12/03/13.
//  Copyright (c) 2013 Frederik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
