//
//  SocialViewController.h
//  BobsBoneyard
//
//  Created by Ben on 7/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SocialViewController : UIViewController {
    IBOutlet UIButton *twitterButton;
    IBOutlet UIButton *facebookButton;
}

@property (nonatomic, retain) UIButton *twitterButton;
@property (nonatomic, retain) UIButton *facebookButton;

@end
