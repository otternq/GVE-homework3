//
//  main.m
//  CS428Homework3
//
//  Created by Nicholas Otter on 2/1/13.
//  Copyright (c) 2013 otternq. All rights reserved.
//

#import <Foundation/Foundation.h>


NSArray *menu() {
    
    return [NSArray arrayWithObjects: @"help", @"exit", nil];
    
}

BOOL getCommand(NSFileHandle **input, NSString **command) {
    
    //get access to STDIN
    *input = [NSFileHandle fileHandleWithStandardInput];
    
    NSData *inputData;
    
    //get what is in STDIN
    inputData = [*input availableData];
    
    //place the STDIN data into a string
    *command = [[NSString alloc] initWithData:inputData encoding:NSUTF8StringEncoding];
    
    //remove new line character
    *command = [*command stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];

    return TRUE;
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        NSLog(@"Welcome to the World!");
        
        NSFileHandle * input;
        NSString *inputString;
        
        
        //main game loop
        do {
            NSLog(@"waiting for command");
            if (getCommand(&input, &inputString)) {
                
                if ([inputString isEqualToString:@"exit"]) {
                    break;
                } else {
                    
                    if ([inputString isNotEqualTo:@"help"]) {
                        NSLog(@"Unrecognised input");
                    }
                    
                    NSLog(@"Available Commands:");
                    
                    for (NSString *availableCommand in menu()) {
                        NSLog(@"%@", availableCommand);
                    }
                    
                }
                
            }
            
            
        } while(true);
            
        
        NSLog(@"Exiting Game");
        
    }
    return 0;
}

