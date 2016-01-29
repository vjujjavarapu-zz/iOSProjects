//
//  ViewController.m
//  EvilStudiosCode
//
//  Created by Venkatesh Jujjavarapu on 1/28/16.
//  Copyright © 2016 Venkatesh Jujjavarapu. All rights reserved.
//

#import "ViewController.h"
#import "SoundManager.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet MBCircularProgressBarView *mbProgressBarView;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *repeatButton;
@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.soundManager = [SoundManager sharedManager];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveSong:) name:@"playingNewSong" object:nil];
    
    
   
}

-(void)receiveSong:(NSNotification *)notification {
    
    self.currentSong = [[notification userInfo]valueForKey:@"newSong"];
    
    self.songNameLabel.text = self.currentSong;
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)playClicked:(id)sender {
    
   
    [self.soundManager playCurrentSong];
  
    [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    
}
- (IBAction)volumeSlide:(UISlider *)sender {
    
    [self.soundManager.audioPlayer setVolume:sender.value];
}

- (IBAction)pauseClicked:(id)sender {
    
    
    if([self.soundManager.audioPlayer isPlaying]){
        [self.soundManager.audioPlayer pause];
        [self.pauseButton setTitle:@"Resume" forState:UIControlStateNormal];
        [self.pauseButton setBackgroundColor:[UIColor colorWithRed:60.0/255.0 green:78.0/255.0 blue:109.0/255.0 alpha:1.0]];
     
    }else {
        
        [self.pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        [self.pauseButton setBackgroundColor:[UIColor redColor]];
        [self.soundManager.audioPlayer play];
        
    }

    
    
    
}

-(void)updateProgress {
 
    self.mbProgressBarView.value =  [self.soundManager computeProgress];
}


- (IBAction)repeatClicked:(id)sender {
    
    
        if([self.soundManager.audioPlayer isPlaying] && self.soundManager.repeat == NO)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.repeatButton.backgroundColor = [UIColor greenColor];
                [self.soundManager repeatSong];
                ;
            });

        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.repeatButton.backgroundColor = [UIColor lightGrayColor];
                [self.soundManager resumeSong];
            });
            
        }

}







@end
