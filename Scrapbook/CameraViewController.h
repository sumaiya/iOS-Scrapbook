//
//  CameraViewController.h
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 10/24/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CameraViewController;

@protocol CameraViewControllerDelegate <NSObject>
- (void)didGetImage:(UIImage *)sentImage;
@end

@class CropperViewController;

@interface CameraViewController : UIViewController

@property UIImagePickerController *camera;
@property UIImagePickerController *photoReel;

//@property UITabBarController *tabBarController;

@property UIButton *presentCameraButton;

//@property UIImageView *selectedImageView;

@property CropperViewController *croppingView;


@property (nonatomic, weak) id <CameraViewControllerDelegate> delegate;

- (void)setup;

@end
