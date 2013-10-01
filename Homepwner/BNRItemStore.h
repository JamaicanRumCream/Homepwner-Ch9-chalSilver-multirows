//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Chris Paveglio on 9/18/13.
//  Copyright (c) 2013 none. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;

@interface BNRItemStore : NSObject
{
    NSMutableArray *allItems;
}

+(BNRItemStore *)sharedStore;

-(NSArray *)allItems;
-(BNRItem *)createItem;

-(NSArray *)itemsOver50;
-(NSArray *)itemsUnder50;


@end
