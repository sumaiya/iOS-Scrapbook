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
#import "FilterViewController.h"

@interface AddSBItemViewController : UIViewController <FilterViewControllerDelegate>

@property IBOutlet UITextField *photoTitle;
@property IBOutlet UITextField *photoOwner;
@property IBOutlet UIImageView *photoView;
@property UIImage *imageToShow;
@property NSData *imageData;
@property IBOutlet UIButton *addButton;

@property id target;
@property SEL action;

-(IBAction)addButtonDidGetPressed:(id)sender;
-(void)clearFields;
-(void)didGetImage:(UIImage* )sentImage;

@end
