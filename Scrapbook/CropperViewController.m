//
//  CropperViewController.m
//  ImageEditor
//
//  Created by Patrick McNally on 10/8/13.
//  Copyright (c) 2013 Pomona College. All rights reserved.
//

#import "CropperViewController.h"
#import "FilterEditor.h"

@interface CropperViewController ()

@end

@implementation CropperViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.filterController   = [[FilterEditor alloc] init];
        [self.filterController setup];        
    }
    return self;
}

- (void)setup
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    [self.mainImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.mainImageView setUserInteractionEnabled:YES];
    
    self.cropper = [[CropRegionView alloc] initWithFrame:CGRectMake(110, 110, 100, 100)];
    self.cropper.parentView = self.mainImageView;
    [self.cropper checkBounds];
    [self.mainImageView addSubview:self.cropper];
    
    self.doubleTabRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cropImageAndSendToTarget)];
    [self.doubleTabRecognizer setNumberOfTapsRequired:2];
    [self.cropper addGestureRecognizer:self.doubleTabRecognizer];
    
    [self.view addSubview:self.mainImageView];
}

- (void)didGetImage:(UIImage *)sentImage;
{
    [self.mainImageView setImage:sentImage];
    [self.cropper checkBounds];
}

- (void)cropImageAndSendToTarget
{
    
    UIImage *croppedFromCG = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(self.mainImageView.image.CGImage, [self.cropper cropBounds])];
    
    CIImage *image = [CIImage imageWithCGImage:self.mainImageView.image.CGImage];
    CIImage *croppedImage = [image imageByCroppingToRect:[self.cropper cropBounds]];
    UIImage *croppedUIImage = [UIImage imageWithCIImage:croppedImage];
    
    if (self.target != nil && self.action != nil) {
        NSLog(@"sending the image");
        [self.target performSelector:self.action withObject:croppedFromCG];
    }
    [self.navigationController pushViewController:self.filterController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
