//
//  EpisodesViewController.h
//  BobsBoneyard
//
//  Created by Ben on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"


@interface EpisodesViewController : UITableViewController <MWFeedParserDelegate> {
    NSMutableArray *parsedItems;
    NSDateFormatter *formatter;
    MWFeedParser *feedParser;
}

// Properties
@property (nonatomic, retain) NSArray *itemsToDisplay;

@end
