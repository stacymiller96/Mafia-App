//
//  joinGame.m
//  Mafia_app_c
//
//  Created by Stacy Miller on 5/20/16.
//  Copyright © 2016 Stacy Miller. All rights reserved.
//

#import "joinGame.h"
#import "waiting.h"
#import "playerObject.h"

@interface joinGame ()

@end

@implementation joinGame
@synthesize players;

NSString *playersJSON1;

- (void)viewDidLoad {
    [super viewDidLoad];
    players = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)AddPlayerButton:(id)sender {
    playerObject *newPlayer = [[playerObject alloc]init];
    NSString *playerName = [_Name text];
    newPlayer.name = playerName;
    if(![playerName isEqual: @""]){
        [players addObject:newPlayer];
        _Name.text=nil;
    }
}

- (void) playerJSON{
    playersJSON1 = @"{\"PlayerNames\":[";
    for(int i = 0; i < [players count];i++){
        playersJSON1 = [playersJSON1 stringByAppendingString: @"\""];
        playerObject* newP = [players objectAtIndex:i];
        playersJSON1 = [playersJSON1 stringByAppendingString: newP.name];
        playersJSON1 = [playersJSON1 stringByAppendingString: @"\""];
        if( i < [players count]-1){
            playersJSON1 = [playersJSON1 stringByAppendingString: @", "];
        }
    }
    playersJSON1 = [playersJSON1 stringByAppendingString: @"]}"];
    NSLog(playersJSON1);
}



- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        waiting *next;
        next= [segue destinationViewController];
        next.game_id = [_GameID text];
        next.players = [[NSMutableArray alloc] init];
        int i = 0;
        while(i<[players count]){
            [next.players addObject: [players objectAtIndex:i]];
            i++;
        }
        [self playerJSON];
        next.JSONstring = playersJSON1;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch =[[event allTouches] anyObject];
    if([_Name isFirstResponder] && [touch view] != _Name){
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}

-(IBAction)backgroundTap:(id)sender{
    [self.view endEditing:YES];
}

@end
