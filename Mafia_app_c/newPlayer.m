//
//  newPlayer.m
//  Mafia_app_c
//
//  Created by Stacy Miller on 5/23/16.
//  Copyright © 2016 Stacy Miller. All rights reserved.
//

#import "newPlayer.h"
#import "waiting.h"
#import "roles.h"
#import "playerObject.h"

@interface newPlayer ()

@end

@implementation newPlayer
@synthesize game_id, players;

NSString *playersJSON;

- (void)viewDidLoad {
    [super viewDidLoad];
    players = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addPlayerButton:(id)sender {
    playerObject *newPlayer = [[playerObject alloc]init];
    NSString *playerName = [_Name text];
    newPlayer.name = playerName;
    if(![playerName isEqual: @""]){
        [players addObject:newPlayer];
        _Name.text=nil;
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    waiting *next;
    next= [segue destinationViewController];
    next.game_id = game_id;
    next.players = [[NSMutableArray alloc] init];
    int i = 0;
    while(i<[players count]){
        [next.players addObject: [players objectAtIndex:i]];
        i++;
    }
    [self playerJSON];
    next.JSONstring = playersJSON;
}

- (void) playerJSON{
    playersJSON = @"{\"PlayerNames\":[";
    for(int i = 0; i < [players count];i++){
        playersJSON = [playersJSON stringByAppendingString: @"\""];
        playerObject* newP = [players objectAtIndex:i];
        playersJSON = [playersJSON stringByAppendingString: newP.name];
        playersJSON = [playersJSON stringByAppendingString: @"\""];
        if( i < [players count]-1){
             playersJSON = [playersJSON stringByAppendingString: @", "];
        }
    }
    playersJSON = [playersJSON stringByAppendingString: @"]}"];
    NSLog(playersJSON);
}




-(IBAction)backgroundTap:(id)sender{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch =[[event allTouches] anyObject];
    if([_Name isFirstResponder] && [touch view] != _Name){
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}


@end
