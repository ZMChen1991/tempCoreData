//
//  AppDelegate.h
//  tempCoreData
//
//  Created by lm on 2018/7/26.
//  Copyright © 2018年 CocaCola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

