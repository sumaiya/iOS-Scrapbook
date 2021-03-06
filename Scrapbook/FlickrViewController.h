//
//  FlickrViewController.h
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 10/10/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrTagSearcher.h"
extern UIColor* BACKGROUND_TEXTURE;

@class FlickrViewController;

@protocol FlickrViewControllerDelegate <NSObject>
- (void)didGetImage:(UIImage *)sentImage;
@end

@class CropperViewController;

@interface FlickrViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UITextField *queryField;
@property (strong, nonatomic) UICollectionView *photosCollectionView;
@property (strong, nonatomic) FlickrTagSearcher *searcher;
@property NSMutableArray *flickrPhotos;
@property CropperViewController *croppingView;

@property (nonatomic, weak) id <FlickrViewControllerDelegate> delegate;

- (void)handleFlickrData:(NSMutableDictionary *)data;

@end
