//
//  Globals.h
//  Mafia_app_c
//
//  Created by Stacy Miller on 5/23/16.
//  Copyright © 2016 Stacy Miller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Globals : NSObject

@end


//Phases
#define UNSTARTED -1
#define NIGHT 1
#define DAY 2
#define TOWNWIN 11
#define MAFIAWIN 12

//Roles
#define NOTSET 0
#define TOWNSPERSON 1
#define MAFIA 2
#define DOCTOR 3
#define SHERIFF 4

//MoveTypes
#define LYNCH 0
//the rest are same as Roles

//States
#define ALIVE 1
#define DEAD 0

