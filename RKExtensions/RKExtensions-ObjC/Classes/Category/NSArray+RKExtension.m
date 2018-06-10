//
//  NSArray+RKExtension.m
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/6/3.
//  Copyright © 2018年 peizhuo. All rights reserved.
//

#import "NSArray+RKExtension.h"


@implementation NSArray (RKExtension)

- (NSString *)description {
    
    NSMutableString *str = [NSMutableString stringWithString:@"[\n"];
    for (id obj in self) {
        if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]]) {
            [str appendFormat:@"\t%@,\n", [obj description]];
        } else {
            [str appendFormat:@"\t\"%@\",\n", obj];
        }
    }
    
    if ([str hasSuffix:@",\n"]) {
        [str replaceCharactersInRange:NSMakeRange(str.length - 2, 2) withString:@"\n"];
    }
    
    [str appendString:@"]"];
    
    return str;
}

@end



@implementation NSDictionary (RKExtension)

- (NSString *)description {
    
    NSArray *allKeys = [self allKeys];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\n"];
    for (NSString *key in allKeys) {
        id value= self[key];
        if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
            [str appendFormat:@"\t\"%@\" : %@,\n",key, [value description]];
        } else {
            [str appendFormat:@"\t\"%@\" : \"%@\",\n",key, value];
        }
    }
    
    if ([str hasSuffix:@",\n"]) {
        [str replaceCharactersInRange:NSMakeRange(str.length - 2, 2) withString:@"\n"];
    }
    
    [str appendString:@"}"];
    
    return str;
    
}

@end
