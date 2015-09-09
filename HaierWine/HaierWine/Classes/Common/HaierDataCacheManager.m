//
//  HaierDataCacheManager.m
//  HaierWine
//
//  Created by leon on 9/4/14.
//
//

#import "HaierDataCacheManager.h"
#import "ITTObjectSingleton.h"

@implementation HaierDataCacheManager

ITTOBJECT_SINGLETON_BOILERPLATE(HaierDataCacheManager, sharedManager)

- (BOOL)isHaveDataWithKey:(NSString *)key
{
    return [[ITTDataCacheManager sharedManager] hasObjectInCacheByKey:key];
}

- (void)addData:(NSArray *)data WithKey:(NSString *)key
{
    [self addDetailKey:key];
    [[ITTDataCacheManager sharedManager] addObject:data forKey:key];
}

- (void)addDetailKey:(NSString *)key
{
    NSMutableArray *data = [NSMutableArray array];
    NSArray *array;
    if ([self isHaveDataWithKey:@"HaierDetail"]) {
        array = [NSArray arrayWithArray:[self getDataWithKey:@"HaierDetail"]];
        [data addObjectsFromArray:array];
        [data addObject:key];
        [[ITTDataCacheManager sharedManager] addObject:data forKey:@"HaierDetail"];

//        [self addData:data WithKey:@"HaierDetail"];
//        NSLog(@"%@",data);
    } else {
        array = [NSArray arrayWithObject:key];
        [[ITTDataCacheManager sharedManager] addObject:array forKey:@"HaierDetail"];
//        NSLog(@"%@",array);
    }
}

- (NSArray *)getDataWithKey:( NSString *)key
{    
    return [[ITTDataCacheManager sharedManager] getCachedObjectByKey:key];
}

- (void)removeAllData
{
    if ([self isHaveDataWithKey:@"HaierDetail"]) {
        NSArray *array = [NSArray arrayWithArray:[self getDataWithKey:@"HaierDetail"]];
       //   NSLog(@"*&^(*^%@",[array description]);
        
        for (int i = 0; i<array.count; i++) {
            [[ITTDataCacheManager sharedManager] removeObjectInCacheByKey:[NSString stringWithFormat:@"%@",array[i]]];
        }
        [[ITTDataCacheManager sharedManager] removeObjectInCacheByKey:[NSString stringWithFormat:@"%@",@"HaierDetail"]];
    }
}

@end
