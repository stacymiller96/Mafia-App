//
//  makePlayerEntry.m
//  Mafia_app_c
//
//  Created by Stacy Miller on 5/20/16.
//  Copyright © 2016 Stacy Miller. All rights reserved.
//

#import "waiting.h"
#import "Globals.h"
#import "roles.h"
#import "playerObject.h"


@interface waiting ()

@end

@implementation waiting

NSInteger state = 2;

@synthesize game_id, editthis, b, players, JSONstring;
- (void)viewDidLoad {
    [super viewDidLoad];
    editthis.text=game_id;
    b.text= @"";
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)readyButton:(id)sender {
    [sender setTitle:@"Waiting for Players" forState:UIControlStateNormal];
    while(state != DAY)
        ;
    b.text= @"Done!";
    [self performSegueWithIdentifier:@"conditionSegue2" sender:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    roles *next;
    next= [segue destinationViewController];
    next.game_id = game_id;
    next.players = [[NSMutableArray alloc] init];
    int i = 0;
    while(i<[players count]){
        [next.players addObject: [players objectAtIndex:i]];
        i++;
    }
    [self getData:JSONstring];
}



- ( NSString * )getData:(NSString*) playerList
{
    NSString* urlString=[NSString stringWithFormat:@"http://mafia.marktai.com/api/games/%@/deviceRegister", game_id];
    
    
    NSURL* gameIDURL= [NSURL URLWithString: urlString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:gameIDURL];
    [request setHTTPMethod:@"POST"];
    
    //new
    NSError *jsonError, *error;
    NSData *objectData = [/*[NSString stringWithFormat:playerList] */playerList dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *tmp = [NSJSONSerialization JSONObjectWithData:objectData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&jsonError];
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:0 error:&error];
    [request setHTTPBody:postdata];
    //new end
    
    
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
            NSLog(@"%@", [gameDictionary description]);
        }
        for(int i = 0; i < [players count]; i++){
            playerObject* temp = [players objectAtIndex:i];
            temp.ID= [[[gameDictionary objectForKey:temp.name] valueForKey:@"PlayerID"]stringValue];
            temp.role= [[[gameDictionary objectForKey:temp.name] valueForKey:@"Role"]stringValue];
            
            
        }
        
    }
    
    return @"hi";
}


 
@end
