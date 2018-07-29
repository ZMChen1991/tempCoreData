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
    
    // 初始化上下文，创建目标对象
    // 设置目标对象属性
    // 传入上下文，创建一个NSManagedObject对象
    // 利用上下文对象，将数据同步到持久化存储库
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.context = delegate.persistentContainer.viewContext;
    
    NSURL *path = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    NSLog(@"path:%@", path);
    
//    CoreDataManager *manager = [CoreDataManager shareInstance];
//    NSManagedObjectContext *context = manager.context;
//
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

- (void)addAttributes {
    
    // 传入上下文，创建一个NSManagedObject对象
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.context];
    NSLog(@"manageObject : %@", student);
    // 添加属性
    [student setName:@"xiaoxi"];
    [student setAge:21];

    // 利用上下文对象，将数据同步到持久化存储库
    NSError *error;
    BOOL success = [self.context save:&error];
    if (success == 0) {
        NSLog(@"数据保存失败！:%@", error);
    } else {
        NSLog(@"数据保存成功！");
    }
}

- (void)fetchData {
    
    // 初始化查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.context];
    // 设置排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    // 设置条件过滤
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"xiaoming"];
    request.predicate = predicate;
    // 执行请求
    NSError *error;
    NSArray *objects = [self.context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"查询失败！");
    } else {
//        NSLog(@"objects :%@ ", objects);
        // 遍历数据
        for (NSManagedObject *obj in objects) {
            NSLog(@"obj :%@ ", obj);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
