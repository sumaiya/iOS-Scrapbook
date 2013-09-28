//
//  SBPhotosViewController.m
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 9/27/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import "SBPhotosViewController.h"

@interface SBPhotosViewController ()

@end

@implementation SBPhotosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.instagramPhotos = [[NSMutableArray alloc] initWithCapacity:0];
        self.flickrPhotos = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}



- (void)viewDidLoad
{
    // register the type of view to create for a table cell
    [self.photosTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.title = @"Select Photo";
    
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
    [self.queryField resignFirstResponder];
    
    // clear old photos
    [self.instagramPhotos removeAllObjects];
    [self.flickrPhotos removeAllObjects];
    
    self.instagramSearcher = [[InstagramTagSearcher alloc] initWithTagQuery:[self queryField].text andTarget:self andAction:@selector(handleInstagramData:)];
    
    self.flickrSearcher = [[FlickrTagSearcher alloc] initWithTagQuery:[self queryField].text andTarget:self andAction:@selector(handleFlickrData:)];
    
    return TRUE;
}

- (void)handleInstagramData:(NSMutableDictionary *)data {
    // array of photo dictionaries
    NSArray *photos = [data objectForKey:@"data"];
    // limit to 10 photos
    if ([photos count] > 10) {
        NSArray* subset = [photos subarrayWithRange:NSMakeRange(0, 10)];
        photos = subset;
    }
    
    for (NSMutableDictionary *photo in photos) {
        
        NSString* photoUrl = [[[photo objectForKey:@"images"] objectForKey:@"thumbnail"] objectForKey:@"url"];
        // add photo URLS to self.instagramPhotos
        [self.instagramPhotos addObject:photoUrl];
    }
    [self.photosTableView reloadData];
}

- (void)handleFlickrData:(NSMutableDictionary *)data {
    NSMutableArray *photos = [[data objectForKey:@"photos"] objectForKey:@"photo"];
    // array of photo dictionaries
    
    for (NSMutableDictionary *photo in photos) {
        
        NSString *photoUrl = [NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_q.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        // add photo URLS to self.instagramPhotos
        [self.flickrPhotos addObject:photoUrl];
    }
    [self.photosTableView reloadData];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section == 0 ? @"Instagram Results" : @"Flickr Results";
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? [self.instagramPhotos count] : [self.flickrPhotos count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // dequeueReusableCellWithIdentifier:forIndexPath asks the table view for recyclable cell. If one is unavailable, a new cell of the type previously registered is created and returned
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSMutableArray* photos = indexPath.section == 0 ? self.instagramPhotos : self.flickrPhotos;
    
    NSString *url = [photos objectAtIndex:indexPath.row];
    
    // get an image view from URL
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
    
    UIImageView *viewWithPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(70,0,50,50)];
    viewWithPhoto.image = [UIImage imageWithData: imageData];
    
    //    viewWithPhoto.center = CGPointMake(cell.contentView.bounds.size.width/2,cell.contentView.bounds.size.height/2);
    [cell.contentView addSubview:viewWithPhoto];
    //    cell.imageView.image = viewWithPhoto.image;
    //[UIImage imageWithData: imageData];
    //    cell.imageView.sizeToFit;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// open a alert with an OK and cancel button
    NSMutableArray* photos = indexPath.section == 0 ? self.instagramPhotos : self.flickrPhotos;
    NSString *url = [photos objectAtIndex:indexPath.row];
    [self.delegate photosViewController:self didGetUrl:url]; //pass URL back to ADDSBItemViewController
    [self.navigationController popViewControllerAnimated:YES];
}
@end
