//
//  BobsBoneyardAppDelegate.h
//  BobsBoneyard
//
//  Created by Ben on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BobsBoneyardAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {

}
- (IBAction)twitterButtonClicked;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
