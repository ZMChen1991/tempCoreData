//
//  Student+CoreDataProperties.m
//  tempCoreData
//
//  Created by lm on 2018/7/26.
//  Copyright © 2018年 CocaCola. All rights reserved.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Student"];
}

@dynamic name;
@dynamic age;

@end
