//
//  Player.h
//  CS428Homework3
//
//  Created by Nicholas Otter on 2/2/13.
//  Copyright (c) 2013 otternq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Area.h"

@interface Player : NSObject

@property NSString * name;
@property long maxInventoryCount;
@property NSMutableSet * inventory;


- (BOOL) addToInventory: (NSString *) item;
- (void) lookAround: (Area **) area;

@end
