//
//  DetailViewController.m
//  FinalApp
//
//  Created by Venkatesh Jujjavarapu on 10/29/15.
//  Copyright © 2015 sitacorp. All rights reserved.
//

#import "DetailViewController.h"
#import "PhotoController.h"
@interface DetailViewController ()
// class extension/ private variable declaration
@property (nonatomic) UIImageView *imageView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.95];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, -320.f, 320.0f, 320.0f)];
   
    [self.view addSubview:self.imageView];

    
    [PhotoController imageForPhoto:self.photo size:@"standard_resolution" completion:^(UIImage *image) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
           self.imageView.image = image;;
       });

    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    
    [self.view addGestureRecognizer:tap];
    
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    

}
-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    UISnapBehavior *snap = [[UISnapBehavior alloc]initWithItem:self.imageView snapToPoint:self.view.center];
    
    [self.animator addBehavior:snap];
    
}


-(void)close {
    
    [self.animator removeAllBehaviors];
    
    UISnapBehavior *snap = [[UISnapBehavior alloc]initWithItem:self.imageView snapToPoint:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds)+180.0f)];
    
    
    [self.animator addBehavior:snap];
    
  
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
