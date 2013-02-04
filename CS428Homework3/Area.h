//
//  Area.h
//  CS428Homework3
//
//  Created by Nicholas Otter on 2/1/13.
//  Copyright (c) 2013 otternq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Area : NSObject
@property NSString * description;
@property NSArray * objects;


- (id) initWithDescription: (NSString *) tempDescription andWithObjects: (NSArray *)tempObj;

@end
