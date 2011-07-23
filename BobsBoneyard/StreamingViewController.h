//
//  StreamingViewController.h
//  BobsBoneyard
//
//  Created by Ben on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface StreamingViewController : UIViewController <AVAudioPlayerDelegate> {
    UILabel *titleLabel;
    UILabel *subtitleLabel;
    UITextView *summaryLabel;
    NSString *podcastUrl;
    
    AVPlayer *audioPlayer;
    
    IBOutlet UIButton *playStopButton;
}
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, retain) IBOutlet UITextView *summaryLabel;
@property (nonatomic, retain) NSString *podcastUrl;
@property (nonatomic, retain) UIButton *playStopButton;

@end
