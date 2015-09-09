//
//  NewsReadCach.m
//  HaierWine
//
//  Created by 张作伟 on 14-10-11.
//
//

#import "ArticleReadCach.h"

@implementation ArticleReadCach

+(void)addReadedNews:(NSString *)articleId withType:(ArticleType)type
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ArticleReadCach"]==nil) {
        NSMutableDictionary *cachDict = [[NSMutableDictionary alloc]init];
        NSMutableArray *newsArray = [[NSMutableArray alloc]init];
        NSMutableArray *professionArray = [[NSMutableArray alloc]init];
        NSMutableArray *tasteArray = [[NSMutableArray alloc]init];
        [cachDict setObject:newsArray forKey:@"newsArray"];
        [cachDict setObject:professionArray forKey:@"professionArray"];
        [cachDict setObject:tasteArray forKey:@"tasteArray"];

        [[NSUserDefaults standardUserDefaults] setObject:cachDict forKey:@"ArticleReadCach"];
    }
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"ArticleReadCach"];
        NSMutableDictionary *cachDict = [NSMutableDictionary dictionaryWithDictionary:dict];
        switch (type) {
            case NewsArticle:
            {
                NSMutableArray *array = [NSMutableArray arrayWithArray:[cachDict objectForKey:@"newsArray"] ];
                if (![array containsObject:articleId]) {
                    [array addObject:articleId];
                }
                [cachDict setObject:array forKey:@"newsArray"];
            }
                break;
            case ProfessionArticle:
            {
                NSMutableArray *array = [NSMutableArray arrayWithArray:[cachDict objectForKey:@"professionArray"] ];
                if (![array containsObject:articleId]) {
                    [array addObject:articleId];
                }
                [cachDict setObject:array forKey:@"professionArray"];

            }
                break;
            case TasteArticle:
            {
                NSMutableArray *array = [NSMutableArray arrayWithArray:[cachDict objectForKey:@"tasteArray"] ];
                if (![array containsObject:articleId]) {
                    [array addObject:articleId];
                }
                [cachDict setObject:array forKey:@"tasteArray"];

            }
                break;
                
            default:
                break;
        }
                [[NSUserDefaults standardUserDefaults] setObject:cachDict forKey:@"ArticleReadCach"];
    
    //NSLog(@"新闻缓存----%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"ArticleReadCach"]);
}

+(BOOL)hasReaded:(NSString *)articleId withType:(ArticleType)type
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ArticleReadCach"]==nil) {
        return NO;
    } else {
            NSMutableDictionary *cachDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"ArticleReadCach"];
        switch (type) {
            case NewsArticle:
            {
                NSArray *array = [cachDict objectForKey:@"newsArray"] ;
                if ([array containsObject:articleId]) {
                    return YES;
                }
            }
                break;
            case ProfessionArticle:
            {
                NSArray *array = [cachDict objectForKey:@"professionArray"] ;
                if ([array containsObject:articleId]) {
                    return YES;
                }

                
            }
                break;
            case TasteArticle:
            {
                NSArray *array = [cachDict objectForKey:@"tasteArray"] ;
                if ([array containsObject:articleId]) {
                    return YES;
                }
                
            }
                break;
                
                
            default:
                break;
        }

    }
    return NO;
}

+(void)cleanArticleReadCach
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"ArticleReadCach"]==nil) {
        return;
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArticleReadCach"];
    }
}

@end
