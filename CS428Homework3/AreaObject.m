//
//  AreaObject.m
//  CS428Homework3
//
//  Created by Nicholas Otter on 2/11/13.
//  Copyright (c) 2013 otternq. All rights reserved.
//

#import "AreaObject.h"

@implementation AreaObject

@synthesize title = _title;
@synthesize description = _description;
@synthesize canTake = _canTake;

- (id) initWithDescription:(NSString *)tempTitle andWithDescription:(NSString *)tempDescription andWithCanTake:(NSNumber *)tempCanTake {
    
    if (self = [super init])
    {
    
        self.title = tempTitle;
        self.description = tempDescription;
        self.canTake = tempCanTake;
        
    }
    
    return self;
    
}

- (id) initFromDictionary:(NSDictionary *)tempDictionary {
    
    if (self = [super init]) {
        self.title = [tempDictionary objectForKey:@"title"];
        self.description = [tempDictionary objectForKey:@"description"];
        self.canTake = [tempDictionary objectForKey:@"canTake"];
    }
    
    return self;
}


@end
