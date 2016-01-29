//
//  SoundManager.h
//  EvilStudiosCode
//
//  Created by Venkatesh Jujjavarapu on 1/28/16.
//  Copyright © 2016 Venkatesh Jujjavarapu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface SoundManager : NSObject<AVAudioPlayerDelegate>

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@property (strong, nonatomic) NSMutableArray *songsCollection;

+(instancetype)sharedManager;
-(void)playCurrentSong;
-(void)pauseCurrentSong;
-(CGFloat)computeProgress;
@property (nonatomic) NSInteger currentSongIndex;
@property (nonatomic) BOOL repeat;
@property (nonatomic) NSString *currentSongName; 
-(void)repeatSong;
-(void)resumeSong;
@end
