//
//  FilterViewController.m
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 10/24/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import "AddSBItemViewController.h"
#import "FilterViewController.h"
#import "SBAppDelegate.h"

@interface FilterViewController ()

@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.addView = [[AddSBItemViewController alloc] init];
        self.delegate = self.addView;
    }
    return self;
}

- (void)didGetCroppedImage:(UIImage *)sentImage
{
    self.originalImage = sentImage;
    [self viewDidLoad];
    [self.imageEditingView setImage:self.originalImage];
    self.currentImage = self.originalImage;
}

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[(SBAppDelegate *)[[UIApplication sharedApplication] delegate] BACKGROUND_TEXTURE]]]];
    self.imageEditingView.image = NULL;
    
    self.imageEditingView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 300)];
    [self.view addSubview:self.imageEditingView];

    self.sepiaButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sepiaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sepiaButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [self.sepiaButton setBackgroundColor:[UIColor blackColor]];
    [self.sepiaButton setFrame:CGRectMake(10, 325, 90, 30)];
    [self.sepiaButton setTitle:@"sepia" forState:UIControlStateNormal];
    [self.sepiaButton addTarget:self action:@selector(applySepiaFilter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sepiaButton];
    
    self.blurButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.blurButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.blurButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [self.blurButton setBackgroundColor:[UIColor blackColor]];
    [self.blurButton setFrame:CGRectMake(115, 325, 90, 30)];
    [self.blurButton setTitle:@"bloom" forState:UIControlStateNormal];
    [self.blurButton addTarget:self action:@selector(applyBlurFilter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.blurButton];
    
    self.posterizeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.posterizeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.posterizeButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [self.posterizeButton setBackgroundColor:[UIColor blackColor]];
    [self.posterizeButton setFrame:CGRectMake(220, 325, 90, 30)];
    [self.posterizeButton setTitle:@"posterize" forState:UIControlStateNormal];
    [self.posterizeButton addTarget:self action:@selector(applyPosterizeFilter) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.posterizeButton];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [self.saveButton setBackgroundColor:[UIColor blackColor]];
    [self.saveButton setFrame:CGRectMake(110, 370, 100, 30)];
    [self.saveButton setTitle:@"save" forState:UIControlStateNormal];
    [self.saveButton addTarget:self action:@selector(sendToAddView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.saveButton];
    

    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)sendToAddView {
    [self.delegate didGetImage:self.currentImage];
    
//TODO sometimes it freezes here... why?
    if (self.addView && self.navigationController){
        [self.navigationController pushViewController:self.addView animated:YES];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void) disableButtons {
    self.sepiaButton.enabled = NO;
    self.blurButton.enabled = NO;
    self.posterizeButton.enabled = NO;
}

- (void)applySepiaFilter
{
    if (self.currentImage != nil && self.sepiaButton.isEnabled) {
        
        CIContext *context = [CIContext contextWithOptions:nil];
        CIImage *current = [CIImage imageWithCGImage:self.currentImage.CGImage];
        
        CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"];
        [filter setValue:current forKey:@"inputImage"];
        CIImage *newImage = [filter valueForKey:@"outputImage"];
        CGImageRef cgimage = [context createCGImage:newImage fromRect:[newImage extent]];
        
        UIImage *newUIImage = [UIImage imageWithCGImage:cgimage];
        
        CGImageRelease(cgimage);
        // uncomment this line if you want to skip from CI to UI image... avoiding CG
        // this will allow you to avoid the need for creating a context and releasing a created CGImage
       // UIImage *newUIImage = [UIImage imageWithCIImage:newImage];

        self.currentImage = newUIImage;
                
        [self.imageEditingView setImage:newUIImage];
        
        [self disableButtons];
    }
}

- (void)applyBlurFilter
{
    if (self.currentImage != nil && self.blurButton.isEnabled) {
        
        CIContext *context = [CIContext contextWithOptions:nil];
        CIImage *current = [CIImage imageWithCGImage:self.currentImage.CGImage];

        CIFilter *filter = [CIFilter filterWithName:@"CIBloom"];
        [filter setValue:current forKey:@"inputImage"];
        CIImage *newImage = [filter valueForKey:@"outputImage"];
        CGImageRef cgimage = [context createCGImage:newImage fromRect:[newImage extent]];
        
        UIImage *newUIImage = [UIImage imageWithCGImage:cgimage];
       // UIImage *newUIImage = [UIImage imageWithCIImage:newImage];
        
        self.currentImage = newUIImage;
        
        [self.imageEditingView setImage:newUIImage];
        
        [self disableButtons];
    }
}

- (void)applyPosterizeFilter
{
    if (self.currentImage != nil && self.posterizeButton.isEnabled) {
        CIContext *context = [CIContext contextWithOptions:nil];
        CIImage *current = [CIImage imageWithCGImage:self.currentImage.CGImage];
        
        CIFilter *filter = [CIFilter filterWithName:@"CIColorPosterize"];
        [filter setValue:current forKey:@"inputImage"];
        CIImage *newImage = [filter valueForKey:@"outputImage"];
        CGImageRef cgimage = [context createCGImage:newImage fromRect:[newImage extent]];

        UIImage *newUIImage = [UIImage imageWithCGImage:cgimage];

//        UIImage *newUIImage = [UIImage imageWithCIImage:newImage];
        
        self.currentImage = newUIImage;
        
        [self.imageEditingView setImage:newUIImage];
        
        [self disableButtons];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
