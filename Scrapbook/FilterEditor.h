//
//  FilterEditor.h
//  ImageEditor
//
//  Created by Patrick McNally on 10/9/13.
//  Copyright (c) 2013 Pomona College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CropperViewController.h"

@interface FilterEditor : UIViewController

@property UIImageView *mainImageView;
@property UIImage *originalImage;
@property UIButton *selectImageButton;
@property UIButton *sepiaButton;
@property CropperViewController *cropView;

- (void)getImagePressed;
- (void)setup;
- (void)handleCroppedImage:(UIImage *)croppedImage;

@end
