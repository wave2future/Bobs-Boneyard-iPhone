//
//  ContactViewController.h
//  BobsBoneyard
//
//  Created by Ben on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ContactViewController : UIViewController {
    IBOutlet UIButton *goodButton;
    IBOutlet UIButton *badButton;
    IBOutlet UIButton *mannyButton;
}

@property (nonatomic, retain) UIButton *goodButton;
@property (nonatomic, retain) UIButton *badButton;
@property (nonatomic, retain) UIButton *mannyButton;

@end
