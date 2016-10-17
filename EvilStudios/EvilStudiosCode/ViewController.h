//
//  ViewController.h
//  EvilStudiosCode
//
//  Created by Venkatesh Jujjavarapu on 1/28/16.
//  Copyright © 2016 Venkatesh Jujjavarapu. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import <MBCircularProgressBar/MBCircularProgressBarView.h>
@class SoundManager;
@interface ViewController : UIViewController
@property (strong, nonatomic) SoundManager *soundManager;
@property (strong, nonatomic) NSString *currentSong;
@end

