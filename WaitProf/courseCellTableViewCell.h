//
//  courseCellTableViewCell.h
//  WaitProf
//
//  Created by Victoria Xiao on 2016-01-23.
//  Copyright © 2016 My Majesty Productions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *courseCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *profNameLabel;
@end
