//
//  Player.m
//  CS428Homework3
//
//  Created by Nicholas Otter on 2/2/13.
//  Copyright (c) 2013 otternq. All rights reserved.
//

#import "Player.h"

@implementation Player
@synthesize name = _name;
@synthesize maxInventoryCount = _maxInventoryCount;
@synthesize inventory = _inventory;

- (id) init {
    self = [super init];
    
    if (self) {
        self.maxInventoryCount = 7;
        self.inventory = [[NSMutableSet alloc] initWithCapacity:self.maxInventoryCount];
    }
    
    return self;
}

- (BOOL) addToInventory:(NSString *)item {
    
    if ([self.inventory count] + 1 <= self.maxInventoryCount) {
        [self.inventory addObject:item];
        return TRUE;
    }
    
    return FALSE;
}

- (void) lookAround:(Area **)area {

    //print the area description
    printf("%s\n\n", [[*area description] UTF8String]);
    
    //are there objects in the area
    if ([[*area objects] count] > 0) {//yes there are objects
        
        printf("You see the following objects:\n");
        
        //print out each object
        for (NSString * object in [*area objects]) {
            printf("\t%s\n", [object UTF8String]);
        }
    } else {//there are no objects
        
        printf("There are no objects in the area");
        
    }
    
    printf("\n");
}

@end
