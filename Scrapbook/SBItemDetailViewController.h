//
//  SBItemDetailViewController.h
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 9/26/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTwitterPoster.h"
@interface SBItemDetailViewController : UIViewController


@property IBOutlet UILabel *photoTitle;
@property IBOutlet UILabel *owner;
@property IBOutlet UIImageView *photoView;
@property IBOutlet UIButton *tweetButton;
@property SLComposeViewController *composer;

- (void)setFieldsWithUrl:(NSString *)newUrl andTitle:(NSString *)newTitle andOwner:(NSString *)newOwner;
- (IBAction)presentPostComposer;


@end
