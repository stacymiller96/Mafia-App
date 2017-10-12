//
//  roles.h
//  Mafia_app_c
//
//  Created by Stacy Miller on 5/23/16.
//  Copyright © 2016 Stacy Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface roles : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *playerName;
@property (weak, nonatomic) IBOutlet UILabel *roleName;
- (IBAction)contButton:(id)sender;

@property(nonatomic) NSMutableArray *playerList;
@property(nonatomic) NSMutableArray *roleList;
@property(nonatomic) NSUInteger count1;
@property(nonatomic) NSMutableArray *players;
@property (nonatomic) NSString *game_id;
@property (nonatomic) NSDictionary* roles;

@end
