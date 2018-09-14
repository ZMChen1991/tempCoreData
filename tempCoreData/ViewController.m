//
//  ViewController.m
//  tempCoreData
//
//  Created by lm on 2018/7/26.
//  Copyright © 2018年 CocaCola. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataManager.h"
#import "Student+CoreDataClass.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    self.context = delegate.persistentContainer.viewContext;
    
    CoreDataManager *manager = [CoreDataManager shareInstance];
    self.context = manager.context;
    

    [self addAttributes];
    [self fetchData];
}

- (void)test {
    
// 初始化上下文，创建目标对象
// 设置目标对象属性
// 传入上下文，创建一个NSManagedObject对象
// 利用上下文对象，将数据同步到持久化存储库

// 第一种
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    self.context = delegate.persistentContainer.viewContext;
// 第二种
//CoreDataManager *manager = [CoreDataManager shareInstance];
//self.context = manager.context;

//    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:context];
//    NSLog(@"manageObject : %@", student);
//
//    [student setName:@"xiaoxi"];
//    [student setAge:21];
//
NSError *error;
//    BOOL success = [context save:&error];
//    if (success == 0) {
//        NSLog(@"数据保存失败！:%@", error);
//    } else {
//        NSLog(@"数据保存成功！");
//    }

//    // 查询数据
//    // 初始化查询请求
//    // 设置排序
//    // 设置条件过滤
//    // 执行请求
//    // 遍历数据
NSFetchRequest *request = [[NSFetchRequest alloc] init];
request.entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.context];
NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
request.sortDescriptors = [NSArray arrayWithObject:sort];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"xiaoming"];
//    request.predicate = predicate;
NSArray *objects = [self.context executeFetchRequest:request error:&error];
if (error) {
    NSLog(@"查询失败！");
} else {
    NSLog(@"objects :%lu ", (unsigned long)[objects count]);
    for (Student *obj in objects) {
        NSLog(@"name:%@--age:%d ", obj.name, obj.age);
    }
}
}

// 添加
- (void)addAttributes {
    
    // 传入上下文，创建一个NSManagedObject对象
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.context];
    // 添加属性
    [student setName:@"x明月几时有，把酒问青天，不知天上宫阙，今夕是何年！"];
    [student setAge:23];

    // 利用上下文对象，将数据同步到持久化存储库
    NSError *error;
    BOOL success = [self.context save:&error];
    if (success == 0) {
        NSLog(@"数据保存失败！:%@", error);
    } else {
        NSLog(@"数据保存成功！");
    }
}

// 删除
- (void)deleteAttributes {
    // 创建删除请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    // 删除条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", @"xiaoxi"];
    request.predicate = predicate;
    
    // 返回需要删除的对象数组
    NSError *error = nil;
    NSArray *deleteArray = [self.context executeFetchRequest:request error:&error];
    
    // 从数据库中删除
    [deleteArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.context deleteObject:obj];
    }];
    // 保存数据
    if (self.context.hasChanges) {
        [self.context save:nil];
    }
    
}
// 修改
- (void)updateAttributes {
    
    // 创建查询请求
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    // 修改的条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age = %@", @"21"];
    request.predicate = predicate;
    
    // 发送请求
    NSError *error = nil;
    NSArray *updateArray = [self.context executeFetchRequest:request error:&error];
    // 修改
    [updateArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setAge:23];
    }];
    
    // 保存
    if (self.context.hasChanges) {
        [self.context save:nil];
    }
}

// 查询
- (void)fetchData {
    
    // 初始化查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.context];
    // 设置排序--通过年龄进行升序排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    // 设置条件过滤
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"xiaoxi"];
//    request.predicate = predicate;
    // 执行请求
    NSError *error;
    NSArray *objects = [self.context executeFetchRequest:request error:&error];
    NSLog(@"%@", objects);
    if (error) {
        NSLog(@"查询失败！");
    } else {
//        NSLog(@"objects :%@ ", objects);
        // 遍历数据
        for (Student *obj in objects) {
            NSLog(@"name:%@--age:%d ", obj.name, obj.age);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
