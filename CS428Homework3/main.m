//
//  main.m
//  CS428Homework3
//
//  Created by Nicholas Otter on 2/1/13.
//  Copyright (c) 2013 otternq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"
#import "SBJson.h"



int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSString *dir = @"/Users/otternq/Documents/AppDev/CS428Homework3/CS428Homework3";
        
        Game *game = [[Game alloc] initWithDir:dir];
        
        [game gameLoop];
        
    }
    return 0;
}

