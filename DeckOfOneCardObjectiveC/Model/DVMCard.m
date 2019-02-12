//
//  DVMCard.m
//  DeckOfOneCardObjectiveC
//
//  Created by Chris Grayston on 2/12/19.
//  Copyright © 2019 Chris Grayston. All rights reserved.
//

#import "DVMCard.h"

@implementation DVMCard

+ (NSString *)suitKey
{
    return @"suit";
}

+ (NSString *)imageKey
{
    return @"image";
}

- (instancetype)initWithSuit:(NSString *)suit image:(NSString *)image
{
    self = [super init];
    if (self) {
        _suit = suit;
        _image = image;
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *suit = dictionary[[DVMCard suitKey]];
    NSString *image = dictionary[[DVMCard imageKey]];
    
    return [self initWithSuit:suit image:image];
}
@end
