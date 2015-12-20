//
//  SecondViewController.h
//  CoreDataApp
//
//  Created by Venkatesh Jujjavarapu on 10/20/15.
//  Copyright © 2015 sitacorp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class DiaryEntry;
@interface NewEntryViewController : UIViewController
@property (strong, nonatomic) DiaryEntry *entry;
@end
