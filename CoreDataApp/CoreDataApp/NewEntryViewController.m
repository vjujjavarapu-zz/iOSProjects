//
//  SecondViewController.m
//  CoreDataApp
//
//  Created by Venkatesh Jujjavarapu on 10/20/15.
//  Copyright © 2015 sitacorp. All rights reserved.
//

#import "NewEntryViewController.h"
#import "CoreDataStack.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#import "DiaryEntry+CoreDataProperties.h"
@interface NewEntryViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, assign) enum DiaryEntryMood pickedMood;
@property (nonatomic, strong) UIImage *pickedImage;

@property (weak, nonatomic) IBOutlet UIButton *badButton;
@property (weak, nonatomic) IBOutlet UIButton *averageButton;

@property (weak, nonatomic) IBOutlet UIButton *goodButton;

@property (strong, nonatomic) IBOutlet UIView *accessoryView;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@property (strong, nonatomic) NSString *locationString;

// Core Location
@property (strong, nonatomic) CLLocationManager *locationManager;



@end

@implementation NewEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSDate *date;
    
    
    if(self.entry!=nil)
    {
        
        self.textView.text = self.entry.body;
        self.pickedMood = self.entry.mood;
        date = [NSDate dateWithTimeIntervalSince1970:self.entry.date];
        self.pickedImage = [UIImage imageWithData:self.entry.imageData];
        
    }else {
        // By Default the Mood is good !
        self.pickedMood = DiaryEntryMoodGood;
        date = [NSDate date];
        [self loadLocation];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"EEEE, MMMM dd yyyy"];
    
    self.dateLabel.text = [dateFormatter stringFromDate:date];
    
    self.textView.inputAccessoryView = self.accessoryView;
    
    self.imageButton.contentMode = UIViewContentModeScaleAspectFill;
    
    self.imageButton.layer.cornerRadius = CGRectGetWidth(self.imageButton.frame)/2.0f;
    
    
}

-(void)loadLocation {
    
    self.locationManager = [[CLLocationManager alloc]init];
    
    self.locationManager.delegate = self;
    
    
    if(IS_OS_8_OR_LATER)
    {
        [self shouldRequestLocation];
    }
    
    
    self.locationManager.activityType = CLActivityTypeOtherNavigation;
    
    
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    
    
    self.locationManager.pausesLocationUpdatesAutomatically = YES;

    
    [self.locationManager startUpdatingLocation];
    
}


-(void)shouldRequestLocation {
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    [self.locationManager requestWhenInUseAuthorization];
    
    
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"Always");
            break;
        case kCLAuthorizationStatusDenied:
          
            NSLog(@"Denied");
            [self.locationManager requestWhenInUseAuthorization];
         //   [self showAlert];
            break;
        case kCLAuthorizationStatusRestricted:
            [self.locationManager requestWhenInUseAuthorization];
            NSLog(@"restricted");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"When in Use");
            break;
        case kCLAuthorizationStatusNotDetermined:
            [self.locationManager requestWhenInUseAuthorization];
            NSLog(@"Not Determined");
            break;
        default:
          
            break;
    }
    
    
    
    
    
    
    
    
}

-(void)showAlert {
    
    UIAlertController *locationAlert = [UIAlertController alertControllerWithTitle:@"Location Denied" message:@"Please give me your location" preferredStyle:UIAlertControllerStyleAlert];
    

    UIAlertAction *OK = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openSettings];
    }];
    
    UIAlertAction *Cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
    [locationAlert addAction:OK];
    
    [locationAlert addAction:Cancel];
    
    
    [self presentViewController:locationAlert animated:YES completion:nil];
    
    
    
}



-(void)openSettings {
    
    NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:settingsURL];
}



-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.textView becomeFirstResponder];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setPickedMood:(enum DiaryEntryMood)pickedMood {
    
    
    _pickedMood = pickedMood;
    
    
    self.badButton.alpha = 0.5f;
    self.averageButton.alpha = 0.5f;
    self.goodButton.alpha = 0.5f;
    
    switch (pickedMood) {
        case DiaryEntryMoodGood:
            self.goodButton.alpha = 1.0f;
            break;
        case DiaryEntryMoodAverage:
            self.averageButton.alpha = 1.0f;
            break;
        case DiaryEntryMoodBad:
            self.badButton.alpha = 1.0f;
            break;
        default:
            break;
    }
    
}


