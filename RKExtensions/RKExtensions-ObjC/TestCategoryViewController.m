//
//  CategoryViewController.m
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/6/10.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import "TestCategoryViewController.h"

#import "NSString+RKExtension.h"

@interface TestCategoryViewController ()

@end

@implementation TestCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


// MARK: - IB Action

- (IBAction)arrayButtonAction:(UIButton *)sender {
    
//    [self testSafetyArray];
    
    [self testSafetyDictionary];
    
}


- (IBAction)viewButtonAction:(UIButton *)sender {
    
    
}


- (IBAction)stringButtonAction:(UIButton *)sender {
    
//    NSString *str = @"aBc123好啊=.;";
//    NSString *urlEncode = [str URLEncodeString];
    
    
    NSString *str = @"1A22b3C4D5E68F7G";
    
//    NSArray<NSTextCheckingResult *> *results = [str matchesOfRegex:@"\\d+"];
//    NSArray<NSString *> *results = [str componentsMatchedOfRegex:@"\\d+"];
//    NSLog(@"%@", results);
    
    
    NSString *result = [str stringByReplacingOccurencesOfRegex:@"\\d+" withString:@"😆"];
    NSLog(@"%@", result);
}



- (IBAction)dataButtonAction:(UIButton *)sender {
    
    
}




// MARK: - Array

- (void)testSafetyArray {
    
    NSArray *ary = @[@"123", @"234"];
    NSMutableArray *mAry = [[NSMutableArray alloc] init];
    
    NSString *str = nil;
    
    
    // 增
    [mAry addObject:str];
    [mAry insertObject:str atIndex:2];
    mAry[2] = str;
    
    
    // 删
    [mAry removeObjectAtIndex:2];
    
    
    // 改
    [mAry replaceObjectAtIndex:2 withObject:str];
    [mAry replaceObjectAtIndex:2 withObject:@""];
    [mAry replaceObjectAtIndex:0 withObject:str];
    
    
    // 查
    id obj1 = ary[2];
    id obj2 = [mAry objectAtIndex:1];
    NSLog(@"obj1: %@, obj2: %@", obj1, obj2);

}


// MARK: - Dictionary

- (void)testSafetyDictionary {
    
    NSDictionary *emptyDic = @{};
    NSDictionary *dic = @{@"key": @"value"};
    NSDictionary *multiDic = @{@"key1": @"value1", @"key2": @"value2"};
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *multiMDic = multiDic.mutableCopy;

    
    NSString *nilKey = nil;
    NSString *nilValue = nil;
    
    // 增
    [mDic setObject:nilValue forKey:nilKey];
    [mDic setObject:nilValue forKey:@""];
    [mDic setObject:@"value" forKey:nilKey];
    [mDic setObject:@"value" forKey:@"key"];

    mDic[@"key"] = nilValue;
    mDic[@"key"] = @"value";
    mDic[nilKey] = @"value";

    
    // 删
    [multiMDic removeObjectForKey:nilKey];
    
    
    // 改
    
    
    
    // 查
    id value = emptyDic[nilKey];
    value = dic[nilKey];
    value = multiMDic[nilKey];
    
}



@end




























