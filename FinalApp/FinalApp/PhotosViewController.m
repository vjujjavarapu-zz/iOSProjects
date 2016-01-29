//
//  PhotosViewController.m
//  FinalApp
//
//  Created by Venkatesh Jujjavarapu on 10/28/15.
//  Copyright © 2015 sitacorp. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoCell.h"
#import "DetailViewController.h"
#import "PresentDetailTransition.h"
#import "DismissDetailTransition.h"
//access token 1933463454.7e0cc96.c3f1652b02f64ec6b66371fd718d7386

#import <SimpleAuth/SimpleAuth.h>

@interface PhotosViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic) NSString *accessToken;
@property (nonatomic) NSArray *photos;
@end

@implementation PhotosViewController

-(instancetype)init {
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(124.0, 124.0);
    
    
    layout.minimumInteritemSpacing = 1.0;
    
    layout.minimumLineSpacing = 1.0;

    return (self = [super initWithCollectionViewLayout:layout]);
    
  
    
}


-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Final App";
    
    [self.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"photo"];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.accessToken = [userDefaults objectForKey:@"accessToken"];

    if(self.accessToken == nil)
    
    {
        
    // Instagram Signin - Step 2 
    [SimpleAuth authorize:@"instagram" completion:^(NSDictionary *responseObject, NSError *error) {
       // NSLog(@"%@",responseObject);
        
        self.accessToken = responseObject[@"credentials"][@"token"];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        [userDefaults setObject:self.accessToken forKey:@"accessToken"];
        
        [userDefaults synchronize];
        
        [self refresh];
  
    }];
    
    } else {
       // NSLog(@"User Already Signed In");
        [self refresh];
    }
}
-(void)refresh {
        
        // sharedSession - singleton session object!
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSString *urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/goldengatebridge/media/recent?access_token=%@",self.accessToken];
        
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
     
            
             NSData *data = [NSData dataWithContentsOfURL:location options:kNilOptions error:nil];
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            self.photos = [responseDictionary valueForKeyPath:@"data"];
            
         //   NSLog(@"self.photos = %@",self.photos);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        
        }];
        
        [task resume];
        
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
        return self.photos.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    
    
    cell.backgroundColor = [UIColor lightGrayColor];
    
//    cell.photo = [self.photos objectAtIndex:indexPath.row];
   
    cell.photo = self.photos[indexPath.row];
    
    
    return cell;
   
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

   NSDictionary *photo = self.photos[indexPath.row];
    
    DetailViewController *detailViewController = [[DetailViewController alloc]init];
    
    // Lines  146 and 148 - UIViewControllerTransition
    // and include the protocol UIViewControllerTransitioningDelegate

    detailViewController.modalPresentationStyle = UIModalPresentationCustom;
    
    detailViewController.transitioningDelegate = self;
    
    detailViewController.photo = photo;
    
    [self presentViewController:detailViewController animated:YES completion:nil];

    
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [[PresentDetailTransition alloc]init];

}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[DismissDetailTransition alloc]init];
}





@end
