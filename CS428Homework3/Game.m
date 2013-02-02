//
//  Game.m
//  CS428Homework3
//
//  Created by Nicholas Otter on 2/1/13.
//  Copyright (c) 2013 otternq. All rights reserved.
//

#import "Game.h"
#import "SBJson.h"
#import "Area.h"

@implementation Game

- (id) init {
    self = [super init];
    
    if (self) {
        menu = [NSArray arrayWithObjects: @"help", @"exit", @"look", nil];
        
        //Get Access to STDIN
        input = [NSFileHandle fileHandleWithStandardInput];
    }
    
    return self;
}

-(void) gameLoop {
    
    //load the game into and set the first area
    [self loadArea:[self getIntro]];
    
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
        
    } else if ([*command isEqualToString:@"look"]) {
        [self lookAround];
    } else if([*command isEqualToString:@"help"]) {
        
        printf("Available Commands:\n");
        
        for ( NSString *availableCommand in menu ) {
            printf("\t%s\n", [availableCommand UTF8String]);
        }
        
    } else {
        
        printf("Unrecognised input\n");
        
    }
    
    return TRUE;
}

-(NSString *) getIntro {
    
    NSFileHandle *tempFile = [NSFileHandle fileHandleForReadingAtPath:@"/Users/otternq/Documents/AppDev/CS428Homework3/CS428Homework3/intro.json"];
    NSData *tempData = [tempFile readDataToEndOfFile];
    NSString *jsonString = [[NSString alloc] initWithData:tempData encoding:NSUTF8StringEncoding];
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSDictionary *json = [jsonParser objectWithString:jsonString];
    
    printf("%s\n\n", [[json objectForKey:@"intro"] UTF8String]);
    return [json objectForKey:@"firstArea"];
    
}

-(void) loadArea:(NSString *)area {
    
    NSString *fileName = [NSString stringWithFormat: @"/Users/otternq/Documents/AppDev/CS428Homework3/CS428Homework3/%@.json", area];
    
    NSFileHandle *tempFile = [NSFileHandle fileHandleForReadingAtPath:fileName];
    NSData *tempData = [tempFile readDataToEndOfFile];
    NSString *jsonString = [[NSString alloc] initWithData:tempData encoding:NSUTF8StringEncoding];
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSDictionary *json = [jsonParser objectWithString:jsonString];
    
    NSString *tempDescription = [json objectForKey:@"description"];
    
    currentArea = [[Area alloc] initWithDescription:tempDescription andWithObjects: [json objectForKey:@"objects"]];
    
    
}

- (void) lookAround {
    
    printf("%s\n\n", [[currentArea getDescription] UTF8String]);
    
    //are there objects in the area
    if ([[currentArea getObjects] count] > 0) {
        
        printf("You see the following objects:\n");
    
        for (NSString * object in [currentArea getObjects]) {
            printf("\t%s\n", [object UTF8String]);
        }
    } else {//there are no objects
        
        printf("There are no objects in the area");
        
    }
    
    printf("\n");
    
    
}


@end
