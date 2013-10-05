//
//  SBItem.h
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 9/26/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBItem : NSObject

@property int rowid;
@property NSString *url;
@property NSString *title;
@property NSString *owner;

-(id)initWithURL:(NSString *)url andTitle:(NSString *)titleText andOwner:(NSString *)ownerName andId:(int)rid;

@end
