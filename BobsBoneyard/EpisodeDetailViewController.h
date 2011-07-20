//
//  EpisodeDetailViewController.h
//  BobsBoneyard
//
//  Created by Ben on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedItem.h"

@interface EpisodeDetailViewController : UIViewController {
    MWFeedItem *episodeDetails;
    UILabel *titleLabel;
    UILabel *subtitleLabel;
    UILabel *dateLabel;
    UITextView *summaryLabel;
}
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UITextView *summaryLabel;
- (IBAction)stream:(id)sender;

@property (nonatomic, retain) MWFeedItem *episodeDetails;

@end
