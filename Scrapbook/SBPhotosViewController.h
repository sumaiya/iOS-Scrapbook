//
//  SBPhotosViewController.h
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 9/27/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstagramTagSearcher.h"
#import "FlickrTagSearcher.h"

//make AddSBItemViewController a delegate of SBPhotosViewController
@class SBPhotosViewController;

@protocol SBPhotosViewControllerDelegate <NSObject>
- (void)photosViewController:(SBPhotosViewController *)sbViewController didGetUrl:(NSString *)url;
@end

@interface SBPhotosViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *queryField;
@property (strong, nonatomic) IBOutlet UITableView *photosTableView;

@property (strong, nonatomic) InstagramTagSearcher *instagramSearcher;
@property (strong, nonatomic) FlickrTagSearcher *flickrSearcher;

@property NSMutableArray *instagramPhotos;
@property NSMutableArray *flickrPhotos;

@property (nonatomic, weak) id <SBPhotosViewControllerDelegate> delegate;


- (void)handleInstagramData:(NSMutableDictionary *)data;
- (void)handleFlickrData:(NSMutableDictionary *)data;

@end
