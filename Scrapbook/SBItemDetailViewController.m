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
    }
    return self;
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
