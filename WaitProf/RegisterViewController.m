//
//  RegisterViewController.m
//  WaitProf
//
//  Created by Victoria Xiao on 2016-01-23.
//  Copyright © 2016 My Majesty Productions. All rights reserved.
//

#import "RegisterViewController.h"
#import <Parse/Parse.h>

@interface RegisterViewController ()

//Fields for username and password
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *name;


//Fields for the student/prof picker thing
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) NSArray *pickerArray;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pickerArray  = [[NSArray alloc] initWithObjects:@"Student", @"Professor", nil];
    
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.picker.backgroundColor=[UIColor whiteColor];
    
    [self attachPickerToTextField:self.textField :self.picker];
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


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Sign up button
- (IBAction)signUpUserPressed:(id)sender {
    
    //create user object in Parse
    PFUser *user = [PFUser user];
    user.username = self.username.text;
    user.password = self.password.text;
    [user setObject:self.name.text forKey:@"Name"];
    [user setObject:self.textField.text forKey:@"Type"];
    
    //checking to make sure signup worked
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error) {
            [self performSegueWithIdentifier:@"Signup successful!" sender:self];
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


#pragma mark - Connecting the picker to the Text Field
- (void)attachPickerToTextField: (UITextField*) textField :(UIPickerView*) picker{
    picker.delegate = self;
    picker.dataSource = self;
    
    textField.delegate = self;
    textField.inputView = picker;
    
}


#pragma mark - Keyboard delegate stuff

// let tapping on the background (off the input field) close the thing
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
}

#pragma mark - Picker delegate stuff

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = [self.pickerArray objectAtIndex: (NSUInteger)row];
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255.0f/255.0f green:153.0f/255.0f blue:181.0f/255.0f alpha:1.0f]}];

    return attString;
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.picker){
        return self.pickerArray.count;
    }
    
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    if (pickerView == self.picker){
        return [self.pickerArray objectAtIndex:row];
    }
    
    return @"???";
    
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    if (pickerView == self.picker){
        self.textField.text = [self.pickerArray objectAtIndex:row];
    }

    
}

@end
