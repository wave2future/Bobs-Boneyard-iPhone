//
//  EpisodesViewController.m
//  BobsBoneyard
//
//  Created by Ben on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EpisodesViewController.h"
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
    
    // Create feed parser and pass the URL of the feed
    NSURL *feedURL = [NSURL URLWithString:@"http://bobsboneyard.com/podcast/boneyard.xml"];
    MWFeedParser *feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull;
    feedParser.connectionType = ConnectionTypeAsynchronously;
    [feedParser parse];
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
	self.itemsToDisplay = [parsedItems sortedArrayUsingDescriptors:
						   [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"date" 
																				 ascending:NO] autorelease]]];
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

@end
