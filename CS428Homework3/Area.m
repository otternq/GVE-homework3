//
//  Area.m
//  CS428Homework3
//
//  Created by Nicholas Otter on 2/1/13.
//  Copyright (c) 2013 otternq. All rights reserved.
//

#import "Area.h"

@implementation Area

- (id) initWithDescription:(NSString *)tempDescription andWithObjects:(NSArray *)tempObj {
    if (self = [super init])
    {
        description = tempDescription;
        objects = tempObj;
    }
    
    return self;
}

- (NSString *) getDescription {
    return description;
}

- (NSArray *) getObjects {
    return objects;
}

@end
