//
//  FlickrTagSearcher.h
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 9/28/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrTagSearcher : NSObject
@property NSURLConnection* connection;
@property NSMutableData* data;
@property id target; // want this class to be general purpose
@property SEL action; //

- (id)initWithTagQuery:(NSString *)query andTarget:(id)incomingTarget andAction:(SEL)incomingAction;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end
