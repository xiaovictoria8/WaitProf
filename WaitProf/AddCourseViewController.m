//
//  AddCourseViewController.m
//  WaitProf
//
//  Created by Victoria Xiao on 2016-01-23.
//  Copyright © 2016 My Majesty Productions. All rights reserved.
//

#import "AddCourseViewController.h"
#import <Parse/Parse.h>

@interface AddCourseViewController ()

@property (weak, nonatomic) IBOutlet UITextField *courseCode;
@property (weak, nonatomic) IBOutlet UITextField *courseName;
@property (weak, nonatomic) IBOutlet UITextField *profName;

@end

@implementation AddCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - when the "Create course" button is pressed
- (IBAction)createButtonPressed:(id)sender {
    //create new Parse object
    PFObject *course = [PFObject objectWithClassName:@"Course"];
    [course setObject:self.courseCode.text forKey:@"courseCode"];
    [course setObject:self.courseName.text forKey:@"courseName"];
    [course setObject:self.profName.text forKey:@"profName"];
    [course setObject:[NSNumber numberWithInt:0]forKey:@"numWaits"];
    [course saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded){
            [self performSegueWithIdentifier:@"unwind1" sender:self];
        }
        else {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
