//
//  HaierDataCacheManager.h
//  HaierWine
//
//  Created by leon on 9/4/14.
//
//

#import <Foundation/Foundation.h>

@interface HaierDataCacheManager : NSObject

+ (HaierDataCacheManager *)sharedManager;

- (BOOL)isHaveDataWithKey:(NSString *)key;
- (void)addData:(NSArray *)data WithKey:(NSString *)key;
- (void)addDetailKey:(NSString *)key;
- (NSArray *)getDataWithKey:(NSString *)key;

- (void)removeAllData;

@end
