//
//  playerObject.h
//  Mafia_app_c
//
//  Created by Stacy Miller on 5/31/16.
//  Copyright © 2016 Stacy Miller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface playerObject : NSObject

@property(nonatomic)NSString* name;
@property(nonatomic)NSString* ID;
@property(nonatomic)NSString* role;
@property(nonatomic)int state;

@end
