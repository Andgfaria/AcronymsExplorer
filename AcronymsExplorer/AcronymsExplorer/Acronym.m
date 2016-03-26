//
//  Acronym.m
//  AcronymsExplorer
//
//  Created by André Gimenez Faria on 26/03/16.
//  Copyright © 2016 AGF. All rights reserved.
//

#import "Acronym.h"

@implementation Acronym

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"longForm" : @"lf",
             @"frequency": @"freq",
             @"sinceYear": @"since",
             @"variations" : @"vars"
             };
}

+(NSValueTransformer *) variationsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:Acronym.class];
}

@end
