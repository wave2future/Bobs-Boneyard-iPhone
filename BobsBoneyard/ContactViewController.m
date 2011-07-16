//
//  ContactViewController.m
//  BobsBoneyard
//
//  Created by Ben on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ContactViewController.h"


@implementation ContactViewController

@synthesize goodButton;
@synthesize badButton;
@synthesize mannyButton;

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
    
    [goodButton addTarget:self action:@selector(goodButtonClick:) forControlEvents:UIControlEventTouchDown];
    [badButton addTarget:self action:@selector(badButtonClick:) forControlEvents:UIControlEventTouchDown];
    [mannyButton addTarget:self action:@selector(mannyButtonClick:) forControlEvents:UIControlEventTouchDown];
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

- (void)goodButtonClick:(id)sender {
    NSURL* mailURL = [NSURL URLWithString: @"mailto:bobsboneyard@gmail.com?subject=Love%20It!"];
    [[UIApplication sharedApplication] openURL: mailURL];
}

- (void)badButtonClick:(id)sender {
    NSURL* mailURL = [NSURL URLWithString: @"mailto:bobsboneyard@gmail.com?subject=Hate%20It!"];
    [[UIApplication sharedApplication] openURL: mailURL];
}

- (void)mannyButtonClick:(id)sender {
    NSURL* mailURL = [NSURL URLWithString: @"mailto:bobsboneyard@gmail.com?subject=Manny!"];
    [[UIApplication sharedApplication] openURL: mailURL];
}

@end
