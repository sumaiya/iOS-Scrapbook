//
//  CropperViewController.h
//  ImageEditor
//
//  Created by Patrick McNally on 10/8/13.
//  Copyright (c) 2013 Pomona College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CropRegionView.h"
#import "InstagramViewController.h"
#import "FlickrViewController.h"
#import "CameraViewController.h"

@protocol CropperViewControllerDelegate <NSObject>
- (void)didGetCroppedImage:(UIImage *)sentImage;
@end

@class FilterViewController;

@interface CropperViewController : UIViewController <InstagramViewControllerDelegate, FlickrViewControllerDelegate, CameraViewControllerDelegate>

@property UIImageView *mainImageView;
@property CropRegionView *cropper;
@property UIView *topCropField;
@property UIView *bottomCropField;
@property UIView *leftCropField;
@property UIView *rightCropField;
@property UIButton *wholeImage;

@property FilterViewController *filterController;

@property UITapGestureRecognizer *doubleTabRecognizer;
//
//@property id target;
//@property SEL action;

@property (nonatomic, weak) id <CropperViewControllerDelegate> delegate;

-(void)setup;
-(void)cropImageAndSendToTarget;
-(void)didGetImage:(UIImage* )sentImage;

@end
