//
//  PhotoController.h
//  FinalApp
//
//  Created by Venkatesh Jujjavarapu on 10/29/15.
//  Copyright © 2015 sitacorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PhotoController : NSObject

+(void)imageForPhoto: (NSDictionary *)photo size : (NSString *)size completion:(void (^)(UIImage *image))completion;

@end
