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


NSString * getStoryLocation();

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSString * dir = getStoryLocation();
        
        if ([dir isEqualToString:@"exit"]) {
            printf("Good Bye!\n\n");
            return 0;
        } else {
            NSLog(@"dir=%@", dir);
        }
        
        //@"/Users/otternq/Documents/AppDev/CS428Homework3/CS428Homework3";
        
        Game *game = [[Game alloc] initWithDir:dir];
        
        [game gameLoop];
        
    }
    return 0;
}

NSString * getStoryLocation() {
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    
    char input[150] = {0};
    NSString *dir = NULL;
    
    BOOL isDir = FALSE;
    
    while (!isDir) {
        
        printf("Enter the location of the story: ");
        scanf("%s", input);
        
        dir = [NSString stringWithUTF8String:input];
        
        if ([dir isEqualToString:@"exit"]) {
            return dir;
        }
        
        BOOL exists = [fm fileExistsAtPath:dir isDirectory:&isDir];
        
        if (!exists) {
            
            printf("Could not find the specified directory: %s\n\n", [dir UTF8String]);
        } else {
            return dir;
        }
    }
    
    return dir;
    
}