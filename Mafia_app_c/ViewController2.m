//
//  ViewController2.m
//  Mafia_app_c
//
//  Created by Stacy Miller on 5/20/16.
//  Copyright © 2016 Stacy Miller. All rights reserved.
//

#import "newPlayer.h"
#import "ViewController2.h"

@interface ViewController2 ()
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
bool isInt;
int numMafia;
int numPlayers;
NSString *Game_ID;

- (IBAction)button:(id)conditionalSwitch {
    numPlayers = [[_players text] intValue];
    if(numPlayers == 0)
        isInt = FALSE;
    else
        isInt = TRUE;
    NSString *output = [NSString stringWithFormat:@"%i", numPlayers];
    //_label.text = output;
    
    if(isInt == TRUE){
        numMafia = (int)numPlayers/3;
        Game_ID = [self getData:(output)];
        [self performSegueWithIdentifier:@"conditionSegue1" sender:nil];
    }
    
    //set http stuff
}



- (IBAction)backgroundTap:(id)sender{
    [self.view endEditing:YES];
    
}


- ( NSString * )getData:(NSString*) numberPlayers
{
    NSString* urlString=[NSString stringWithFormat:@"http://mafia.marktai.com/api/games"];
 
    
    NSURL* gameIDURL= [NSURL URLWithString: urlString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:gameIDURL];
    [request setHTTPMethod:@"POST"];
   
    //new
    NSError *jsonError, *error;
    NSString *numMafiaString = [NSString stringWithFormat:@"%i", numMafia];
    NSString *numPlayersString = [NSString stringWithFormat:@"%i", numPlayers];
    NSData *objectData = [[NSString stringWithFormat:@"{\"PlayerCount\": %@, \"MafiaCount\": %@, \"DoctorCount\": 1, \"SherriffCount\": 1}", numPlayersString, numMafiaString] dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(numPlayersString);
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
            //NSLog(@"%@", [gameDictionary description]);
        }
        gameID = [[gameDictionary objectForKey:@"GameID"] stringValue];
    }
    
    return gameID;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        newPlayer *next;
        next= [segue destinationViewController];
        next.game_id = Game_ID;
}

@end
