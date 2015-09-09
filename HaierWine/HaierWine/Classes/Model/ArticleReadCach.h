//
//  NewsReadCach.h
//  HaierWine
//
//  Created by 张作伟 on 14-10-11.
//
//

#import <Foundation/Foundation.h>
typedef enum {
    NewsArticle,
    ProfessionArticle,
    TasteArticle
} ArticleType;

@interface ArticleReadCach : NSObject

+(BOOL)hasReaded:(NSString *)articleId withType:(ArticleType)type;
+(void)addReadedNews:(NSString*)articleId withType:(ArticleType)type;
+(void)cleanArticleReadCach;
@end
