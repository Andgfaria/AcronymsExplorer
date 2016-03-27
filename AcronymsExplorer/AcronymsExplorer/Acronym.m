//
//  MainViewController.m
//  AcronymsExplorer
//
//  Created by André Gimenez Faria on 26/03/16.
//  Copyright © 2016 AGF. All rights reserved.
//

#import "Acronym.h"

@implementation Acronym

// Mantle method for mapping between the object properties and the JSON keys
+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    return @{
             @"longForm" : @"lf",
             @"frequency": @"freq",
             @"sinceYear": @"since",
             @"variations" : @"vars"
             };
}

// Mapping of the variations property using an array of Acronym objects
+(NSValueTransformer *) variationsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:Acronym.class];
}

@end
