//
//  AddSBItemViewController.h
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 9/26/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBItem.h"
#import "InstagramViewController.h"
#import "FlickrViewController.h"

@interface AddSBItemViewController : UIViewController <InstagramViewControllerDelegate, FlickrViewControllerDelegate>

@property IBOutlet UITextField *photoTitle;
@property IBOutlet UITextField *photoOwner;
@property IBOutlet UIImageView *photoView;
@property IBOutlet UIButton *addButton;
@property IBOutlet UIButton *selectPhotoButton;
@property NSString *photoUrl;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) InstagramViewController *instagramView;
@property (strong, nonatomic) FlickrViewController *flickrView;
@property id target;
@property SEL action;

-(IBAction)addButtonDidGetPressed:(id)sender;
-(IBAction)selectPhotoButtonDidGetPressed:(id)sender;
-(void)clearFields;
-(void)didGetUrl:(NSString *)url;

@end
