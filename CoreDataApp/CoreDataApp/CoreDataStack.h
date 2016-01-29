//
//  CoreDataStack.h
//  CoreDataApp
//
//  Created by Venkatesh Jujjavarapu on 10/20/15.
//  Copyright © 2015 sitacorp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CoreDataStack : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

// Singleton Method
+(instancetype)defaultStack;



@end
