//
//  StreamingViewController.h
//  BobsBoneyard
//
//  Created by Ben on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StreamingViewController : UIViewController {
    UILabel *titleLabel;
    UILabel *subtitleLabel;
    UITextView *summaryLabel;
}
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, retain) IBOutlet UITextView *summaryLabel;
@end
