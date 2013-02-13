//
//  AreaObject.h
//  CS428Homework3
//
//  Created by Nicholas Otter on 2/11/13.
//  Copyright (c) 2013 otternq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaObject : NSObject

@property NSString *title;
@property NSString *description;
@property NSNumber *canTake;

- (id) initWithDescription: (NSString *) tempTitle andWithDescription: (NSString *)tempDescription andWithCanTake: (NSNumber *) tempCanTake;

- (id) initFromDictionary: (NSDictionary *) tempDictionary;

@end
