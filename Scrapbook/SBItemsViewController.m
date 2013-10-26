//
//  SBItemsViewController.m
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 9/26/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import "SBItemsViewController.h"
#import "SBDatabase.h"
#import "SBAppDelegate.h"

@interface SBItemsViewController ()

@end

@implementation SBItemsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        self.sbItems = [SBDatabase fetchAllSBItems];
        
        // register the type of view to create for a table cell
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
                
        //create the tab bar controller object
        self.tabBarController = [[UITabBarController alloc] init];
        
        //create the first view controller
        self.instagramView = [[InstagramViewController alloc] initWithNibName:@"InstagramViewController" bundle:nil];
        [self.instagramView.view setFrame:[[UIScreen mainScreen] bounds]];
        //this is where we set the main (instagram) view's representation on the tab bar
        self.instagramView.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Instagram" image:[UIImage imageNamed:@"41-picture-frame.png"] tag:1];
        
        //create the second view controller
        self.flickrView = [[FlickrViewController alloc] initWithNibName:@"FlickrViewController" bundle:nil];
        [self.flickrView.view setFrame:[[UIScreen mainScreen] bounds]];
        
        //this is where we set the flickr view's representation on the tab bar
        self.flickrView.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Flickr" image:[UIImage imageNamed:@"121-landscape.png"] tag:2];
        
        //set up camera view controller
        self.cameraView = [[CameraViewController alloc] init];
        [self.cameraView setup];
        self.cameraView.photoReel.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Photos" image:[UIImage imageNamed:@"46-movie-2.png"] tag:3];
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.cameraView.camera.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Camera" image:[UIImage imageNamed:@"86-camera.png"] tag:4];
            [self.tabBarController setViewControllers:[NSArray arrayWithObjects:self.instagramView, self.flickrView, self.cameraView.photoReel, self.cameraView.camera, nil] animated:YES];
        }
        //add the viewcontrollers to the tab bar
        else {
            [self.tabBarController setViewControllers:[NSArray arrayWithObjects:self.instagramView, self.flickrView, self.cameraView.photoReel, nil] animated:YES];
        }
       
        // initialize the sb item detail view controller
        self.sbItemDetailViewController = [[SBItemDetailViewController alloc] initWithNibName:@"SBItemDetailViewController" bundle:nil];
    }
    return self;
}

- (void)addButtonPressed
{
    [self.navigationController pushViewController:self.tabBarController animated:YES];
}

- (void)viewDidLoad
{
    [self refreshData];
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)refreshData {
    self.sbItems = [SBDatabase fetchAllSBItems];
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.sbItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // dequeueReusableCellWithIdentifier:forIndexPath asks the table view for recyclable cell. If one is unavailable, a new cell of the type previously registered is created and returned
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    SBItem *temp = [self.sbItems objectAtIndex:indexPath.row];
    
    //set image and text
    cell.imageView.image = temp.imageToDisplay;
    [[cell textLabel] setText:[NSString stringWithFormat:@" %@", temp.title]];
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
            // Delete the row from the data source

        [SBDatabase deleteSBItem:[[self.sbItems objectAtIndex:indexPath.row] rowid]];
        self.sbItems = [SBDatabase fetchAllSBItems];
        
        // When this next line is executed, the data has to agree with the changes this line is performing on the table view
        // if the data doesn't agree, the app falls all over itself and dies
        // that's why we remove the object from the contacts first
        // if you don't believe me, try reversing these two lines... just go ahead and try
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
 
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    [self refreshData];
  //  [self.tableView reloadData]; //COMMENT BACK IN?
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SBItem *temp = [self.sbItems objectAtIndex:indexPath.row];
    
    /* Interesting lesson here.
     * Technically, we've initialized the contactDetailViewController, right?
     * So you'd THINK the textFields in the nib file would already be loaded, but iOS is lazy
     * So the view is only loaded from the nib at the moment it's placed on the screen.
     * This means that if we reversed these next two lines, the very first time we tap on a contact
     * the contact detail view won't show us the data, but all subsequent contact taps WILL show us the data
     * to see what I mean, try reversing these lines and running the app
     */
    
    [self.navigationController pushViewController:self.sbItemDetailViewController animated:YES];
    
    [self.sbItemDetailViewController setFieldsWithImage:temp.imageToDisplay andTitle:temp.title andOwner:temp.owner];
    
}

@end
