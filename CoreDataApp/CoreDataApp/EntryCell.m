//
//  EntryCell.m
//  CoreDataApp
//
//  Created by Venkatesh Jujjavarapu on 10/22/15.
//  Copyright © 2015 sitacorp. All rights reserved.
//

#import "EntryCell.h"
#import "DiaryEntry+CoreDataProperties.h"
@implementation EntryCell

//- (void)awakeFromNib {
//    // Initialization code
//   // [self.contentView.superview setClipsToBounds:NO];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCellForEntry:(DiaryEntry *)entry {
    
    
    
    self.bodyLabel.text = entry.body;
    self.locationLabel.text = entry.location;
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    
    
    [dateFormatter setDateFormat:@"EEEE MMMM dd yyyy"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:entry.date];
    
    self.dateLabel.text = [dateFormatter stringFromDate:date];
    
    
    self.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.mainImageView.layer.cornerRadius = CGRectGetWidth(self.mainImageView.frame)/2.0f;
    
    
    if(entry.imageData)
    {
        
        self.mainImageView.image = [UIImage imageWithData:entry.imageData]
        ;
        
    }else {
        
        self.mainImageView.image = [UIImage imageNamed:@"icn_noimage"];
    }
    
    
    if(entry.mood == DiaryEntryMoodGood)
    {
        self.moodImageView.image = [UIImage imageNamed:@"icn_happy"];
    }else if(entry.mood == DiaryEntryMoodBad)
    {
        self.moodImageView.image = [UIImage imageNamed:@"icn_bad"];
        
    }else if(entry.mood == DiaryEntryMoodAverage)
    {
        self.moodImageView.image = [UIImage imageNamed:@"icn_average"];
        
    }else {
        self.moodImageView.image = [UIImage imageNamed:@"icn_happy"];
    }
    
    
    if(entry.location.length > 0)
    {
          self.locationLabel.text = entry.location;
        
    }else {
      self.locationLabel.text= @"Location information is unavailable!";

    }
    
     
}



@end
