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

- (id) initWithDir: (NSString *) dir {
    self = [super init];
    
    if (self) {
        
        self.dir = dir;
        
        self.player = [[Player alloc] init];
        
        self.menu = [NSArray arrayWithObjects: @"help", @"exit", @"look", @"inspect <object>", @"pick up <object>", @"list inventory", @"go to <area>", @"objectives", nil];
        
        //Get Access to STDIN
        self.input = [NSFileHandle fileHandleWithStandardInput];
        
        //set the current area variable
        self.currentArea = nil;
        
        self.objectives = nil;
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
        
    } while( [self splitCommands: &inputString] && ![self checkWin] );//execute the loop until the user types a command that exits
    
    
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
    
    if ([*command isEqualToString:@"exit"]) {//the command is exit
        
        return FALSE;
        
    } else if ([*command isEqualToString:@"look"]) {//the command is look
        
        Area * tempArea = self.currentArea;
        
        [self.player lookAround:&tempArea];
        
    } else if([*command isEqualToString:@"help"]) {//the command is help
        
        printf("Available Commands:\n");
        
        for ( NSString *availableCommand in self.menu ) {
            printf("\t%s\n", [availableCommand UTF8String]);
        }
        
    } else if ([*command hasPrefix:@"inspect"]) {//the command starts with inspect
        
        NSRange stringRange = NSMakeRange(8, [*command length] - 8);
        NSString *tempObject = [*command substringWithRange:stringRange];
        
        NSLog(@"Inspecting object %@", tempObject);
        
        Area * tempArea = self.currentArea;
        [self.player inspectObject:tempObject inArea:&tempArea];
        
    } else if ( [*command hasPrefix:@"pick up"] ) {//the command started with pick up
        
        NSRange stringRange = NSMakeRange(8, [*command length] - 8);
        NSString *tempObject = [*command substringWithRange:stringRange];
        
        AreaObject *pickupObj = [self.currentArea removeObjects:tempObject];
        
        if (pickupObj != NULL) {
            [self.player addToInventory:pickupObj];
            printf("you picked up the %s\n", [tempObject UTF8String]);
        } else {
            printf("Unable to pick up %s", [tempObject UTF8String]);
        }
        
        
        
    } else if ( [*command isEqualToString:@"list inventory"] ) {//the player wants a list of their inventory
        
        [self.player showInventory];
        
    } else if ( [*command hasPrefix:@"go to"] ) {//the player wants to navigate to another area
        
        NSRange stringRange = NSMakeRange(6, [*command length] - 6);
        NSString *tempArea = [*command substringWithRange:stringRange];
        
        for (NSDictionary *areaDic in [self.currentArea otherArea]) {
            
            if ( [tempArea isEqualToString:[areaDic objectForKey:@"goto"]] ) {
                
                [self loadArea:[areaDic objectForKey:@"fileName"]];
                
                printf("you are now in %s\n", [[areaDic objectForKey:@"goto"] UTF8String]);
                
            }
            
        }
        
    } else if ([*command isEqualToString:@"objectives"]) {//the player wants to know what the objective is
        
        if ([self.objectives count] > 0) {
            printf("There are the following objectives:\n");
            
            for (NSString * obj in self.objectives) {
                printf("\t%s\n", [obj UTF8String]);
            }
            
        } else {
            printf("There are no objectives\n");
        }
        
    } else {//unknown command
        
        printf("Unrecognised input\n");
        
    }
    
    printf("\n");
    
    return TRUE;
}

-(NSString *) getIntro {
    
    NSString *path = [self.dir stringByAppendingString:@"/intro.json"];
    
    NSFileHandle *tempFile = [NSFileHandle fileHandleForReadingAtPath:path];
    
    NSData *tempData = [tempFile readDataToEndOfFile];
    
    NSString *jsonString = [[NSString alloc] initWithData:tempData encoding:NSUTF8StringEncoding];
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    NSDictionary *json = [jsonParser objectWithString:jsonString];
    
    printf("%s\n", [[json objectForKey:@"intro"] UTF8String]);
    
    self.objectives = [json objectForKey:@"objectives"];
    
    printf("%s\n\n", [[json objectForKey:@"intro"] UTF8String]);
    
    printf("Your objectives are to find the following:\n");
    
    for (NSString * tempObjective in self.objectives) {
        printf("\t%s\n", [tempObjective UTF8String]);
    }
    
    printf("\n");
    
    
    return [json objectForKey:@"firstArea"];
    
}

-(void) loadArea:(NSString *)area {

    //specify the file
    NSString *fileName = [NSString stringWithFormat: @"%@/%@.json", self.dir, area];
    
    //connect to the file
    NSFileHandle *tempFile = [NSFileHandle fileHandleForReadingAtPath:fileName];
    
    //get data from the file
    NSData *tempData = [tempFile readDataToEndOfFile];
    
    //access the data as a string
    NSString *jsonString = [[NSString alloc] initWithData:tempData encoding:NSUTF8StringEncoding];
    
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
    
    //parse the string into a dictionary
    NSDictionary *json = [jsonParser objectWithString:jsonString];
    
    //create a new area while retrieving the description and objects from the dictionary
    self.currentArea = [[Area alloc] initWithDescription:[json objectForKey:@"description"] andWithObjects: [json objectForKey:@"objects"] andWithAreas:[json objectForKey:@"attachedAreas"]];
    
    
    
}

- (BOOL) checkWin {
    
    //NSMutableArray * objectives = [NSMutableArray arrayWithObjects: @"Toaster", @"Couch", nil];
    
    int count = 0;
    
    for (AreaObject * inventoryItem in [self.player inventory]) {
        
        for (NSString * objective in self.objectives) {
            
            if ([objective isEqualToString:[inventoryItem title]]) {
                
                count++;
            }
            
        }
        
    }
    
    if ([self.objectives count] == count) {
        
        [self gameWon];
        
        return TRUE;
    }
    
    return FALSE;
    
}

- (void) gameWon {
    printf("YOU have won the game!!\n\n");
}



@end
