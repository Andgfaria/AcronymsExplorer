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
    NoResults,
    ServerError,
    JSONError
};

@interface SearchManager : NSObject

+(void) getAcronymsWithString:(NSString *)queryString andCompletionHandler:(void (^)(SearchResult,NSArray *))completionHandler;

@end
