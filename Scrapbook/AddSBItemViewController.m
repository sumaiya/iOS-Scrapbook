//
//  AddSBItemViewController.m
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 9/26/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import "AddSBItemViewController.h"
#import "SBAppDelegate.h"
#import "SBDatabase.h"
#import "SBItemsViewController.h"

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
    }
    return self;
}


-(IBAction)addButtonDidGetPressed:(id)sender {

   if (self.addButton.
       isEnabled) {

        [SBDatabase saveSBItemWithImage:self.imageData andTitle:self.photoTitle.text andOwner:self.photoOwner.text];
       //TODO does not save with filter or cropping...??
       
        [self clearFields];

        SBItemsViewController *rootController = [self.navigationController.viewControllers objectAtIndex:0];

       [rootController refreshData];
       
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
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

-(void)didGetImage:(UIImage *)sentImage {
    self.imageToShow = sentImage;
    
    [self viewDidLoad];
    
    self.imageData = UIImagePNGRepresentation(self.photoView.image);
//    self.imageData = UIImageJPEGRepresentation(self.photoView.image,1.0);
    NSLog(@"got data");
    
    while (self.imageData == NULL) {
        self.addButton.enabled = NO;
    }
    NSLog(@"data is not null");

    self.addButton.enabled = YES;
}

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[(SBAppDelegate *)[[UIApplication sharedApplication] delegate] BACKGROUND_TEXTURE]]]];
  
    self.photoView.image = self.imageToShow;

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
