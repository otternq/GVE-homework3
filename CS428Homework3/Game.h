//
//  Game.h
//  CS428Homework3
//
//  Created by Nicholas Otter on 2/1/13.
//  Copyright (c) 2013 otternq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Area.h"
#import "Player.h"

/**
 A class to represent a game
*/
@interface Game : NSObject

@property Area *currentArea;
    
@property Player * player;
    
/**
 The list of available commands
 */
@property NSArray *menu;
    
/**
 The handler for STDIN
 */
@property NSFileHandle *input;
    
/**
 Gets data from the input variable
 */
@property NSData *inputData;

@property NSString * dir;

-(id) initWithDir: (NSString *)dir;

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

- (NSString *) getIntro;

- (void) loadArea: (NSString *) area;

- (BOOL) checkWin;

- (void) gameWon;



@end