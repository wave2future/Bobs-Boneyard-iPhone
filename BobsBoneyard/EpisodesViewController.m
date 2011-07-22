//
//  EpisodesViewController.m
//  BobsBoneyard
//
//  Created by Ben on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EpisodesViewController.h"
#import "EpisodeDetailViewController.h"
#import "StreamingViewController.h"
#import "NSString+HTML.h"

@implementation EpisodesViewController

@synthesize itemsToDisplay;

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
    [formatter release];
	[parsedItems release];
	[itemsToDisplay release];
    [feedParser release];
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
    
    formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterShortStyle];
	[formatter setTimeStyle:NSDateFormatterShortStyle];
    
    parsedItems = [[NSMutableArray alloc] init];
	self.itemsToDisplay = [NSArray array];
    
    // Refresh button
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
        target:self 
        action:@selector(refresh)] autorelease];
    
    // Create feed parser and pass the URL of the feed
    NSURL *feedURL = [NSURL URLWithString:@"http://bobsboneyard.com/podcast/boneyard.xml"];
    feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull;
    feedParser.connectionType = ConnectionTypeAsynchronously;
    [feedParser parse];
}

// Reset and reparse
- (void)refresh {
	self.title = @"Refreshing...";
	[parsedItems removeAllObjects];
	[feedParser stopParsing];
	[feedParser parse];
	self.tableView.userInteractionEnabled = NO;
	self.tableView.alpha = 0.3;
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

- (void)feedParserDidStart:(MWFeedParser *)parser {
	NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
	NSLog(@"Parsed Feed Info: “%@”", info.title);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
	NSLog(@"Parsed Feed Item: “%@”", item.title);
    if (item && [item.enclosures count] == 1)
    {
        NSString* type = [[item.enclosures objectAtIndex:0] objectForKey:@"type"];
        if([type isEqualToString:@"audio/mp3"])                  
            [parsedItems addObject:item];		
    }
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
	NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @""));
    self.title = @"Episodes";
	self.itemsToDisplay = [parsedItems sortedArrayUsingDescriptors:
						   [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"date" 
																				 ascending:NO] autorelease]]];
    
    // Now that we have all the items, let's set the newest one in the streaming view
    // Declare the controllers we need to use
    UINavigationController *navController = (UINavigationController*)[self parentViewController];
    UITabBarController *tabBarController = (UITabBarController*)[navController parentViewController];
    StreamingViewController *streamingViewController = (StreamingViewController*)[[tabBarController viewControllers] objectAtIndex:0];
    
    // Get the item to set
    MWFeedItem *item = [self.itemsToDisplay objectAtIndex:0];
    if(item)
    {
        if(item.title)
        {
            NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
            NSArray *titleParts = [itemTitle componentsSeparatedByString: @" -- "]; 
            
            if([titleParts count] == 2)
            {
                NSString *curTitle = [titleParts objectAtIndex:1];
                NSString *curSubtitle = [titleParts objectAtIndex:0];
                
                streamingViewController.titleLabel.text = curTitle;
                streamingViewController.subtitleLabel.text = curSubtitle;
            }
        }
        
        if (item.summary)
        {
            streamingViewController.summaryLabel.text = [item.summary stringByConvertingHTMLToPlainText];
        }
    }
    
	self.tableView.userInteractionEnabled = YES;
	self.tableView.alpha = 1;
	[self.tableView reloadData];
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
	NSLog(@"Finished Parsing With Error: %@", error);
	self.itemsToDisplay = [NSArray array];
	[parsedItems removeAllObjects];
	self.tableView.userInteractionEnabled = YES;
	self.tableView.alpha = 1;
	[self.tableView reloadData];
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return itemsToDisplay.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	// Configure the cell.
	MWFeedItem *item = [itemsToDisplay objectAtIndex:indexPath.row];
	if (item) {
        NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
        NSMutableString *subtitle = [NSMutableString string];
        NSArray *titleParts = [itemTitle componentsSeparatedByString: @" -- "]; 
        
        if([titleParts count] == 2)
        {
            itemTitle = [titleParts objectAtIndex:1];
            [subtitle appendString:[titleParts objectAtIndex:0]];
        }
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
		cell.textLabel.text = itemTitle;
        cell.detailTextLabel.text = subtitle;
		
		//NSString *itemSummary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"[No Summary]";
		//if (item.date) [subtitle appendFormat:@"%@: ", [formatter stringFromDate:item.date]];
		//[subtitle appendString:itemSummary];
		
	}
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// Show detail
	EpisodeDetailViewController *detail = [[EpisodeDetailViewController alloc] initWithNibName:@"EpisodeDetailViewController" bundle:NULL];
	detail.episodeDetails = (MWFeedItem *)[itemsToDisplay objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:detail animated:YES];
	[detail release];
	
	// Deselect
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}

@end
