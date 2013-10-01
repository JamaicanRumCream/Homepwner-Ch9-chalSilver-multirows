//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Chris Paveglio on 9/18/13.
//  Copyright (c) 2013 none. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation BNRItemStore

+(BNRItemStore *)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    return sharedStore;
}


//override this so unintended alloc's don't bypass singleton
+(id)allocWithZone:(NSZone *)zone
{
    return [self sharedStore];
}

-(id)init
{
    self = [super init];
    if (self) {
        allItems = [[NSMutableArray alloc] init];
    }
    return self;
}


-(NSArray *)allItems
{
    return allItems;
}


-(BNRItem *)createItem
{
    BNRItem *p = [BNRItem randomItem];
    [allItems addObject:p];
    return p;
}



//make a return method to spit out items that have certain attributes
//such as value <> 50 etc
//assume that we know that these data types are needed and understood
//not going to make it completely flexible

-(NSArray *)itemsOver50
{
  NSMutableArray *temp = [NSMutableArray array];
  for (int i = 0; i < [allItems count]; i++)
      {
          BNRItem *b = [allItems objectAtIndex:i];
          if (b.valueInDollars > 50)
              [temp addObject:[allItems objectAtIndex:i]];
      }
  return temp;
}

-(NSArray *)itemsUnder50
{
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < [allItems count]; i++)
    {
        BNRItem *b = [allItems objectAtIndex:i];
        if (b.valueInDollars < 50)
            [temp addObject:[allItems objectAtIndex:i]];
    }
    return temp;
}


@end
