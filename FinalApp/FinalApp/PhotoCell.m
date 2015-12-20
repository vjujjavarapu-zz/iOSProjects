//
//  PhotoCell.m
//  FinalApp
//
//  Created by Venkatesh Jujjavarapu on 10/28/15.
//  Copyright © 2015 sitacorp. All rights reserved.
//

#import "PhotoCell.h"
#import "PhotosViewController.h"
#import "PhotoController.h"

#import <SAMCache/SAMCache.h>

@implementation PhotoCell

-(id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];

    if(self)
    {
        
        self.imageView = [[UIImageView alloc]init];
     
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(like)];
        
        tap.numberOfTapsRequired = 2;


        [self addGestureRecognizer:tap];
        
        [self.contentView addSubview:self.imageView];
        
        
    }
   return self;

}

-(void)like {

    
    
    UIAlertController *likeAlert = [UIAlertController alertControllerWithTitle:@"Liked" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIViewController *topViewController = [UIApplication sharedApplication].keyWindow.rootViewController;


    [topViewController presentViewController:likeAlert animated:YES completion:nil];
    
    double delayInSeconds = 2.0;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [likeAlert dismissViewControllerAnimated:YES completion:nil];
    });
   
}




-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.bounds; 
}

-(void)setPhoto:(NSDictionary *)photo {
    
    _photo = photo;
    
//    +(void)imageForPhoto: (NSDictionary *)photo size : (NSString *)size completion:(void (^)(UIImage *image))completion
    [PhotoController imageForPhoto:photo size:@"thumbnail" completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
    
}


@end
