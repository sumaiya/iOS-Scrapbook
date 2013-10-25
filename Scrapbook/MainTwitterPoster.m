//
//  MainTwitterPoster.m
//  BasicTwitterPoster
//
//  Created by Patrick McNally on 10/23/13.
//  Copyright (c) 2013 Pomona College. All rights reserved.
//

#import "MainTwitterPoster.h"

@interface MainTwitterPoster ()

@end

@implementation MainTwitterPoster

- (void)setup
{
    
    // setup the post button
    self.postButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.streamButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.streamButton setBackgroundColor:[UIColor whiteColor]];

    [self.postButton setTitle:@"Post!" forState:UIControlStateNormal];
    [self.postButton setFrame:CGRectMake(10, 360, 300, 30)];
    [self.postButton addTarget:self action:@selector(presentPostComposer) forControlEvents:UIControlEventTouchUpInside];
    
    // setup the stream button
    self.streamButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.streamButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.streamButton setBackgroundColor:[UIColor whiteColor]];

    [self.streamButton setTitle:@"Stream!" forState:UIControlStateNormal];
    [self.streamButton setFrame:CGRectMake(10, 390, 300, 30)];
    [self.streamButton addTarget:self action:@selector(startStreaming) forControlEvents:UIControlEventTouchUpInside];
    
    // add the buttons to the view
    [self.view addSubview:self.postButton];
    [self.view addSubview:self.streamButton];
    
    // make the text view for showing the streaming tweets
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, 320, 300)];
    
    // add it to the view
    [self.view addSubview:self.textView];
    
    // create and setup the twitter stream
    self.streamer = [[TwitterStreamer alloc] init];
    self.streamer.target = self;
    self.streamer.action = @selector(handleTweet:);
    [self.streamer requestAccounts];
}


// what to do when the stream hands over a tweet
- (void)handleTweet:(NSDictionary *)tweet
{
    NSLog([tweet objectForKey:@"text"]);
    [self.textView setText:[tweet objectForKey:@"text"]];
}

// called when the user taps the stream button
- (void)startStreaming
{
    [self.streamer startStreamWithQuery:@"bieber"];
}

// called when the user taps the post button
- (void)presentPostComposer
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        self.composer = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
        [self.composer setInitialText:@"heyo some text for twitter"];
        [self.composer addImage:[UIImage imageNamed:@"mattsmith.jpg"]];
    
        [self presentViewController:self.composer animated:YES completion:nil];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
