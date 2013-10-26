//
//  InstagramViewController.m
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 10/10/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import "InstagramViewController.h"
#import "SBAppDelegate.h"
#import "CropperViewController.h"

@interface InstagramViewController ()

@end

@implementation InstagramViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.instagramPhotos = [[NSMutableArray alloc] initWithCapacity:0];
        self.croppingView = [[CropperViewController alloc] init];
        [self.croppingView setup];
        self.delegate = self.croppingView;
    }
    return self;
}

- (void)viewDidLoad
{
    self.title = @"Select Photo";
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[(SBAppDelegate *)[[UIApplication sharedApplication] delegate] BACKGROUND_TEXTURE]]]];;

    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setSectionInset: UIEdgeInsetsMake(15, 15, 0, 15)];
    [layout setMinimumLineSpacing:10];
    
    self.photosCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 80, 320, 290) collectionViewLayout:layout];
    self.photosCollectionView.delegate = self;
    self.photosCollectionView.dataSource = self;
    [self.photosCollectionView setBackgroundColor:[UIColor clearColor]];
    [self.photosCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:self.photosCollectionView];
    [self.photosCollectionView reloadData];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField //close keyboard and do search, on Return
{
    // clear old photos
    [self.instagramPhotos removeAllObjects];
    
    [self.queryField resignFirstResponder];

    self.searcher = [[InstagramTagSearcher alloc] initWithTagQuery:[[self queryField] text] andTarget:self andAction:@selector(handleInstagramData:)];
    
    [self.photosCollectionView reloadData];
    
       return TRUE;
}

- (void)handleInstagramData:(NSMutableDictionary *)data {
    // array of photo dictionaries
    NSArray *photos = [data objectForKey:@"data"];
    // limit to 30 photos
    if ([photos count] > 30) {
        NSArray* subset = [photos subarrayWithRange:NSMakeRange(0, 30)];
        photos = subset;
    }
    
    for (NSMutableDictionary *photo in photos) {
        NSString* photoUrl = [[[photo objectForKey:@"images"] objectForKey:@"low_resolution"] objectForKey:@"url"];
        // add photo URLS to self.instagramPhotos
        [self.instagramPhotos addObject:photoUrl];
    }
    
    [self.photosCollectionView reloadData];
}

#pragma mark Collection view data source methods
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [self.instagramPhotos count];
    }
    else
    {
        return 0;
    }
}

// Customize the number of sections in the collection view.
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}

// Customize the appearance of collection view cells.
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
// dequeueReusableCellWithIdentifier:forIndexPath asks the collection view for recyclable cell. If one is unavailable, a new cell of the type previously registered is created and returned
   
    static NSString *CellIdentifier = @"Cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UICollectionViewCell alloc] init];
    }

    NSString *url = [self.instagramPhotos objectAtIndex:indexPath.row];

    // get an image view from URL
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];

    UIImageView *viewWithPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,86,86)];
    viewWithPhoto.image = [UIImage imageWithData: imageData];

    [cell.contentView addSubview:viewWithPhoto];
    
    return cell;
}

#pragma mark Collection view delegate methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *url = [self.instagramPhotos objectAtIndex:indexPath.item];
   // [self.delegate didGetUrl:url]; //pass URL back to AddSBItemViewController
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
    
    UIImage *imageToSend = [UIImage imageWithData: imageData];
      
    [self.delegate didGetImage:imageToSend];
    
    [self.navigationController pushViewController:self.croppingView animated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeMake(86,86);
    return itemSize;
}

@end
