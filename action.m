//
//  action.m
//  Mafia_app_c
//
//  Created by Stacy Miller on 5/23/16.
//  Copyright © 2016 Stacy Miller. All rights reserved.
//

#import "action.h"
#import "playerObject.h"
#import "globals.h"
#import "victoryScreen.h"

@interface action ()

@end

@implementation action
@synthesize players, game_id, stage, phases;

playerObject* currentPlayer;
int counter = 0;
NSArray* t;
//keep rolling counter and use mod to access positions

NSTimer *y;
NSString* sheriffResult;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.phases = [[NSDictionary alloc] initWithObjectsAndKeys:
                  @"UNSTARTED", @"-1",
                  @"NIGHT", @"1",
                  @"DAY", @"2",
                  @"TOWN WIN", @"11",
                  @"MAFIA WIN", @"12",
                  nil];
    
    for(int i = 0; i < [players count]; i++){
        playerObject* curr = [players objectAtIndex:i];
        curr.state = ALIVE;
    }
    _output.text = @"";
    [self getState];
    [self getData];
    _phase.text = [self.phases objectForKey:stage];
    [self setPlayer];   //set player name
    
    NSString* aliveList = @"Alive Players: ";
    for(int j = 0; j < [t count]; j++){
        if([[[t objectAtIndex:j]valueForKey:@"Alive"]intValue]){
            aliveList = [aliveList stringByAppendingString: @" "];
            aliveList = [aliveList stringByAppendingString: [[t objectAtIndex:j] valueForKey:@"Name"]];
            aliveList = [aliveList stringByAppendingString: @","];
        }
    }
    aliveList = [aliveList substringToIndex:[aliveList length]-1];
    
    _alivePlayers.text = aliveList;
    
    y= [NSTimer scheduledTimerWithTimeInterval: 2.0
                                         target: self
                                       selector:@selector(onTick:)
                                       userInfo: nil repeats:YES];

   
}

-(void)onTick:(NSTimer *)timer {
    
    NSString* currentState = stage;
    [self getState];
    NSLog(stage);
    if(stage != currentState){
        [_confirmLabel setTitle:@"Confirm" forState:UIControlStateNormal];
        if([stage isEqual:@"11"] || [stage isEqual:@"12"]){
            [self performSegueWithIdentifier:@"victorySegue" sender:nil];
        }
        
        [self getData];
        
        if([stage isEqual: @"1"]){
            self.view.backgroundColor = [UIColor blackColor];
            _targetText.textColor = [UIColor whiteColor];
            _output.textColor = [UIColor whiteColor];
            _alivePlayers.textColor = [UIColor whiteColor];
        }
        else if([stage isEqual:@"2"]){
            self.view.backgroundColor = [UIColor whiteColor];
            _targetText.textColor = [UIColor blackColor];
            _output.textColor = [UIColor blackColor];
            _alivePlayers.textColor = [UIColor blackColor];
        }
        
        NSString* aliveList = @"Alive Players: ";
        for(int j = 0; j < [t count]; j++){
            if([[[t objectAtIndex:j]valueForKey:@"Alive"]intValue]){
                aliveList = [aliveList stringByAppendingString: @" "];
                aliveList = [aliveList stringByAppendingString: [[t objectAtIndex:j] valueForKey:@"Name"]];
                aliveList = [aliveList stringByAppendingString: @","];
            }
        }
        aliveList = [aliveList substringToIndex:[aliveList length]-1];
        _alivePlayers.text = aliveList;
        
        for(counter=0;counter < [players count];){
            playerObject* current = [players objectAtIndex:counter];
            if(current.state == DEAD)
                counter++;
            else
                break;
        }
        [self resetScreen];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)setPlayer{
    currentPlayer = [players objectAtIndex:counter];
    _playerName.text = currentPlayer.name;
                                                
    
}

- ( NSString * )getData
{
    NSString* urlString=[NSString stringWithFormat:@"http://mafia.marktai.com/api/games/%@/info", game_id];
    
    
    NSURL* gameIDURL= [NSURL URLWithString: urlString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:gameIDURL];
    [request setHTTPMethod:@"GET"];
    
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData* data=[NSURLConnection sendSynchronousRequest:request
                                       returningResponse:nil
                                                   error:nil];

    
    NSString* gameID = nil;
    if (data!=nil){
        NSDictionary * gameDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:NSJSONReadingMutableContainers
                                                                          error:nil];
        if (gameDictionary!=nil){
            //NSLog(@"%@", [gameDictionary description]);
        }
        
        t = [[NSArray alloc]init];
        //t = [[gameDictionary objectForKey:@"Info"] objectAtIndex:8];
        t = [gameDictionary valueForKeyPath:@"Info.Players"];
        NSString* name = [[t objectAtIndex:0]valueForKey:@"Name"];
        for(int i = 0; i < [players count]; i++){
            playerObject *tempPlayer = [players objectAtIndex:i];
            for(int j = 0; j < [t count]; j++){
                if([[t objectAtIndex:j]valueForKey:@"Name"] == tempPlayer.name)
                    tempPlayer.state = [[[t objectAtIndex:j]valueForKey:@"Alive"]intValue];
            }
            
        }
    }
    
    return @"hi";
}

