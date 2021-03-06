//
//  StreamingViewController.m
//  BobsBoneyard
//
//  Created by Ben on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StreamingViewController.h"

@implementation StreamingViewController

@synthesize titleLabel;
@synthesize subtitleLabel;
@synthesize summaryLabel;
@synthesize streamSlider;
@synthesize streamCurTime;
@synthesize streamTotalTime;
@synthesize podcastUrl;
@synthesize playStopButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [titleLabel release];
    [subtitleLabel release];
    [summaryLabel release];
    [streamSlider release];
    [streamCurTime release];
    [streamTotalTime release];
    [podcastUrl release];
    
    [audioPlayer release];
    
    [playStopButton release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    streamSliderChanging = FALSE;
    
    NSError *setCategoryError = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    if (setCategoryError) { NSLog(@"%@", [setCategoryError userInfo]); }
    
    [playStopButton addTarget:self action:@selector(playStopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [streamSlider addTarget:self action:@selector(setStreamSliderChanging:) forControlEvents:UIControlEventTouchDown];
    [streamSlider addTarget:self action:@selector(streamSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    streamSlider.continuous = FALSE;
    audioPlaying = FALSE;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)streamSliderValueChanged:(id)sender
{
    streamSliderChanging = FALSE;
    if(audioPlayer)
        [audioPlayer seekToTime:CMTimeMakeWithSeconds(streamSlider.value, 1)];
}

-(void)setStreamSliderChanging:(id)sender
{
    streamSliderChanging = TRUE;
}

- (void)playStopButtonClick:(id)sender {
    NSLog(@"%@", podcastUrl);
    
    if (audioPlayer)
    {
        if (audioPlaying)
        {
            [self stopPlayingAudio];
        }
        else
        {
            [self startPlayingAudio];
        }
    }
    else
    {
        [self initAndStartPlayingAudio];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(object == audioPlayer && [keyPath isEqualToString:@"status"])
    {
        int seconds = CMTimeGetSeconds(audioPlayer.currentItem.duration);
        int hours = seconds / 3600;
        seconds = seconds % 3600;
        int minutes = seconds / 60;
        seconds = seconds % 60;
        
        [streamTotalTime setText:[NSString stringWithFormat:@"%d:%.2d:%.2d", hours, minutes, seconds]];
        [streamSlider setMaximumValue:CMTimeGetSeconds(audioPlayer.currentItem.duration)];
        [audioPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 1)
                                                  queue:nil 
                                             usingBlock:^(CMTime curTime)
                                                        {
                                                            int seconds = CMTimeGetSeconds(curTime);
                                                            int hours = seconds / 3600;
                                                            seconds = seconds % 3600;
                                                            int minutes = seconds / 60;
                                                            seconds = seconds % 60;
                                                            
                                                            [streamCurTime setText:[NSString stringWithFormat:@"%d:%.2d:%.2d", hours, minutes, seconds]];
                                                            if(!streamSliderChanging)
                                                                [streamSlider setValue:CMTimeGetSeconds(curTime) animated:YES];
                                                        }];
        [self startPlayingAudio];
    }
}

-(void)initAndStartPlayingAudio
{
    if(audioPlayer)
    {
        [audioPlayer pause];
        [audioPlayer release];
    }
    
    [playStopButton setImage:[UIImage imageNamed: @"stopBBY.png"] forState:UIControlStateNormal];
    
    audioPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:podcastUrl]];
    [audioPlayer addObserver:self forKeyPath:@"status" options:0 context:nil];
}

-(void)startPlayingAudio
{
    [audioPlayer play];
    [playStopButton setImage:[UIImage imageNamed: @"stopBBY.png"] forState:UIControlStateNormal];
    audioPlaying = TRUE;
}

-(void)stopPlayingAudio
{
    [audioPlayer pause];
    [playStopButton setImage:[UIImage imageNamed: @"playbby.png"] forState:UIControlStateNormal];            
    audioPlaying = FALSE;
}

@end
