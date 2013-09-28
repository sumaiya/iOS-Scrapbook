//
//  SBItemDetailViewController.h
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 9/26/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBItemDetailViewController : UIViewController


@property IBOutlet UILabel *photoTitle;
@property IBOutlet UILabel *owner;
@property IBOutlet UIImageView *photoView;

- (void)setFieldsWithUrl:(NSString *)newUrl andTitle:(NSString *)newTitle andOwner:(NSString *)newOwner;


@end
