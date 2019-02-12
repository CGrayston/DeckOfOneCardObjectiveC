//
//  DVMDeckController.m
//  DeckOfOneCardObjectiveC
//
//  Created by Chris Grayston on 2/12/19.
//  Copyright © 2019 Chris Grayston. All rights reserved.
//

#import "DVMDeckController.h"
#import "DVMCard.h"

//static NSString * const baseURL = @"https://deckofcardsapi.com/api/deck/new/draw/";

@implementation DVMDeckController

+ (instancetype)sharedController
{
    static DVMDeckController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[DVMDeckController alloc] init];
    });
    return sharedController;
}

+ (NSURL *)baseURL
{
    return [NSURL URLWithString:@"https://deckofcardsapi.com/api/deck/new/draw/"];
}


- (void)drawNewCard:(NSInteger)numberOfCards completion:(void (^)(NSArray<DVMCard *> *cards, NSError *error))completion
{
    NSString *cardCount = [@(numberOfCards) stringValue];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:[DVMDeckController baseURL] resolvingAgainstBaseURL:true];
    
    NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:@"count" value:cardCount];
    urlComponents.queryItems = @[queryItem];
    NSURL *finalURL = urlComponents.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * data, NSURLResponse *response, NSError * error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return completion(nil, [NSError errorWithDomain:@"error Fetching json" code:(NSInteger)-1 userInfo:nil]);
        }
        
        if (!data) {
            NSLog(@"%@", error.localizedDescription);
            return completion(nil, [NSError errorWithDomain:@"error eith Data" code:(NSInteger)-1 userInfo:nil]);
        }
        
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        if (!topLevelDictionary || ![topLevelDictionary isKindOfClass:[NSDictionary class]]) {
            return completion(nil, [NSError errorWithDomain:@"error with topLevelDictionary" code:(NSInteger)-1 userInfo:nil]);
        }
        
        NSArray *cardsArray = topLevelDictionary[@"cards"];
        NSMutableArray *cardsPlaceholder = [NSMutableArray array];
        
        for (NSDictionary *cardDictionary in cardsArray) {
            
            DVMCard *card = [[DVMCard alloc] initWithDictionary: cardDictionary];
            [cardsPlaceholder addObject: card];
        }
        completion(cardsPlaceholder, nil);
        
        
    }] resume];
}


- (void)fetchCardImage:(DVMCard *)card completion:(void (^)(UIImage *image, NSError *error))completion
{
    
    NSURL *imageURL = [NSURL URLWithString:card.image];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * data, NSURLResponse *  response, NSError * error) {
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return completion(nil, [NSError errorWithDomain:@"error Fetching json" code:(NSInteger)-1 userInfo:nil]);
        }
        
        if (!data) {
            NSLog(@"Error: no image data returned from task");
            return completion(nil, [NSError errorWithDomain:@"error Fetching Image Data" code:(NSInteger)-1 userInfo:nil]);
        }
        
        UIImage *cardImage = [UIImage imageWithData:data];
        completion(cardImage, nil);
        
    }]resume];
    
}

@end
