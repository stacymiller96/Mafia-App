//
//  joinGame.h
//  Mafia_app_c
//
//  Created by Stacy Miller on 5/20/16.
//  Copyright © 2016 Stacy Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface joinGame : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *GameID;

@property (weak, nonatomic) IBOutlet UITextField *Name;

@property(nonatomic) NSMutableArray *players;

- (IBAction)AddPlayerButton:(id)sender;
- (IBAction)backgroundTap: (id)sender;


@end
