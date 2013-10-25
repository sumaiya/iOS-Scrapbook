//
//  InstagramViewController.h
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 10/10/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "InstagramTagSearcher.h"

@class InstagramViewController;
@protocol InstagramViewControllerDelegate <NSObject>
- (void)didGetImage:(UIImage *)sentImage;
@end

@class CropperViewController;

@interface InstagramViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UITextField *queryField;
@property (strong, nonatomic) UICollectionView *photosCollectionView;
@property (strong, nonatomic) InstagramTagSearcher *searcher;
@property NSMutableArray *instagramPhotos;
@property CropperViewController *croppingView;

@property id target;
@property SEL action;

@property (nonatomic, weak) id <InstagramViewControllerDelegate> delegate;

- (void)handleInstagramData:(NSMutableDictionary *)data;

@end
