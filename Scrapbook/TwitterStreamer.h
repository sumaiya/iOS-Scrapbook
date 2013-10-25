//
//  TwitterStreamer.h
//  BasicTwitterPoster
//
//  Created by Patrick McNally on 10/23/13.
//  Copyright (c) 2013 Pomona College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface TwitterStreamer : NSObject

@property NSURLConnection *connection;
@property ACAccount *account;
@property id target;
@property SEL action;

- (void)requestAccounts;
- (void)startStreamWithQuery:(NSString *)query;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;

@end
