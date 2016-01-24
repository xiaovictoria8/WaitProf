//
//  CoursesControllerTableViewController.m
//  WaitProf
//
//  Created by Victoria Xiao on 2016-01-23.
//  Copyright © 2016 My Majesty Productions. All rights reserved.
//

#import "CoursesControllerTableViewController.h"
#import "courseCellTableViewCell.h"
#import <Parse/Parse.h>

@interface CoursesControllerTableViewController ()

@end

@implementation CoursesControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logoutPressed:(id)sender {
    [PFUser logOut];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 
-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

#pragma mark - Special PFQueryTableViewController functions
- (id)initWithCoder:(NSCoder *)aCoder{
    self = [super initWithCoder:aCoder];
    if (self) {
        self.parseClassName = @"Course";
        self.textKey = @"courseCode";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
    }
    return self;
}


- (PFQuery *)queryForTable{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    return query;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
    (NSIndexPath *)indexPath object:(PFObject *)object{
    CourseCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"courseCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"courseCell" bundle:nil] forCellReuseIdentifier:@"courseCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"courseCell"];
    }
    //Configure custom cell
    cell.courseCodeLabel.text = [object objectForKey:@"courseCode"];
    cell.courseNameLabel.text = [object objectForKey:@"courseName"];
    cell.profNameLabel.text = [object objectForKey:@"profName"];
    return cell;
}

#pragma mark
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"profPageSegue"]) {
        NSLog(@"prepareForSegueCalled");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        NSString *courseString = [object objectForKey:@"courseCode"];
    
        [[NSUserDefaults standardUserDefaults] setObject:courseString forKey:@"key"];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"profPageSegue" sender:self];
}

@end

