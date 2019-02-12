//
//  DVMCardViewController.m
//  DeckOfOneCardObjectiveC
//
//  Created by Chris Grayston on 2/12/19.
//  Copyright © 2019 Chris Grayston. All rights reserved.
//

#import "DVMCardViewController.h"
#import "DVMDeckController.h"
#import "DVMCard.h"

@interface DVMCardViewController ()
@property (weak, nonatomic) IBOutlet UILabel *suitLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;

@end

@implementation DVMCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateViews];
}

-(void)updateViews
{
    [[DVMDeckController sharedController] drawNewCard:1 completion:^(NSArray<DVMCard *> *  cards, NSError *error) {
        if (error) {
            NSLog(@"Error getting photo %@:", error);
            return;
        }
        DVMCard *card = [cards objectAtIndex:0];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.suitLabel.text = card.suit;
        });
        [[DVMDeckController sharedController] fetchCardImage:card completion:^(UIImage *image, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cardImage.image = image;
            });
        }];
        
        
    }];
}

- (IBAction)drawButtonTapped:(id)sender {
    [self updateViews];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
