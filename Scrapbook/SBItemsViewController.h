//
//  SBItemsViewController.h
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 9/26/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddSBItemViewController.h"
#import "SBItemDetailViewController.h"
#import "SBItem.h"

@interface SBItemsViewController : UITableViewController

@property NSMutableArray *sbItems; // the main data array
@property AddSBItemViewController *addSBItemViewController;
@property SBItemDetailViewController *sbItemDetailViewController;

- (void)addSBItem:(NSMutableDictionary *)sbItemInfo;
- (void)addButtonPressed;

@end
