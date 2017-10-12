//
//  ViewController2.h
//  Mafia_app_c
//
//  Created by Stacy Miller on 5/20/16.
//  Copyright © 2016 Stacy Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController2 : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *players;
- (IBAction)button:(id)conditionalSwitch;
@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)backgroundTap:(id)sender;


@end
