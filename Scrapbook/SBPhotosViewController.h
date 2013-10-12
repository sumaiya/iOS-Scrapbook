//
//  SBPhotosViewController.h
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 9/27/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstagramViewController.h"
//#import "FlickrViewController.h"
#import "InstagramTagSearcher.h"
#import "FlickrTagSearcher.h"

//make AddSBItemViewController a delegate of SBPhotosViewController
@class SBPhotosViewController;

@protocol SBPhotosViewControllerDelegate <NSObject>
- (void)photosViewController:(SBPhotosViewController *)sbViewController didGetUrl:(NSString *)url;
@end

@interface SBPhotosViewController : UIViewController
@property (strong, nonatomic) InstagramViewController *instagramView;
//@property (strong, nonatomic) FlickrViewController *flickrView;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (nonatomic, weak) id <SBPhotosViewControllerDelegate> delegate;

@end
