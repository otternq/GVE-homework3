//
//  Area.m
//  CS428Homework3
//
//  Created by Nicholas Otter on 2/1/13.
//  Copyright (c) 2013 otternq. All rights reserved.
//

#import "Area.h"

@implementation Area
@synthesize description = _description;
@synthesize objects = _objects;

- (id) initWithDescription:(NSString *)tempDescription andWithObjects:(NSArray *)tempObj {
    if (self = [super init])
    {
        self.description = tempDescription;
        self.objects = tempObj;
    }
    
    return self;
}

@end
