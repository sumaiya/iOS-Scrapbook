//
//  FilterEditor.m
//  ImageEditor
//
//  Created by Patrick McNally on 10/9/13.
//  Copyright (c) 2013 Pomona College. All rights reserved.
//

#import "FilterEditor.h"

@interface FilterEditor ()

@end

@implementation FilterEditor

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)setup
{
    self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 300)];
    [self.view addSubview:self.mainImageView];
    
    self.selectImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectImageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.selectImageButton setBackgroundColor:[UIColor whiteColor]];
    [self.selectImageButton setFrame:CGRectMake(100, 310, 120, 30)];
    [self.selectImageButton setTitle:@"get an image" forState:UIControlStateNormal];
    [self.selectImageButton addTarget:self action:@selector(getImagePressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.selectImageButton];
    
    self.sepiaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sepiaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.sepiaButton setBackgroundColor:[UIColor whiteColor]];
    [self.sepiaButton setFrame:CGRectMake(100, 350, 120, 30)];
    [self.sepiaButton setTitle:@"apply sepia tone" forState:UIControlStateNormal];
    [self.sepiaButton addTarget:self action:@selector(applyFilter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sepiaButton];
    
    self.cropView = [[CropperViewController alloc] init];
    [self.cropView setup];
    self.cropView.target = self;
    self.cropView.action = @selector(handleCroppedImage:);
}

- (void)applyFilter
{
    if (self.originalImage != nil) {
        
        CIContext *context = [CIContext contextWithOptions:nil];
        
        CIImage *original = [CIImage imageWithCGImage:self.originalImage.CGImage];
        CIFilter *filter = [CIFilter filterWithName:@"CIPhotoEffectFade"];
        [filter setValue:original forKey:@"inputImage"];
        CIImage *newImage = [filter valueForKey:@"outputImage"];
        
        
        CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone"];
        [sepia setValue:newImage forKey:@"inputImage"];
        CIImage *newNewImage = [sepia valueForKey:@"outputImage"];
        
        CGImageRef cgimage = [context createCGImage:newNewImage fromRect:[newNewImage extent]];
        
        UIImage *newUIImage = [UIImage imageWithCGImage:cgimage];
        
        CGImageRelease(cgimage);
        
        
        // uncomment this line if you want to skip from CI to UI image... avoiding CG
        // this will allow you to avoid the need for creating a context and releasing a created CGImage
        //UIImage *newUIImage = [UIImage imageWithCIImage:newNewImage];
        
        
        
        [self.mainImageView setImage:newUIImage];
    }
}

- (void)handleCroppedImage:(UIImage *)croppedImage
{
    [self.mainImageView setImage:croppedImage];
    self.originalImage = croppedImage;
    
}

- (void)getImagePressed
{
    [self.navigationController pushViewController:self.cropView animated:YES];
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
