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
        
        NSFileManager *fm = [[NSFileManager alloc] init];
        
        char input[150] = {0};
        NSString *dir = NULL;
        
        BOOL isDir = FALSE;
        
        while (!isDir) {
            
            printf("Enter the location of the story: ");
            scanf("%s", input);
            
            dir = [NSString stringWithUTF8String:input];
            
            BOOL exists = [fm fileExistsAtPath:dir isDirectory:&isDir];
            
            if (!exists) {
                
                printf("Could not find the specified directory: %s\n", [dir UTF8String]);
            }
        }
        
        //@"/Users/otternq/Documents/AppDev/CS428Homework3/CS428Homework3";
        
        Game *game = [[Game alloc] initWithDir:dir];
        
        [game gameLoop];
        
    }
    return 0;
}

