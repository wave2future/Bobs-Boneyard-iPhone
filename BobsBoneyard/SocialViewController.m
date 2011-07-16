//
//  SocialViewController.m
//  BobsBoneyard
//
//  Created by Ben on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SocialViewController.h"
#import "TwitterViewController.h"
#import "FacebookViewController.h"


@implementation SocialViewController

@synthesize twitterButton;
@synthesize facebookButton;

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
    
    [twitterButton addTarget:self action:@selector(twitterButtonClick:) forControlEvents:UIControlEventTouchDown];
    [facebookButton addTarget:self action:@selector(facebookButtonClick:) forControlEvents:UIControlEventTouchDown];
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

- (void)viewDidDisappear:(BOOL)animated {
    if ([self.view.subviews count] == 4) {
        UIView *lastView = [self.view.subviews objectAtIndex:3];
        [lastView removeFromSuperview];
    }
}

- (void)twitterButtonClick:(id)sender {
    TwitterViewController *twitterViewController = [[TwitterViewController alloc] initWithNibName:@"TwitterViewController" bundle:[NSBundle mainBundle]];
    [self.view addSubview:twitterViewController.view];
    [twitterViewController release];
}

- (void)facebookButtonClick:(id)sender {
    FacebookViewController *facebookViewController = [[FacebookViewController alloc] initWithNibName:@"FacebookViewController" bundle:[NSBundle mainBundle]];
    [self.view addSubview:facebookViewController.view];
    [facebookViewController release];
}

@end
