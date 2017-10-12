//
//  action.h
//  Mafia_app_c
//
//  Created by Stacy Miller on 5/23/16.
//  Copyright © 2016 Stacy Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface action : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *phase;
@property (weak, nonatomic) IBOutlet UILabel *playerName;
@property (weak, nonatomic) IBOutlet UITextField *target;
@property (weak, nonatomic) IBOutlet UILabel *output;
- (IBAction)confirmButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *confirmLabel;



@property (weak, nonatomic) IBOutlet UILabel *alivePlayers;
@property(nonatomic) NSMutableArray *players;
@property(nonatomic) NSMutableArray *allPlayers;
@property (nonatomic) NSString *game_id;
@property(nonatomic) NSString* stage;
@property(nonatomic) NSDictionary* phases;
@property (weak, nonatomic) IBOutlet UILabel *targetText;
- (IBAction)backgroundTap:(id)sender;

@end
