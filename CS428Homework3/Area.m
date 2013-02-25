//
//  Area.m
//  CS428Homework3
//
//  Created by Nicholas Otter on 2/1/13.
//  Copyright (c) 2013 otternq. All rights reserved.
//

#import "Area.h"
#import "AreaObject.h"

@implementation Area
@synthesize description = _description;
@synthesize objects = _objects;
@synthesize otherArea = _otherArea;

- (id) initWithDescription: (NSString *)tempDescription {
    if (self = [super init])
    {
        self.description = tempDescription;
    }
    
    return self;
}

- (id) initWithDescription:(NSString *)tempDescription andWithObjects:(NSArray *)tempObjects {
    
    if (self = [self initWithDescription:tempDescription])
    {
        self.objects = [[NSMutableArray alloc] init];
        
        for (NSDictionary * tempObj in tempObjects) {
            [self.objects addObject:[[AreaObject alloc] initFromDictionary:tempObj]];
        }
    }
    
    return self;
}

- (id) initWithDescription:(NSString *)tempDescription andWithObjects:(NSArray *)tempObj andWithAreas:(NSMutableArray *)tempArea {
    
    if (self = [self initWithDescription: tempDescription andWithObjects:tempObj])
    {
        self.otherArea = tempArea;
    }
                
    return self;
    
}

- (AreaObject *) removeObjects:(NSString *)objectName {
    
    if ([self.objects count] > 0) {
        
        NSUInteger i = 0;
        
        for (AreaObject * tempObj in self.objects) {//brute force search through the objects
            
            if ( [tempObj.title isEqualToString:objectName] ) {//found the object
                
                if (tempObj.canTake == TRUE) {
                
                    AreaObject * tempObject = tempObj;
                    
                    [self.objects removeObjectAtIndex:i];
                    
                    return tempObject;
                    
                } else {
                    return NULL;
                }
                
            }
            
            i++;
            
        }//END foreach objects
        
        //unable to find the object
        printf("Object `%s` not found\n", [objectName UTF8String]);
        
    } else {
        printf("No objects in area\n");
    }
    
    return NULL;
    
}

@end
