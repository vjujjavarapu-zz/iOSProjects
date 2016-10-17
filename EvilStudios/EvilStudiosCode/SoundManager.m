//
//  SoundManager.m
//  EvilStudiosCode
//
//  Created by Venkatesh Jujjavarapu on 1/28/16.
//  Copyright © 2016 Venkatesh Jujjavarapu. All rights reserved.
//

#import "SoundManager.h"

@implementation SoundManager


+(instancetype)sharedManager {
    
    static SoundManager *soundManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        soundManager = [[self alloc]init];
    });
   return soundManager;
    
}

-(id) init {
    
    self = [super init];
    
    if(self) {
        
    
        _songsCollection = [NSMutableArray arrayWithObjects:@"achievement.wav",@"ahh-nicely.mp3",@"boo.mp3", @"bubble.wav",@"bubble1.wav", @"cake-full.aif", @"chat_incoming.mp3", @"click0.mp3", @"click1.mp3", @"doom.mp3", @"drumroll.mp3", @"elevator-badspeakers.mp3", @"gavel.mp3", @"ho.mp3", @"laser-prep-reverse.mp3", @"laser-prep.mp3", @"ninja-sword.mp3", @"ninja-whack.mp3",@"ninja-whoosh.mp3",@"notice.mp3", @"sad-trombone.aiff",@"select-classic.wav",@"small-applause.mp3",@"sonar.mp3",@"start-echo.mp3",@"whoosh.mp3", nil];
        
        _currentSongIndex = 0;
        
        _repeat = NO; 
        
      
    }
    return self;
}


-(void)playCurrentSong {
    
    
    NSError *error;
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:[self.songsCollection objectAtIndex:self.currentSongIndex] ofType:nil]] error:&error];

    if(error !=nil){
     NSLog(@"%@",error);
    
    }else {
        self.currentSongName = @"";
        
        [self.audioPlayer setDelegate:self];
        [self.audioPlayer prepareToPlay];
        self.currentSongName = [self.songsCollection objectAtIndex:self.currentSongIndex];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"playingNewSong" object:nil userInfo:[NSDictionary dictionaryWithObject:self.currentSongName forKey:@"newSong"]];
        [self.audioPlayer play];
        self.currentSongIndex++;
        
    }
    

}
    

// Audio Player Delegate

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    self.currentSongIndex = self.currentSongIndex++  % [self.songsCollection count];
    [self playCurrentSong];
    
}

-(void)pauseCurrentSong {
    
    
    if([self.audioPlayer isPlaying]){
        [self.audioPlayer pause];
    }else {
        [self.audioPlayer play];
    }
    

}


-(void)repeatSong {
    
    self.audioPlayer.numberOfLoops = -1;
    
    self.repeat = YES;
}

-(void)resumeSong {
    self.audioPlayer.numberOfLoops = 0;
    self.repeat = NO; 
}



-(CGFloat)computeProgress {
    
    CGFloat progress = (self.audioPlayer.currentTime / self.audioPlayer.duration);
    
    CGFloat value = floor(progress * 100);
    
    return value;
    
}







@end
