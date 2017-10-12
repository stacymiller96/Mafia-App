//
//  makePlayerEntry.h
//  Mafia_app_c
//
//  Created by Stacy Miller on 5/20/16.
//  Copyright © 2016 Stacy Miller. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface waiting : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *editthis;
@property (weak, nonatomic) IBOutlet UILabel *b;
@property (weak, nonatomic) IBOutlet UILabel *a;
- (IBAction)readyButton:(id)sender;



@property (nonatomic) NSString *game_id;
@property(nonatomic) NSMutableArray *players;
@property (nonatomic) NSString *JSONstring;
- ( NSString * )getData:(NSString*) playerList;


@end