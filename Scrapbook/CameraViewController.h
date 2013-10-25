//
//  CameraViewController.h
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 10/24/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController

@property UIImagePickerController *camera;
@property UIImagePickerController *photoReel;

//@property UITabBarController *tabBarController;

@property UIButton *presentCameraButton;

@property UIImageView *selectedImageView;

- (void)setup;

@end
