//
//  AddSBItemViewController.m
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 9/26/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import "AddSBItemViewController.h"

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
        self.photosViewController = [[SBPhotosViewController alloc] initWithNibName:@"SBPhotosViewController" bundle:nil];
        self.photosViewController.delegate = self;
    }
    return self;
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [self clearFields];
//}

-(IBAction)addButtonDidGetPressed:(id)sender {
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:self.photoUrl, self.photoTitle.text, self.photoOwner.text, nil] forKeys:[NSArray arrayWithObjects:@"url", @"title", @"owner", nil]];

//    SBItem *temp = [[SBItem alloc] initWithURL:self.photoUrl andTitle:self.photoTitle.text andOwner:self.photoOwner.text andId:<#(int)#>];
    [self.target performSelector:self.action withObject:temp];
    [self clearFields];
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction)selectPhotoButtonDidGetPressed:(id)sender {
    [self.navigationController pushViewController:self.photosViewController animated:YES];
}


-(void)clearFields
{
    [self.photoTitle setText:@""];
    [self.photoOwner setText:@""];
    [self.photoView setImage:[UIImage imageNamed:@"placeholder.png"]];
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

- (void)photosViewController:(SBPhotosViewController *)sbViewController didGetUrl:(NSString *)url;
{
    self.photoUrl = url;
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
    self.photoView.image = [UIImage imageWithData: imageData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
