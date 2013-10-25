//
//  AddSBItemViewController.m
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 9/26/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import "AddSBItemViewController.h"
#import "SBAppDelegate.h"

@interface AddSBItemViewController ()

@end

@implementation AddSBItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self clearFields];
        [self.navigationItem setTitle:@"Add Photo"];
//        //create the tab bar controller object
//        self.tabBarController = [[UITabBarController alloc] init];
//        
//        //create the first view controller
//        self.instagramView = [[InstagramViewController alloc] initWithNibName:@"InstagramViewController" bundle:nil];
//        [self.instagramView.view setFrame:[[UIScreen mainScreen] bounds]];
//        //this is where we set the main (instagram) view's representation on the tab bar
//        self.instagramView.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Instagram" image:[UIImage imageNamed:@"86-camera.png"] tag:1];
//        
//        //create the second view controller
//        self.flickrView = [[FlickrViewController alloc] initWithNibName:@"FlickrViewController" bundle:nil];
//        [self.flickrView.view setFrame:[[UIScreen mainScreen] bounds]];
//        
//        //this is where we set the flickr view's representation on the tab bar
//        self.flickrView.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Flickr" image:[UIImage imageNamed:@"41-picture-frame.png"] tag:2];
//      
//        //add the viewcontrollers to the tab bar
//        [self.tabBarController setViewControllers:[NSArray arrayWithObjects:self.instagramView, self.flickrView, nil] animated:YES];
//
//        self.flickrView.delegate = self;
//        self.instagramView.delegate = self;
    }
    return self;
}


-(IBAction)addButtonDidGetPressed:(id)sender {
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:self.photoUrl, self.photoTitle.text, self.photoOwner.text, nil] forKeys:[NSArray arrayWithObjects:@"url", @"title", @"owner", nil]];

    [self.target performSelector:self.action withObject:temp];
    [self clearFields];
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)selectPhotoButtonDidGetPressed:(id)sender {
    [self.navigationController pushViewController:self.tabBarController animated:YES];
}


-(void)clearFields
{
    [self.photoTitle setText:@""];
    [self.photoOwner setText:@""];
    [self.photoView setBackgroundColor:[UIColor grayColor]];
    [self.photoView setImage:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.photoTitle.isFirstResponder) {
        [self.photoTitle resignFirstResponder];
    }
    if (self.photoOwner.isFirstResponder) {
        [self.photoOwner resignFirstResponder];
    }
    return YES;
}

- (void)didGetUrl:(NSString *)url
{
    self.photoUrl = url;
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
    self.photoView.image = [UIImage imageWithData: imageData];
}

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[(SBAppDelegate *)[[UIApplication sharedApplication] delegate] BACKGROUND_TEXTURE]]]];;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
