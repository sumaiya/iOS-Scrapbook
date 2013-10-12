//
//  FlickrViewController.h
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 10/10/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrTagSearcher.h"

@class FlickrViewController;

@protocol FlickrViewControllerDelegate <NSObject>
- (void)didGetUrl:(NSString *)url;
@end

@interface FlickrViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UITextField *queryField;
@property (strong, nonatomic) IBOutlet UICollectionView *photosCollectionView;
@property (strong, nonatomic) FlickrTagSearcher *searcher;
@property NSMutableArray *flickrPhotos;

@property (nonatomic, weak) id <FlickrViewControllerDelegate> delegate;

- (void)handleFlickrData:(NSMutableDictionary *)data;

@end
