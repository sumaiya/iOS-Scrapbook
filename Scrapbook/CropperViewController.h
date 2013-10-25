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
@class FilterEditor;

@interface CropperViewController : UIViewController <InstagramViewControllerDelegate>

@property UIImageView *mainImageView;
@property CropRegionView *cropper;
@property UIView *topCropField;
@property UIView *bottomCropField;
@property UIView *leftCropField;
@property UIView *rightCropField;

@property FilterEditor *filterController;

@property UITapGestureRecognizer *doubleTabRecognizer;

@property id target;
@property SEL action;

-(void)setup;
-(void)cropImageAndSendToTarget;
-(void)didGetImage:(UIImage* )sentImage;

@end
