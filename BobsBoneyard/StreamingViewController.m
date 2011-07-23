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
    [podcastUrl release];
    
    [audioPlayer release];
    
    [playButton release];
    [stopButton release];
    
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
    
    playButton = [UIImage imageNamed: @"playbby.png"];
    stopButton = [UIImage imageNamed: @"stopBBY.png"];
    [playStopButton addTarget:self action:@selector(playStopButtonClick:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)playStopButtonClick:(id)sender {
    NSLog(@"%@", podcastUrl);
    
    if (audioPlayer)
    {
        if (audioPlaying)
        {
            [audioPlayer pause];
            [playStopButton setImage:playButton forState:UIControlStateNormal];            
            audioPlaying = FALSE;
        }
        else
        {
            [audioPlayer play];
            [playStopButton setImage:stopButton forState:UIControlStateNormal];
            audioPlaying = TRUE;
        }
    }
    else
    {
        audioPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:podcastUrl]];
        [audioPlayer addObserver:self forKeyPath:@"status" options:0 context:nil];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(object == audioPlayer && [keyPath isEqualToString:@"status"])
    {
        [audioPlayer play];
        [playStopButton setImage:stopButton forState:UIControlStateNormal];
        audioPlaying = TRUE;
    }
}

@end
