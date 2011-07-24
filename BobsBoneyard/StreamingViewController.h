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
    UISlider *streamSlider;
    UILabel *streamCurTime;
    UILabel *streamTotalTime;
    NSString *podcastUrl;
    
    AVPlayer *audioPlayer;
    Boolean audioPlaying;
    
    IBOutlet UIButton *playStopButton;
}
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, retain) IBOutlet UITextView *summaryLabel;
@property (nonatomic, retain) IBOutlet UISlider *streamSlider;
@property (nonatomic, retain) IBOutlet UILabel *streamCurTime;
@property (nonatomic, retain) IBOutlet UILabel *streamTotalTime;
@property (nonatomic, retain) NSString *podcastUrl;
@property (nonatomic, retain) UIButton *playStopButton;

-(void)initAndStartPlayingAudio;
-(void)startPlayingAudio;
-(void)stopPlayingAudio;

@end
