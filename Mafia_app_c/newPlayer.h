//
//  newPlayer.h
//  Mafia_app_c
//
//  Created by Stacy Miller on 5/23/16.
//  Copyright © 2016 Stacy Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newPlayer : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *Name;
- (IBAction)addPlayerButton:(id)sender;


@property (nonatomic) NSString *game_id;
@property(nonatomic) NSMutableArray *players;
- (IBAction)backgroundTap:(id)sender;
- (void) playerJSON;



@end
