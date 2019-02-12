//
//  DVMDeckController.h
//  DeckOfOneCardObjectiveC
//
//  Created by Chris Grayston on 2/12/19.
//  Copyright © 2019 Chris Grayston. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DVMCard;

NS_ASSUME_NONNULL_BEGIN

@interface DVMDeckController : NSObject

+(instancetype)sharedController;

-(void)drawNewCard:(NSInteger)numberOfCards completion:(void(^) (NSArray<DVMCard *> *cards, NSError *error))completion;

-(void)fetchCardImage:(DVMCard *)card completion:(void(^) (UIImage *image, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
