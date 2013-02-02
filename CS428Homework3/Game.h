//
//  Game.h
//  CS428Homework3
//
//  Created by Nicholas Otter on 2/1/13.
//  Copyright (c) 2013 otternq. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A class to represent a game
*/
@interface Game : NSObject {
    
    /**
     The list of available commands
     */
    NSArray *menu;
    
    /**
     The handler for STDIN
     */
    NSFileHandle *input;
    
    /**
     Gets data from the input variable
     */
    NSData *inputData;
}

-(id) init;

/**
 Executes the game
 */
-(void) gameLoop;

/**
 The list of available commands
 */
-(NSArray *)getMenu;

/**
 Gets the command from the user
 @param command A common resource for the input
 */
- (BOOL) getCommand: (NSString **) command;

/**
 Processes the command issued by the user
 @param command A common resource for the input
 */
- (BOOL) splitCommands: (NSString **) command;


@end