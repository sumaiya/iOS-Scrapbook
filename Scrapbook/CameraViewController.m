//
//  CameraViewController.m
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 10/24/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import "CameraViewController.h"
#import "CropperViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.croppingView = [[CropperViewController alloc] init];
        [self.croppingView setup];
        self.delegate = self.croppingView;
    }
    return self;
}

- (void)setup
{
    self.photoReel = [[UIImagePickerController alloc] init];
    [self.photoReel setDelegate:self];
    

if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    self.camera = [[UIImagePickerController alloc] init];
    self.camera.delegate = self;
        
    UIButton *takePhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    [takePhoto addTarget:self.camera action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    [takePhoto setTitle:@"Take PHOTO" forState:UIControlStateNormal];
    
    [self.camera  setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self.camera setCameraDevice:UIImagePickerControllerCameraDeviceRear];
        [self.camera setShowsCameraControls:NO];
        [self.camera setCameraOverlayView:takePhoto];
    
    [takePhoto setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - self.tabBarController.tabBar.frame.size.height - 60, 320, 60)];

    self.presentCameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.presentCameraButton setFrame:CGRectMake(10, 360, 300, 40)];
    [self.presentCameraButton setTitle:@"Pick an Image" forState:UIControlStateNormal];
    [self.presentCameraButton addTarget:self action:@selector(presentImagePickerView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.presentCameraButton];
    
    }
   
}

- (void)presentImagePickerView
{
    [self presentViewController:self.photoReel animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
   
    UIImage* imageToSend = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self.delegate didGetImage:imageToSend];
    
    [self.photoReel.navigationController pushViewController:self.croppingView animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.photoReel.navigationController popViewControllerAnimated:TRUE];
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
