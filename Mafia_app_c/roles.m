//
//  roles.m
//  Mafia_app_c
//
//  Created by Stacy Miller on 5/23/16.
//  Copyright © 2016 Stacy Miller. All rights reserved.
//

#import "roles.h"
#import "action.h"
#import "playerObject.h"

@interface roles ()

@end

@implementation roles
@synthesize playerList, count1, roleList, players, game_id, roles;



- (void)viewDidLoad {
    [super viewDidLoad];
    count1 = 0;
    playerObject* temp =[players objectAtIndex:count1];
    _playerName.text = temp.name;
    
    self.roles = [[NSDictionary alloc] initWithObjectsAndKeys:
                  @"Not Set", @"0",
                  @"Townsperson", @"1",
                  @"Mafia", @"2",
                  @"Doctor", @"3",
                  @"Sheriff", @"4",
                  nil];
    
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

- (IBAction)contButton:(id)sender {
    int x = [players count];
    if(count1 < x){
        playerObject* curr = [players objectAtIndex:count1];
        if([_roleName.text isEqual: @"Your Role is:"]){
            _roleName.text = [self.roles objectForKey:curr.role];
            count1++;
        }
        else{
          
            _roleName.text=@"Your Role is:";
            _playerName.text = curr.name;
            
        }
    }
    else
         [self performSegueWithIdentifier:@"conditionSegue3" sender:nil];
        
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    action *next;
    next= [segue destinationViewController];
    next.game_id = game_id;
    next.players = [[NSMutableArray alloc] init];
    int i = 0;
    while(i<[players count]){
        [next.players addObject: [players objectAtIndex:i]];
        i++;
    }
}

@end
