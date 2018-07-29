//
//  CoreDataManager.m
//  tempCoreData
//
//  Created by lm on 2018/7/26.
//  Copyright © 2018年 CocaCola. All rights reserved.
//

#import "CoreDataManager.h"
//#import "AppDelegate.h"

static CoreDataManager *instance = nil;

@implementation CoreDataManager

+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataManager alloc] init];
    });
    return instance;
}

- (NSManagedObjectModel *)model {
    
    if (!_model) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"tempCoreData" withExtension:@"mom"];
        if (!modelURL) {
            modelURL = [[NSBundle mainBundle] URLForResource:@"tempCoreData" withExtension:@"momd"];
        }
        _model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _model;
}

- (NSPersistentStoreCoordinator *)coordinator {
    
    if (!_coordinator) {
        _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model];
        NSURL *path = [[self applicationDocument] URLByAppendingPathComponent:@"tempCoreData.sqlite"];
        NSError *error;
        [_coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:path options:nil error:&error];
        if (error) {
            NSLog(@"failed is not create NSPersistentStoreCoordinator :%@",error);
        }
    }
    return _coordinator;
}

- (NSURL *)applicationDocument {
    
    NSURL *path = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    NSLog(@"path:%@", path);
    return path;
}

- (NSManagedObjectContext *)context {
    
    if (!_context) {
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _context.persistentStoreCoordinator = self.coordinator;
    }
    return _context;
}

@end
