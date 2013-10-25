//
//  MainTwitterPoster.h
//  BasicTwitterPoster
//
//  Created by Patrick McNally on 10/23/13.
//  Copyright (c) 2013 Pomona College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "TwitterStreamer.h"

@interface MainTwitterPoster : UIViewController

@property UIButton *postButton;
@property UIButton *streamButton;
@property SLComposeViewController *composer;
@property TwitterStreamer *streamer;

@property UITextView *textView;

- (void)setup;
- (void)presentPostComposer;

@end
