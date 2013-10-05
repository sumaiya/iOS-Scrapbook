//
//  SBDatabase.h
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 10/4/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBItem.h"
#import <sqlite3.h>

@interface SBDatabase : NSObject

+ (void)createEditableCopyOfDatabaseIfNeeded;
+ (void)initDatabase;
+ (NSMutableArray *)fetchAllSBItems;
+ (void)saveSBItemWithURL:(NSString *)url andTitle:(NSString *)title andOwner:(NSString *)photog;
+ (void)deleteSBItem:(int)rowid;
+ (void)cleanUpDatabaseForQuit;

@end
