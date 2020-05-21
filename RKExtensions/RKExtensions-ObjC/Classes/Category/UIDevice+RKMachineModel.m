//
//  UIDevice+RKMachineModel.m
//  RKExtensions-ObjC
//
//  Created by 李沛倬 on 2018/10/31.
//  Copyright © 2018 peizhuo. All rights reserved.
//

#import "UIDevice+RKMachineModel.h"
#import <sys/sysctl.h>
#import <sys/utsname.h>
#import <mach/vm_statistics.h>
#import <mach/machine.h>
#import <mach/task.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@implementation UIDevice (RKMachineModel)

// MARK: - Getter & Setter

- (NSString *)machineModel {
    NSString *correspondVersion = [self getDeviceVersion];
    
    if ([correspondVersion.lowercaseString containsString:@"iphone"]) {        // iPhone
        
        return [self iPhoneMachineModel:correspondVersion];
    } else if ([correspondVersion.lowercaseString containsString:@"ipad"]) {   // iPad
        
        return [self iPadMachineModel:correspondVersion];
    } else if ([correspondVersion.lowercaseString containsString:@"ipod"]) {   // iPod Touch
        
        return [self iPodMachineModel:correspondVersion];
    }
    
    /**************************************Simulator****************************************/
    
    if ([correspondVersion isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([correspondVersion isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    
    return correspondVersion;
}

- (NSString *)internalModel {
    return [self getDeviceVersion];
}

- (NSString *)storage {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSInteger romBytes = [fattributes[NSFileSystemSize] integerValue];
    
    NSString *rom = @(ceil(romBytes/1000/1000/1000.0)).stringValue;
    
    return [rom stringByAppendingString:@"GB"];
}

- (CGFloat)totalDiskSpace {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSInteger romBytes = [fattributes[NSFileSystemSize] integerValue];
    
    return romBytes / 1024 / 1024.0;
}

- (CGFloat)freeDiskSpace {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSInteger freeRomBytes =[fattributes[NSFileSystemFreeSize] integerValue];
    
    return freeRomBytes / 1024 / 1024.0;
}

- (NSString *)memory {
    
    NSUInteger m = ceil([self getSysInfo:HW_PHYSMEM] / 1024 / 1024 / 1024.0);
    
    return [@(m).stringValue stringByAppendingString:@"GB"];
}

- (NSString *)CPU {
    NSMutableString *cpu = [[NSMutableString alloc] init];
    size_t size;
    cpu_type_t type;
    cpu_subtype_t subtype;
    size = sizeof(type);
    sysctlbyname("hw.cputype", &type, &size, NULL, 0);
    
    size = sizeof(subtype);
    sysctlbyname("hw.cpusubtype", &subtype, &size, NULL, 0);
    
    if (type == CPU_TYPE_X86)
    {
        [cpu appendString:@"x86"];
        
    } else if (type == CPU_TYPE_ARM)
    {
        [cpu appendString:@"ARM"];
        [cpu appendFormat:@",Type:%d",subtype];
    } else if (type == CPU_TYPE_ARM64) {
        
        
    }
    
    
    return cpu;
}

- (NSString *)telephonyInfo {
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    NSString *mCarrier = [NSString stringWithFormat:@"%@", carrier ? [carrier carrierName] : @"unknown"];
    
    return mCarrier;
}

- (NSString *)deviceColor {
    
    return [self deviceColorWithKey:@"DeviceColor"];
}

- (NSString *)deviceEnclosureColor {
    
    return [self deviceColorWithKey:@"DeviceEnclosureColor"];
}

// MARK: - Private Method

- (NSString *)deviceColorWithKey:(NSString *)key {
    SEL selector = NSSelectorFromString(@"_deviceInfoForKey:");
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if ([self respondsToSelector:selector]) {
        return [self performSelector:selector withObject:key];
    }
#pragma clang diagnostic pop
    
    return @"";
}

+ (NSString *)getDeviceVersionInfo {
    
    return [self getDeviceVersionInfoByName:"hw.machine"];
}

+ (NSString *)getDeviceVersionInfoByName:(char *)typeSpecifier {
    size_t size;
    
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
    
    free(answer);
    
    return results;
}

- (NSUInteger)getSysInfo:(uint)typeSpecifier {
    size_t size = sizeof(int);
    
    long results;
    
    int mib[2] = {CTL_HW, typeSpecifier};
    
    sysctl(mib, 2, &results, &size, NULL, 0);
    
    return (NSUInteger)results;
}

- (NSString *)getDeviceVersion {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithFormat:@"%s", systemInfo.machine];
    
    return platform;
}


- (NSString *)iPhoneMachineModel:(NSString *)correspondVersion {
    NSDictionary *originDic = [self dataSourceDictionary];
    NSDictionary *iPhoneDic = originDic[@"iPhone"];
    
    NSString *machineModel = iPhoneDic[correspondVersion];
    
    return machineModel;
}

- (NSString *)iPadMachineModel:(NSString *)correspondVersion {
    NSDictionary *originDic = [self dataSourceDictionary];
    NSDictionary *iPadDic = originDic[@"iPad"];
    
    NSString *machineModel = iPadDic[correspondVersion];
    
    return machineModel;
}

- (NSString *)iPodMachineModel:(NSString *)correspondVersion {
    NSDictionary *originDic = [self dataSourceDictionary];
    NSDictionary *iPodDic = originDic[@"iPod"];
    
    NSString *machineModel = iPodDic[correspondVersion];
    
    return machineModel;
}

- (NSDictionary *)dataSourceDictionary {
    NSString *filepath = [NSBundle.mainBundle pathForResource:@"iOS MachineModel" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    
    if (data.length == 0) { return nil; }
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    return dic;
}



@end
