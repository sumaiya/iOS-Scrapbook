//
//  SBDatabase.m
//  Scrapbook
//
//  Created by Sumaiya Hashmi on 10/4/13.
//  Copyright (c) 2013 Sumaiya Hashmi. All rights reserved.
//

#import "SBDatabase.h"
#import <sqlite3.h>


@implementation SBDatabase

static sqlite3 *db;

static sqlite3_stmt *createSBItems;
static sqlite3_stmt *fetchSBItems;
static sqlite3_stmt *insertSBItem;
static sqlite3_stmt *deleteSBItem;

+ (void)createEditableCopyOfDatabaseIfNeeded {
    BOOL success;
    
    // look for an existing SBItems database
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentDirectory stringByAppendingPathComponent:@"sbItems.sql"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return;
    
    // if failed to find one, copy the empty SBItems database into the location
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"sbItems.sql"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"FAILED to create writable database file with message, '%@'.", [error localizedDescription]);
    }
}

+ (void)initDatabase {
    // create the statement strings
    const char *createSBItemsString = "CREATE TABLE IF NOT EXISTS sbitems (rowid INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT, title TEXT, owner TEXT)";
    const char *fetchSBItemsString = "SELECT * FROM sbitems";
    const char *insertSBItemString = "INSERT INTO sbitems (url, title, owner) VALUES (?, ?, ?)";
    const char *deleteSBItemString = "DELETE FROM sbitems WHERE rowid=?";
    
    // create the path to the database
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"sbitems.sql"];
    
    // open the database connection
    if (sqlite3_open([path UTF8String], &db)) {
        NSLog(@"ERROR opening the db");
    }
    
    
    
    int success;
    
    //init table statement
    if (sqlite3_prepare_v2(db, createSBItemsString, -1, &createSBItems, NULL) != SQLITE_OK) {
        NSLog(@"Failed to prepare sbitems create table statement");
    }
    
    // execute the table creation statement
    success = sqlite3_step(createSBItems);
    sqlite3_reset(createSBItems);
    if (success != SQLITE_DONE) {
        NSLog(@"ERROR: failed to create sbitems table");
    }
    
    //init retrieval statement
    if (sqlite3_prepare_v2(db, fetchSBItemsString, -1, &fetchSBItems, NULL) != SQLITE_OK) {
        NSLog(@"ERROR: failed to prepare sbitem fetching statement");
    }
    
    //init insertion statement
    if (sqlite3_prepare_v2(db, insertSBItemString, -1, &insertSBItem, NULL) != SQLITE_OK) {
        NSLog(@"ERROR: failed to prepare sbitem inserting statement");
    }
    
    // init deletion statement
    if (sqlite3_prepare_v2(db, deleteSBItemString, -1, &deleteSBItem, NULL) != SQLITE_OK) {
        NSLog(@"ERROR: failed to prepare sbitem deleting statement");
    }
}

+ (NSMutableArray *)fetchAllSBItems
{
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:0];
    
    
    
    while (sqlite3_step(fetchSBItems) == SQLITE_ROW) {
        
        // query columns from fetch statement
        char *urlChars = (char *) sqlite3_column_text(fetchSBItems, 1);
        char *titleChars = (char *) sqlite3_column_text(fetchSBItems, 2);
        char *ownerChars = (char *) sqlite3_column_text(fetchSBItems, 3);
        // convert to NSStrings
        NSString *tempUrl = [NSString stringWithUTF8String:urlChars];
        NSString *tempTitle = [NSString stringWithUTF8String:titleChars];
        NSString *tempOwner = [NSString stringWithUTF8String:ownerChars];
        
        //create SBItem object, notice the query for the row id
        SBItem *temp = [[SBItem alloc] initWithURL:tempUrl andTitle:tempTitle andOwner:tempOwner andId:sqlite3_column_int(fetchSBItems, 0)];
        [ret addObject:temp];
        
    }
    
    sqlite3_reset(fetchSBItems);
    return ret;
}

+ (void)saveSBItemWithURL:(NSString *)url andTitle:(NSString *)title andOwner:(NSString *)photog
{
    // bind data to the statement
    sqlite3_bind_text(insertSBItem, 1, [url UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertSBItem, 2, [title UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(insertSBItem, 3, [photog UTF8String], -1, SQLITE_TRANSIENT);
    
    int success = sqlite3_step(insertSBItem);
    sqlite3_reset(insertSBItem);
    if (success != SQLITE_DONE) {
        NSLog(@"ERROR: failed to insert sbitem");
    }
}

+ (void)deleteSBItem:(int)rowid
{
    // bind the row id, step the statement, reset the statement, check for error... EASY
    sqlite3_bind_int(deleteSBItem, 1, rowid);
    int success = sqlite3_step(deleteSBItem);
    sqlite3_reset(deleteSBItem);
    if (success != SQLITE_DONE) {
        NSLog(@"ERROR: failed to delete sbitem");
    }
}

+ (void)cleanUpDatabaseForQuit
{
    // finalize frees the compiled statements, close closes the database connection
    sqlite3_finalize(fetchSBItems);
    sqlite3_finalize(insertSBItem);
    sqlite3_finalize(deleteSBItem);
    sqlite3_finalize(createSBItems);
    sqlite3_close(db);
}

@end
