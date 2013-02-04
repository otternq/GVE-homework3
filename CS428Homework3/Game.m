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

@synthesize currentArea = _currentArea;

- (id) init {
    self = [super init];
    
    if (self) {
        self.player = [[Player alloc] init];
        
        self.menu = [NSArray arrayWithObjects: @"help", @"exit", @"look", @"inspect <object>", nil];
        
        //Get Access to STDIN
        self.input = [NSFileHandle fileHandleWithStandardInput];
        
        //set the current area variable
        self.currentArea = nil;
    }
    
    return self;
}

-(void) gameLoop {
    
    NSString * area = [self getIntro];
    
    //load the game into and set the first area
    [self loadArea:area];
    
    //the command given by the user
    NSString *inputString;
    
    
    //main game loop
    do {
        
        printf("waiting for command: ");
        
        //get the command from the user, stored to inputString
        [self getCommand:&inputString];
        
        printf("\n");
        
    } while( [self splitCommands: &inputString] );//execute the loop until the user types a command that exits
    
    
    printf("Exiting Game. Good Bye.\n");
    
}

-(NSArray *) getMenu {
    
    return self.menu;
    
}

-(BOOL) getCommand : (NSString **) command{

    //get what is in STDIN
    self.inputData = [self.input availableData];
    
    //place the STDIN data into a string
    *command = [[NSString alloc] initWithData:self.inputData encoding:NSUTF8StringEncoding];
    
    //remove new line character
    *command = [*command stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];

    return TRUE;
}

-(BOOL) splitCommands: (NSString **)command {
    
    if ([*command isEqualToString:@"exit"]) {
        
        return FALSE;
        
    } else if ([*command isEqualToString:@"look"]) {
        Area * tempArea = self.currentArea;
        
        [self.player lookAround:&tempArea];
        
    } else if([*command isEqualToString:@"help"]) {
        
        printf("Available Commands:\n");
        
        for ( NSString *availableCommand in self.menu ) {
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

    //specify the file
    NSString *fileName = [NSString stringWithFormat: @"/Users/otternq/Documents/AppDev/CS428Homework3/CS428Homework3/%@.json", area];
    
    //connect to the file
    NSFileHandle *tempFile = [NSFileHandle fileHandleForReadingAtPath:fileName];
    
    //get data from the file
    NSData *tempData = [tempFile readDataToEndOfFile];
    
    //access the data as a string
    NSString *jsonString = [[NSString alloc] initWithData:tempData encoding:NSUTF8StringEncoding];
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    
    //parse the string into a dictionary
    NSDictionary *json = [jsonParser objectWithString:jsonString];
    
    //retrieve a description from the dictionary
    NSString *tempDescription = [json objectForKey:@"description"];
    
    self.currentArea = [[Area alloc] initWithDescription:tempDescription andWithObjects: [json objectForKey:@"objects"]];
    
    
    
}



@end
