//
//  StudentPageViewController.m
//  WaitProf
//
//  Created by Victoria Xiao on 2016-01-24.
//  Copyright © 2016 My Majesty Productions. All rights reserved.
//

#import "StudentPageViewController.h"
#import <Parse/Parse.h>

@interface StudentPageViewController ()

@end

@implementation StudentPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonPressed:(id)sender {
    NSString *id = [[NSUserDefaults standardUserDefaults] objectForKey:@"key2"];
    PFQuery *query = [PFQuery queryWithClassName:@"Course"];
    [query whereKey:@"courseCode" equalTo:id];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {//4
        if (!error && [objects count] != 0) {
            PFObject *object = [objects firstObject];
            [object incrementKey:@"numWaits"];
            [object saveInBackground];
        } else {
            NSLog(@"Error");
        }
    }];
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
