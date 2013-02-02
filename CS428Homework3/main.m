//
//  main.m
//  CS428Homework3
//
//  Created by Nicholas Otter on 2/1/13.
//  Copyright (c) 2013 otternq. All rights reserved.
//

#import <Foundation/Foundation.h>


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // insert code here...
        NSLog(@"Welcome to the World!");
        
        //get access to STDIN
        NSFileHandle *input = [NSFileHandle fileHandleWithStandardInput];
        NSData *inputData;
        NSString *inputString;
        
        NSString *exitString = @"exit";
        
        do {
            //get what is in STDIN
            inputData = [input availableData];
            
            //place the STDIN data into a string
            inputString = [[NSString alloc] initWithData:inputData encoding:NSUTF8StringEncoding];
            
            //remove new line character
            inputString = [inputString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
            
            //inputString = @"exit";
            NSLog(@"%@", inputString);
            
        } while ([inputString isNotEqualTo:exitString]);
        
        NSLog(@"Exiting Game");
        
    }
    return 0;
}

