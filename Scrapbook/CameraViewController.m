//
//  CameraViewController.m
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 10/24/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

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
    self.camera = [[UIImagePickerController alloc] init];
    self.camera.delegate = self;
    
    [self.camera.tabBarItem setTitle:@"Camera"];
    
    UIButton *takePhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    [takePhoto addTarget:self.camera action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    [takePhoto setTitle:@"Take PHOTO" forState:UIControlStateNormal];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self.camera  setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self.camera setCameraDevice:UIImagePickerControllerCameraDeviceRear];
        [self.camera setShowsCameraControls:NO];
        [self.camera setCameraOverlayView:takePhoto];
    }
    
    self.photoReel = [[UIImagePickerController alloc] init];
    [self.photoReel setDelegate:self];
    [self.photoReel.tabBarItem setTitle:@"photo library"];
    [takePhoto setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - self.tabBarController.tabBar.frame.size.height - 60, 320, 60)];
    
    self.presentCameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.presentCameraButton setFrame:CGRectMake(10, 360, 300, 40)];
    [self.presentCameraButton setTitle:@"Pick an Image" forState:UIControlStateNormal];
    [self.presentCameraButton addTarget:self action:@selector(presentImagePickerView) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.selectedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 320)];
    
    [self.view addSubview:self.selectedImageView];
    [self.selectedImageView setClipsToBounds:YES];
    [self.selectedImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:self.presentCameraButton];
}

- (void)presentImagePickerView
{
    [self presentViewController:self.tabBarController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
    for (NSString *obj in [info keyEnumerator]) {
        NSLog(obj);
    }
    [self.selectedImageView setImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
}

//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
//}

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
