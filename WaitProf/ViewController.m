//
//  ViewController.m
//  WaitProf
//
//  Created by Victoria Xiao on 2016-01-23.
//  Copyright © 2016 My Majesty Productions. All rights reserved.
//

#import <Parse/Parse.h>
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginPressed:(id)sender {
    
    [PFUser logInWithUsernameInBackground:self.username.text password:self.password.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (!error) {
                                            //segue to correct page depending on user type
                                            if ([[user objectForKey:@"Type"] isEqualToString:@"Professor"]) {
                                                [self performSegueWithIdentifier:@"profLogin" sender:self];
                                                NSLog(@"Prof login");
                                            } else if ([[user objectForKey:@"Type"] isEqualToString:@"Student"]) {
                                                [self performSegueWithIdentifier:@"studentLogin" sender:self];
                                                NSLog(@"Student login");
                                            }
                                        } else {
                                            //setting up UIAlertControllerStuff
                                            UIAlertController *loginAlert = [UIAlertController alertControllerWithTitle:@"Login error"
                                                                                                               message:[[error userInfo] objectForKey:@"error"]
                                                                                                        preferredStyle:UIAlertControllerStyleAlert];
                                            UIAlertAction *loginOk = [UIAlertAction actionWithTitle:@"OK"
                                                                                             style:UIAlertActionStyleDefault
                                                                                           handler:^(UIAlertAction *action ) {
                                                                                               [loginAlert dismissViewControllerAnimated: YES completion: nil];
                                                                                           }];
                                            [loginAlert addAction:loginOk];
                                            [self presentViewController:loginAlert animated:YES completion:nil];
                                        }
                                    }];
}

@end
