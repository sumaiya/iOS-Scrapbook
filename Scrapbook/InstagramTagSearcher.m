//
//  InstagramTagSearcher.m
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 9/28/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InstagramTagSearcher.h"

@implementation InstagramTagSearcher

- (id)initWithTagQuery:(NSString *)query andTarget:(id)incomingTarget andAction:(SEL)incomingAction;
{
    self = [super init];
    // assemble api url, including query
    NSString* url = [NSString stringWithFormat: @"https://api.instagram.com/v1/tags/%@/media/recent?client_id=f202e5f7942a41969c822358c7be8e64", query];
    if (self) {
        self.connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] delegate:self];
        // connect to url
        self.target = incomingTarget;
        self.action = incomingAction;
    }
    
    return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.data = [[NSMutableData alloc] initWithCapacity:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.data appendData:data];
    // collect data from connection
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSMutableDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
    // read self.data JSON into a dictionary

    [self.target performSelector:self.action withObject:dictionary];
    // call action on target with args dictionary
}

@end
