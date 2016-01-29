//
//  EntryCell.h
//  CoreDataApp
//
//  Created by Venkatesh Jujjavarapu on 10/22/15.
//  Copyright © 2015 sitacorp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DiaryEntry;
@interface EntryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

@property (weak, nonatomic) IBOutlet UIImageView *moodImageView;

-(void)configureCellForEntry:(DiaryEntry *)entry;


@end
