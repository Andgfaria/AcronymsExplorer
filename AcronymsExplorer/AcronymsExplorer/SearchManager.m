//
//  SearchManager.m
//  AcronymsExplorer
//
//  Created by André Gimenez Faria on 26/03/16.
//  Copyright © 2016 AGF. All rights reserved.
//

#import "SearchManager.h"
#import <AFNetworking/AFNetworking.h>
#import <Mantle/Mantle.h>
#import "Acronym.h"

@implementation SearchManager

static NSString * const API_BASE_URL = @"http://www.nactem.ac.uk/software/acromine/dictionary.py";

+(id) sharedManager {
    static SearchManager *searchManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        searchManager = [[self alloc] init];
    });
    return searchManager;
}

-(id) init {
    self = [super init];
    return self;
}

+(NSString *) API_BASE_URL {
    return API_BASE_URL;
}

-(void) getAcronymsWithString:(NSString *)queryString andCompletionHandler:(void (^)(SearchResult,NSArray *))completionHandler {
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [sessionManager  GET:API_BASE_URL parameters:@{ @"sf" : queryString } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject count] > 0) {
            if ([responseObject[0] isKindOfClass:[NSDictionary class]]) {
                NSArray *resultItems = responseObject[0][@"lfs"];
                if (resultItems) {
                    NSMutableArray *acronymsArray = [NSMutableArray new];
                    for (NSDictionary *acronymData in resultItems) {
                        NSError *error;
                        [acronymsArray addObject:[MTLJSONAdapter modelOfClass:[Acronym class] fromJSONDictionary:acronymData error:&error]];
                    }
                    return completionHandler(Success,[NSArray arrayWithArray:acronymsArray]);
                }
                return completionHandler(JSONError,nil);
            }
            else {
                return completionHandler(JSONError,nil);
            }
        }
        else {
            return completionHandler(NoResults,nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        return completionHandler(ServerError,nil);
    }];
}


@end
