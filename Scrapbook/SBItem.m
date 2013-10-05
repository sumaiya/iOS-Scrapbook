//
//  SBItem.m
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 9/26/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import "SBItem.h"

@implementation SBItem

-(id)initWithURL:(NSString *)photoUrl andTitle:(NSString *)titleText andOwner:(NSString *)ownerName andId:(int)rid
{
    self = [super init];
    self.url = photoUrl;
    self.title = titleText;
    self.owner = ownerName;
    self.rowid = rid;
    return self;
}
@end
