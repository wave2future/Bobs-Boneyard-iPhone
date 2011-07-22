//
//  EpisodeDetailViewController.m
//  BobsBoneyard
//
//  Created by Ben on 7/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EpisodeDetailViewController.h"
#import "NSString+HTML.h"

@implementation EpisodeDetailViewController

@synthesize titleLabel;
@synthesize subtitleLabel;
@synthesize dateLabel;
@synthesize summaryLabel;
@synthesize episodeDetails;

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
    [dateLabel release];
    [summaryLabel release];
    [episodeDetails release];
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
    if (episodeDetails)
    {
        if(episodeDetails.title)
        {
            NSString *itemTitle = episodeDetails.title ? [episodeDetails.title stringByConvertingHTMLToPlainText] : @"[No Title]";
            NSArray *titleParts = [itemTitle componentsSeparatedByString: @" -- "]; 
            
            if([titleParts count] == 2)
            {
                NSString *curTitle = [titleParts objectAtIndex:1];
                NSString *curSubtitle = [titleParts objectAtIndex:0];
                
                self.titleLabel.text = curTitle;
                self.subtitleLabel.text = curSubtitle;
                self.title = [curSubtitle stringByReplacingOccurrencesOfString:@"Bob's Boneyard " withString:@""];
            }
        }
        
        // Date
        if (episodeDetails.date) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterNoStyle];
            self.dateLabel.text = [formatter stringFromDate:episodeDetails.date];
            [formatter release];
        }
        
        // Summary
        if (episodeDetails.summary) {
            self.summaryLabel.text = [episodeDetails.summary stringByConvertingHTMLToPlainText];
        }
    }
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setSubtitleLabel:nil];
    [self setDateLabel:nil];
    [self setSummaryLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)stream:(id)sender {
    UINavigationController *navController = (UINavigationController*)[self parentViewController];
    UITabBarController *tabBarController = (UITabBarController*)[navController parentViewController];
    
    [navController popViewControllerAnimated:FALSE];
    [tabBarController setSelectedViewController:[[tabBarController viewControllers] objectAtIndex:0]];
}
@end