- ( NSString * )getState
{
    NSString* urlString=[NSString stringWithFormat:@"http://mafia.marktai.com/api/games/%@/info", game_id];
    
    
    NSURL* gameIDURL= [NSURL URLWithString: urlString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:gameIDURL];
    [request setHTTPMethod:@"GET"];
    
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData* data=[NSURLConnection sendSynchronousRequest:request
                                       returningResponse:nil
                                                   error:nil];
    
    
    NSString* gameID = nil;
    if (data!=nil){
        NSDictionary * gameDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:NSJSONReadingMutableContainers
                                                                          error:nil];
        if (gameDictionary!=nil){
            //NSLog(@"%@", [gameDictionary description]);
        }
        
        stage= [[[gameDictionary objectForKey:@"Info"] valueForKey:@"Stage"]stringValue];
    }
    
    return @"hi";
}




- (IBAction)confirmButton:(id)sender {
    /*if dead, remove from list
    increment spot on array
    if current guy is dead, 
        increment again
    set phase, player name, turn/death
    send http request
     
     if all players have gone
        go into loop waiting on server to change phase
     else
        do nothing
     */
    //check valid target if we ever have time
    if([_output.text isEqual:@"Suspect is Mafia."] || [_output.text isEqual:@"Suspect is not Mafia."]){
        counter++;
        while(counter < [players count]){
            playerObject* current = [players objectAtIndex:counter];
            if(current.state == DEAD)
                counter++;
            else
                break;
        }
        
        [self resetScreen];
        return;
    }
    
    if(counter == [players count])
        return;
    
    NSString* target;
    for(int i = 0; i < [t count]; i++){
        if(_target.text == [[t objectAtIndex:i]valueForKey:@"Name"]){
            target = [[[t objectAtIndex:i]valueForKey:@"PlayerID"]stringValue];
            break;
        }
    }
    if(target == nil){
        _output.text = @"Invalid Target Player Name";
        return;
    }
    
    NSString* move = currentPlayer.role;
    NSLog(stage);
    if([stage isEqual: @"2"]){
        move = @"0";
    }

    NSString* urlString=[NSString stringWithFormat:@"http://mafia.marktai.com/api/games/%@/move?PlayerID=%@&TargetID=%@&MoveType=%@", game_id, currentPlayer.ID, target, move];
    NSLog(urlString);
    [self makeMove:urlString];
    
    if([currentPlayer.role isEqual: @"4"] && [stage isEqual:@"1"] && ([_output.text isEqual:@""]||[_output.text isEqual:@"Invalid Target Player Name"])){
        if([sheriffResult isEqual:@"1"]){
            _output.text = @"Suspect is Mafia.";
        }
        else
            _output.text = @"Suspect is not Mafia.";
        return;
    }
    
    counter++;
    while(counter < [players count]){
        playerObject* current = [players objectAtIndex:counter];
        if(current.state == DEAD)
            counter++;
        else
            break;
    }

    [self resetScreen];
    
    //TODO: Process Results
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch =[[event allTouches] anyObject];
    if([_target isFirstResponder] && [touch view] != _target){
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void) resetScreen{
    if(counter != [players count])
        [self setPlayer];
    else
        [_confirmLabel setTitle:@"Waiting" forState:UIControlStateNormal];
    _phase.text = [self.phases objectForKey:stage];
    _target.text = @"";
    _output.text = @"";
}

- ( NSString * )makeMove:(NSString*) URL
{
    NSURL* gameIDURL= [NSURL URLWithString: URL];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:gameIDURL];
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    NSData* data=[NSURLConnection sendSynchronousRequest:request
                                       returningResponse:nil
                                                   error:nil];
    
    if (data!=nil){
        NSDictionary * gameDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:NSJSONReadingMutableContainers
                                                                          error:nil];
        if (gameDictionary!=nil){
            NSLog(@"%@", [gameDictionary description]);
            if([currentPlayer.role isEqual: @"4"] && [stage isEqual:@"1"]){
                sheriffResult = [[[gameDictionary objectForKey:@"Result"] valueForKey:@"Sherriff"]stringValue];
            }
        }
    }
    
    return @"testing";
}



-(IBAction)backgroundTap:(id)sender{
    [self.view endEditing:YES];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    victoryScreen *next;
    next= [segue destinationViewController];
    next.winningTeam = stage;
}

@end
