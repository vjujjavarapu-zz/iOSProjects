//
//  PhotoCell.h
//  FinalApp
//
//  Created by Venkatesh Jujjavarapu on 10/28/15.
//  Copyright © 2015 sitacorp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic) NSDictionary *photo;
@end
