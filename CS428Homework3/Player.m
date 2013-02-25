//
//  Player.m
//  CS428Homework3
//
//  Created by Nicholas Otter on 2/2/13.
//  Copyright (c) 2013 otternq. All rights reserved.
//

#import "Player.h"
#import "AreaObject.h"

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

- (BOOL) addToInventory:(AreaObject *)item {
    
    if ([self.inventory count] + 1 <= self.maxInventoryCount) {
        [self.inventory addObject:item];
        return TRUE;
    }
    
    return FALSE;
}

- (void) showInventory {
    
    if ([self.inventory count] > 0) {
        
        printf("Your inventory contains:\n");
        
        for (AreaObject *tempObj in self.inventory) {
            printf("\t%s\n", [tempObj.title UTF8String]);
        }
        
    } else {
        printf("Your inventory is empty");
    }
    
}

- (void) lookAround:(Area **)area {

    //print the area description
    printf("%s\n\n", [[*area description] UTF8String]);
    
    //are there objects in the area
    if ([[*area objects] count] > 0) {//yes there are objects
        
        printf("You see the following objects:\n");
        
        //print out each object
        for (AreaObject *object in [*area objects]) {
            printf("\t%s\n", [[object title] UTF8String]);
        }
        
    } else {//there are no objects
        
        printf("There are no objects in the area");
        
    }
    
    printf("\n");
    
    if ([[*area otherArea] count] > 0) {
        
        printf("You can go to the following areas:\n");
        
        for (NSDictionary *areaDic in [*area otherArea]) {
            
            printf("\t%s\n",[[areaDic objectForKey:@"goto"] UTF8String]);
            
        }
        
    } else {
        printf("There is nowhere else to go");
    }
    
    printf("\n");
}

- (BOOL) inspectObject: (NSString *) objectName inArea:(Area **)area {
    
    //are there objects in the area
    if ([[*area objects] count] > 0) {//yes there are objects
        
        //iterate through the objects in the area and look for the requested one
        for (AreaObject * obj in [*area objects]) {
            
            //is this the element you are looking for? 
            if ( [[obj title] isEqualToString:objectName] == TRUE ) {
                
                printf("Object: %s\n", [[obj title] UTF8String]);
                printf("\tDescription: %s\n", [[obj description] UTF8String]);
                
                if ([obj canTake] == 0) {
                    printf("\tCan be picked up\n");
                } else {
                    printf("\tCannot be picked up\n");
                }
                
                return TRUE;
            }
            
        }
        
        printf("No object `%s` in Area\n", [objectName UTF8String]);
        
        return FALSE;
        
    } else {
        
        printf("No objects in Area\n");
        
        return FALSE;
    }
    
}

@end
