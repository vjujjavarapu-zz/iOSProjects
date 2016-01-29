//
//  DiaryEntry+CoreDataProperties.m
//  CoreDataApp
//
//  Created by Venkatesh Jujjavarapu on 10/20/15.
//  Copyright © 2015 sitacorp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DiaryEntry+CoreDataProperties.h"

@implementation DiaryEntry (CoreDataProperties)

@dynamic date;
@dynamic body;
@dynamic imageData;
@dynamic mood;
@dynamic location;
//
-(NSString *)sectionName {
    

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"MMM yyyy"];
    
    
    return [dateFormatter stringFromDate:date];
    
  
    
    
}






@end
