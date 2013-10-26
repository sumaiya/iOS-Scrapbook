//
//  CropperViewController.m
//  ImageEditor
//
//  Created by Patrick McNally on 10/8/13.
//  Copyright (c) 2013 Pomona College. All rights reserved.
//

#import "CropperViewController.h"
#import "FilterViewController.h"
#import "SBAppDelegate.h"

@interface CropperViewController ()

@end

@implementation CropperViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.filterController = [[FilterViewController alloc] init];
        self.delegate = self.filterController;
     //   [self.filterController setup];
    }
    return self;
}

- (void)setup
{    
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
    
    self.wholeImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.wholeImage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.wholeImage setBackgroundColor:[UIColor blackColor]];
    [self.wholeImage setFrame:CGRectMake(70, 330, 180, 30)];
    [self.wholeImage setTitle:@"Use full image" forState:UIControlStateNormal];
    [self.wholeImage addTarget:self action:@selector(sendWholeImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.wholeImage];
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
    
    [self.delegate didGetCroppedImage:croppedFromCG];

    [self.navigationController pushViewController:self.filterController animated:YES];
}

-(void)sendWholeImage {
    
    [self.delegate didGetCroppedImage:self.mainImageView.image];
    [self.navigationController pushViewController:self.filterController animated:YES];
}

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[(SBAppDelegate *)[[UIApplication sharedApplication] delegate] BACKGROUND_TEXTURE]]]];

    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
