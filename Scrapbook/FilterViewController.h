//
//  FilterViewController.h
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 10/24/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CropperViewController.h"

@class FilterViewController;
@protocol FilterViewControllerDelegate <NSObject>
- (void)didGetImage:(UIImage *)sentImage;
@end

@class AddSBItemViewController;

@interface FilterViewController : UIViewController <CropperViewControllerDelegate>

@property UIImage *originalImage;
@property UIImage *currentImage;
@property UIImageView *imageEditingView;
@property UIButton *sepiaButton;
@property UIButton *blurButton;
@property UIButton *posterizeButton;
@property UIButton *saveButton;
@property AddSBItemViewController *addView;

@property (nonatomic, weak) id <FilterViewControllerDelegate> delegate;

-(void)didGetCroppedImage:(UIImage* )sentImage;
-(void)applySepiaFilter;
-(void)applyBlurFilter;
-(void)applyPosterizeFilter;
-(void)sendToAddView;

@end
