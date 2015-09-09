//
//  UserManager.m
//  HaierIceBox
//
//  Created by jeremy on 14-5-21.
//
//

#import "UserManager.h"
#import "ITTObjectSingleton.h"
@interface UserManager()
{
    NSMutableArray      *_userArray;

}

@end

@implementation UserManager
ITTOBJECT_SINGLETON_BOILERPLATE(UserManager, sharedUserManager);

- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSArray *)getAllUsers
{
            NSMutableArray * userArray = [[ITTDataCacheManager sharedManager] getCachedObjectByKey:KEY_CACHE_USER];
    if (userArray && userArray.count > 0) {
        return userArray;
    }else{
        return nil;
    }
}

- (UserModel *)getLastLoginUser
{
   NSArray * allUsers  = [self getAllUsers];
    if (allUsers && allUsers.count>0) {
        return [allUsers firstObject];
    }
    return nil;
}

- (void)addUser:(UserModel *)userModel
{
        NSMutableArray * userArray = [[ITTDataCacheManager sharedManager] getCachedObjectByKey:KEY_CACHE_USER];
    if (userArray && userArray.count>0) {
        BOOL isHave = NO;
        for (UserModel * model in userArray) {
            if ([model.account isEqual:userModel.account]) {
                isHave = YES;
//                NSUInteger index = [userArray indexOfObject:model];
                [userArray removeObject:model];
                [userArray insertObject:userModel atIndex:0];
//                [userArray replaceObjectAtIndex:index withObject:userModel];
                break;
            }
        }
        if (!isHave) {
            if (userArray.count == 3) {
                [userArray removeLastObject];
            }
            [userArray insertObject:userModel atIndex:0];
        }
        
    }else{
        userArray = [NSMutableArray arrayWithCapacity:3];
        [userArray addObject:userModel];
    }
    [[ITTDataCacheManager sharedManager] addObject:userArray forKey:KEY_CACHE_USER];
}

- (void)removeUserAtIndex:(NSInteger)index
{
    if (index >=0 && index <=2) {
        NSMutableArray * userArray = [[ITTDataCacheManager sharedManager] getCachedObjectByKey:KEY_CACHE_USER];
        if (index > (userArray.count-1)) {
            ITTDINFO(@"Remove index beyond of userArray bouce");
            return;
        }
        [userArray removeObjectAtIndex:index];
        [[ITTDataCacheManager sharedManager] addObject:userArray forKey:KEY_CACHE_USER];
    }else{
        ITTDINFO(@"Remove user error");
        return;
    }
}


@end
