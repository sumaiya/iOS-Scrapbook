//
//  SBItemsViewController.h
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 9/26/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AddSBItemViewController.h"
#import "SBItemDetailViewController.h"
#import "SBItem.h"
#import "CameraViewController.h"
#import "FlickrViewController.h"
#import "InstagramViewController.h"

@interface SBItemsViewController : UITableViewController

@property NSMutableArray *sbItems; // the main data array
//@property AddSBItemViewController *addSBItemViewController;
@property SBItemDetailViewController *sbItemDetailViewController;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) InstagramViewController *instagramView;
@property (strong, nonatomic) FlickrViewController *flickrView;
@property CameraViewController *cameraView;

- (void)addSBItem:(NSMutableDictionary *)data;
- (void)addButtonPressed;

@end