- (IBAction)doneWasPressed:(id)sender {
    
    if(self.entry!=nil)
    {
        // Updating an existing entry ; entry entity has something
        [self updateDiaryEntry];
    }
    else {
        // Inserting a new Entry
        [self insertDiaryEntry];
    
    }
    [self dismissSelf];
    
    
}

-(void)updateDiaryEntry {
    
    // Modified Text from the same entry! and inserting it to the entry body!
    self.entry.body = self.textView.text;
    
    self.entry.mood = self.pickedMood;
    
    self.entry.imageData = UIImageJPEGRepresentation(self.pickedImage, 0.75);
    
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    
    [coreDataStack saveContext];
    
}



- (IBAction)cancelWasPressed:(id)sender {
    
    [self dismissSelf];
    
}

-(void)dismissSelf {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)insertDiaryEntry{
    
    // Accessing the defaultStack Singleton
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    
    DiaryEntry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"DiaryEntry" inManagedObjectContext:coreDataStack.managedObjectContext];
    
    
    if([self.textView.text isEqualToString:@""])
    {
        
        NSString *spaceString = @"You have not entered anything in your personal diary";
        self.textView.text = spaceString;
        
    }
    
    
    entry.body = self.textView.text;

    entry.date = [[NSDate date]timeIntervalSince1970];
    
    entry.mood = self.pickedMood;
    
    
    entry.imageData = UIImageJPEGRepresentation(self.pickedImage, 0.75);
    
    entry.location = self.locationString;
    
    [coreDataStack saveContext];
    
    
    
    
}

- (IBAction)badWasPressed:(id)sender {
    
    self.pickedMood = DiaryEntryMoodBad;
}


- (IBAction)averageWasPressed:(id)sender {
    self.pickedMood = DiaryEntryMoodAverage;
}


- (IBAction)goodWasPressed:(id)sender {
    self.pickedMood = DiaryEntryMoodGood;
}


- (IBAction)imageButtonWasPressed:(id)sender {
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        [self promptForSource];
        
        
    }else {
        [self promptFromPhotoLibrary];
    }
 
    
}

-(void)promptForSource {
    
    
    // iOS 9 update / alertView/actionSheet Deprecated!
    UIAlertController *sourceAlert = [UIAlertController alertControllerWithTitle:@"ImageSource" message:@"Pick an Image Source" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self promptFromCamera];
    }];
    
    UIAlertAction *photoLibrary = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self promptFromPhotoLibrary];
    }];
    
    [sourceAlert addAction:camera];
    [sourceAlert addAction:photoLibrary];
    
    
    [self presentViewController:sourceAlert animated:YES completion:nil];
    
   
}



-(void)promptFromCamera {
 
    
    UIImagePickerController *imController = [[UIImagePickerController alloc]init];
    
    imController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    imController.delegate = self;
    
    [self presentViewController:imController animated:YES completion:nil];
    
    
}

-(void)promptFromPhotoLibrary {
    
    UIImagePickerController *imController = [[UIImagePickerController alloc]init];
    
    imController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imController.delegate = self;
    
    [self presentViewController:imController animated:YES completion:nil];
  
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    
    UIImage *image= info[UIImagePickerControllerOriginalImage];
    
    self.pickedImage = image;
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
   
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    

    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


-(void)setPickedImage:(UIImage *)pickedImage {
    
    
    _pickedImage = pickedImage;
    
    
    if(pickedImage == nil)
    {
        [self.imageButton setImage:[UIImage imageNamed:@"icn_noimage"] forState:UIControlStateNormal];
    }else {
        [self.imageButton setImage:pickedImage forState:UIControlStateNormal];
    }
    
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    
    
    CLLocation *location = locations.lastObject;
   
//    [self.locationManager stopUpdatingLocation];

    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
      
        CLPlacemark *placemark = [placemarks firstObject];
        
        if(error==nil && [placemarks count]>0)
        {
            self.locationString = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                             placemark.subThoroughfare, placemark.thoroughfare,
                             placemark.postalCode, placemark.locality,
                             placemark.administrativeArea,
                             placemark.country];
            
            NSLog(@"Final Location %@",self.locationString);
        }
        
        

        
        
    }];
    
    
    
    
    
    
    
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    
    NSLog(@"Core Location Failed with error %@",error);
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
