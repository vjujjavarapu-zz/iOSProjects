//
//  DiaryEntry+CoreDataProperties.h
//  CoreDataApp
//
//  Created by Venkatesh Jujjavarapu on 10/20/15.
//  Copyright © 2015 sitacorp. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DiaryEntry.h"

NS_ASSUME_NONNULL_BEGIN
// Enumerator for DiaryEntryMood
extern NS_ENUM(int16_t, DiaryEntryMood)
{
    DiaryEntryMoodGood = 0,
    DiaryEntryMoodAverage = 1,
    DiaryEntryMoodBad = 2
};


@interface DiaryEntry (CoreDataProperties)

@property (nonatomic) NSTimeInterval date;
@property (nullable, nonatomic, retain) NSString *body;
@property (nullable, nonatomic, retain) NSData *imageData;
@property (nonatomic) int16_t mood;
@property (nullable, nonatomic, retain) NSString *location;
@property (nonatomic, readonly) NSString *sectionName;
@end

NS_ASSUME_NONNULL_END
