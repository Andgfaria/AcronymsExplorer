//
//  SearchManager.h
//  AcronymsExplorer
//
//  Created by André Gimenez Faria on 26/03/16.
//  Copyright © 2016 AGF. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SearchResult) {
    Success,
    ServerError,
    JSONError
};

@interface SearchManager : NSObject

+(SearchManager *) sharedManager;
+(NSString *) API_BASE_URL;
-(void) getAcronymsWithString:(NSString *)queryString andCompletionHandler:(void (^)(SearchResult,NSArray *))completionHandler;

@end