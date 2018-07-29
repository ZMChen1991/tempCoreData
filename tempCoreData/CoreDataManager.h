//
//  CoreDataManager.h
//  tempCoreData
//
//  Created by lm on 2018/7/26.
//  Copyright © 2018年 CocaCola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManager : NSObject
// 上下文
@property (nonatomic, strong) NSManagedObjectContext *context;
// 模型
@property (nonatomic, strong) NSManagedObjectModel *model;
// 协调器
@property (nonatomic, strong) NSPersistentStoreCoordinator *coordinator;

+ (instancetype)shareInstance;

@end
