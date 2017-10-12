//
//  victoryScreen.h
//  Mafia_app_c
//
//  Created by Stacy Miller on 5/31/16.
//  Copyright © 2016 Stacy Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface victoryScreen : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *victoryMessage;
@property(nonatomic) NSString* winningTeam;

@end
