//
//  TwitterStreamer.m
//  BasicTwitterPoster
//
//  Created by Patrick McNally on 10/23/13.
//  Copyright (c) 2013 Pomona College. All rights reserved.
//

#import "TwitterStreamer.h"

@implementation TwitterStreamer

- (void)requestAccounts
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        ACAccountStore *store = [[ACAccountStore alloc] init];
        
        ACAccountType *twitterAccountType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        // async store an account for later
        [store requestAccessToAccountsWithType:twitterAccountType options:NULL completion:^(BOOL granted, NSError *error) {
            if (granted) {
                NSArray *twitterAccounts = [store accountsWithAccountType:twitterAccountType];
                self.account = [twitterAccounts lastObject];
            }
        }];
    }
}

// start the stream
- (void)startStreamWithQuery:(NSString *)query
{
    if (self.account != nil) {
        // create an SL request
        SLRequest *twitterStreamRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodPOST URL:[NSURL URLWithString:@"https://stream.twitter.com/1.1/statuses/filter.json"] parameters:[NSDictionary dictionaryWithObject:query forKey:@"track"]];
        
        // set the account for that request
        [twitterStreamRequest setAccount:self.account];
        
        // cancel any previous connection
        if (self.connection != nil) {
            [self.connection cancel];
        }
        
        // open a new streaming connection
        self.connection = [[NSURLConnection alloc] initWithRequest:twitterStreamRequest.preparedURLRequest delegate:self startImmediately:YES];
    }
}


// parse any tweets that come across the stream
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSDictionary *tweet = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    // send the tweet to the target with the action
    [self.target performSelector:self.action withObject:tweet];
}

@end
