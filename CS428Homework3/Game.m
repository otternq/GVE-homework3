//
//  Game.m
//  CS428Homework3
//
//  Created by Nicholas Otter on 2/1/13.
//  Copyright (c) 2013 otternq. All rights reserved.
//

#import "Game.h"

@implementation Game

    - (id) init {
        self = [super init];
        
        if (self) {
            menu = [NSArray arrayWithObjects: @"help", @"exit", nil];
            
            //Get Access to STDIN
            input = [NSFileHandle fileHandleWithStandardInput];
        }
        
        return self;
    }

    -(void) gameLoop {
        
        printf("Welcome to the World!\n");
        
        //the command given by the user
        NSString *inputString;
        
        
        //main game loop
        do {
            
            printf("waiting for command: ");
            
            //get the command from the user, stored to inputString
            [self getCommand:&inputString];
            
        } while( [self splitCommands: &inputString] );//execute the loop until the user types a command that exits
        
        
        printf("Exiting Game. Good Bye.\n");
        
    }

    -(NSArray *) getMenu {
        
        return menu;
        
    }

    -(BOOL) getCommand : (NSString **) command{
    
        //get what is in STDIN
        inputData = [input availableData];
        
        //place the STDIN data into a string
        *command = [[NSString alloc] initWithData:inputData encoding:NSUTF8StringEncoding];
        
        //remove new line character
        *command = [*command stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        return TRUE;
    }

    -(BOOL) splitCommands: (NSString **)command {
        
        if ([*command isEqualToString:@"exit"]) {
            return FALSE;
        } else {
            
            if ([*command isNotEqualTo:@"help"]) {
                printf("Unrecognised input\n");
            }
            
            printf("Available Commands:\n");
            
            for ( NSString *availableCommand in menu ) {
                printf("\t%s\n", [availableCommand UTF8String]);
            }
            
        }
        
        return TRUE;
    }


@end
