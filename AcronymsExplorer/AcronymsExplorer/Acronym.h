//
//  Acronym.h
//  AcronymsExplorer
//
//  Created by André Gimenez Faria on 26/03/16.
//  Copyright © 2016 AGF. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Acronym : MTLModel <MTLJSONSerializing>

@property (nonatomic,copy) NSString *longForm;
// Number of occurrences
@property (nonatomic, assign) NSUInteger frequency;
@property (nonatomic, assign) NSUInteger sinceYear;
// Array of Acronyms objects of possible variations, in case they exist
@property (nonatomic, weak) NSArray *variations;

@end
