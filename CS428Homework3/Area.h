//
//  Area.h
//  CS428Homework3
//
//  Created by Nicholas Otter on 2/1/13.
//  Copyright (c) 2013 otternq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AreaObject.h"

@interface Area : NSObject
@property NSString * description;
@property NSMutableArray * objects;
@property NSMutableArray * otherArea;

- (id) initWithDescription: (NSString *) tempDescription;
- (id) initWithDescription: (NSString *) tempDescription andWithObjects: (NSArray *)tempObj;
- (id) initWithDescription: (NSString *) tempDescription andWithObjects: (NSArray *) tempObj andWithAreas:(NSArray *) tempArea;

- (AreaObject *) removeObjects: (NSString *) objectName;

@end
