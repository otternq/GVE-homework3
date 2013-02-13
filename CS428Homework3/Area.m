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
        self.objects = [[NSMutableSet alloc] init];
        
        for (NSDictionary * tempObj in tempObjects) {
            [self.objects addObject:[[AreaObject alloc] initFromDictionary:tempObj]];
        }
    }
    
    return self;
}

@end
