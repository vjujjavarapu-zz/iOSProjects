//
//  PhotoController.m
//  FinalApp
//
//  Created by Venkatesh Jujjavarapu on 10/29/15.
//  Copyright © 2015 sitacorp. All rights reserved.
//

#import "PhotoController.h"
#import <SAMCache/SAMCache.h>

@implementation PhotoController

+(void)imageForPhoto: (NSDictionary *)photo size : (NSString *)size completion:(void (^)(UIImage *image))completion {

    if(photo == nil || size == nil || completion == nil)
    
    {
        
        return;
        
    }

    NSString *key = [[NSString alloc]initWithFormat:@"%@-%@",photo[@"id"],size];
    
    // Accessing the image from the SAMCache
    UIImage *image = [[SAMCache sharedCache] imageForKey:key];
    
    if(image)
    {
        // Passing the image back to the completion block so that any class which uses this class method can set this image to any UI Object
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(image);;
        });
        
    }
    else {
    
        NSURL *url = [[NSURL alloc]initWithString:photo[@"images"][size][@"url"]];
        
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSData *data = [NSData dataWithContentsOfURL:location];
            
            UIImage *image = [UIImage imageWithData:data];
            
            // Saving the image to the Cache
            [[SAMCache sharedCache]setImage:image forKey:key];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image);
            });
  
        }];
       [task resume];
        
        
    }

    
}




@end
