//
//  victoryScreen.m
//  Mafia_app_c
//
//  Created by Stacy Miller on 5/31/16.
//  Copyright © 2016 Stacy Miller. All rights reserved.
//

#import "victoryScreen.h"

@implementation victoryScreen
@synthesize winningTeam;

- (void)viewDidLoad {
    [super viewDidLoad];
    if([winningTeam isEqual:@"11"])
        _victoryMessage.text = @"Town Wins!";
    else
        _victoryMessage.text = @"Mafia Wins!";
}


@end
