//
//  SBItemDetailViewController.m
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 9/26/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import "SBItemDetailViewController.h"
#import "SBAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface SBItemDetailViewController ()

@end

@implementation SBItemDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.navigationItem setTitle:@"Photo Details"];
        [self.view setUserInteractionEnabled:TRUE];
    }
    return self;
}

// called when the user taps the post button
- (IBAction)presentPostComposer
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        NSString *titleText = self.photoTitle.text;
        self.composer = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [self.composer setInitialText:[NSString stringWithFormat:@"Check out my masterpiece, %@! (posted by Scrapbook)",titleText]];
        [self.composer addImage:self.photoView.image];
        
        [self presentViewController:self.composer animated:YES completion:nil];
    }
}


- (void)setFieldsWithUrl:(NSString *)newUrl andTitle:(NSString *)newTitle andOwner:(NSString *)newOwner;
{
    [self.view setNeedsDisplay];
    [self.photoTitle setText:newTitle];
    [self.owner setText:[NSString stringWithFormat:@"%@", newOwner]];
    [self.photoView setImage:[UIImage imageWithData: [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: newUrl]]]];
}

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[(SBAppDelegate *)[[UIApplication sharedApplication] delegate] BACKGROUND_TEXTURE]]]];;
    
    [self.photoView.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [self.photoView.layer setBorderWidth: 4.0];
   
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
