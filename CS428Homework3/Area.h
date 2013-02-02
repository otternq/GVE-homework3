//
//  Area.h
//  CS428Homework3
//
//  Created by Nicholas Otter on 2/1/13.
//  Copyright (c) 2013 otternq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Area : NSObject {
    NSString * description;
    NSDictionary * objects;
}

- (id) initWithDescription: (NSString *) tempDescription andWithObjects: (NSArray *)tempObj;
- (NSString *) getDescription;
- (NSArray *) getObjects;

@end
