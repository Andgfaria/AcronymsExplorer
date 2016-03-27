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

/* This method makes a search request to the API with a given string.
   After the request is fetched a completion handler is executed.
   The completion handles receives 2 arguments: an integer represeting the outcome of the search and an array containing the search results.
*/

+(void) getAcronymsWithString:(NSString *)queryString andCompletionHandler:(void (^)(SearchResult,NSArray *))completionHandler {
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [sessionManager  GET:API_BASE_URL parameters:@{ @"sf" : queryString } progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // The API returns an array of JSONs, so we must check if the array is not empty
        if ([responseObject count] > 0) {
            // We must also check if the first object is in the JSON form
            if ([responseObject[0] isKindOfClass:[NSDictionary class]]) {
                NSArray *resultItems = responseObject[0][@"lfs"];
                if (resultItems) {
                    // Transform the JSON into an array of Acronym objects
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
