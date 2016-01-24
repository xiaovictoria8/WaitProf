//
//  ProfPageViewController.m
//  WaitProf
//
//  Created by Victoria Xiao on 2016-01-24.
//  Copyright © 2016 My Majesty Productions. All rights reserved.
//

#import "ProfPageViewController.h"
#import <Parse/Parse.h>

@interface ProfPageViewController ()

@property (nonatomic, strong) NSString *course;

@end

@implementation ProfPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFQuery *query = [PFQuery queryWithClassName:@"Course"];
    self.course = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    [query whereKey:@"courseCode" equalTo:self.course];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            self.numLabel.text = [[[objects firstObject] objectForKey:@"numWaits"] stringValue];
        } else {
            //setting up UIAlertControllerStuff
            UIAlertController *signUpAlert = [UIAlertController alertControllerWithTitle:@"Login error"
                                                                                 message:[[error userInfo] objectForKey:@"error"]
                                                                          preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *signUpOk = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action ) {
                                                                 [signUpAlert dismissViewControllerAnimated: YES completion: nil];
                                                             }];
            [signUpAlert addAction:signUpOk];
            [self presentViewController:signUpAlert animated:YES completion:nil];
        }
    }];
}
- (IBAction)refreshPressed:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Course"];
    self.course = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    [query whereKey:@"courseCode" equalTo:self.course];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            self.numLabel.text = [[[objects firstObject] objectForKey:@"numWaits"] stringValue];
        } else {
            //setting up UIAlertControllerStuff
            UIAlertController *signUpAlert = [UIAlertController alertControllerWithTitle:@"Login error"
                                                                                 message:[[error userInfo] objectForKey:@"error"]
                                                                          preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *signUpOk = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action ) {
                                                                 [signUpAlert dismissViewControllerAnimated: YES completion: nil];
                                                             }];
            [signUpAlert addAction:signUpOk];
            [self presentViewController:signUpAlert animated:YES completion:nil];
        }
    }];
}
- (IBAction)resetPressed:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Course"];
    self.course = [[NSUserDefaults standardUserDefaults] objectForKey:@"key"];
    [query whereKey:@"courseCode" equalTo:self.course];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            [[objects firstObject] setObject:[NSNumber numberWithInt:0] forKey:@"numWaits"];
            self.numLabel.text = [[[objects firstObject] objectForKey:@"numWaits"] stringValue];
        } else {
            //setting up UIAlertControllerStuff
            UIAlertController *signUpAlert = [UIAlertController alertControllerWithTitle:@"Login error"
                                                                                 message:[[error userInfo] objectForKey:@"error"]
                                                                          preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *signUpOk = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action ) {
                                                                 [signUpAlert dismissViewControllerAnimated: YES completion: nil];
                                                             }];
            [signUpAlert addAction:signUpOk];
            [self presentViewController:signUpAlert animated:YES completion:nil];
        }
    }];
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

@end
