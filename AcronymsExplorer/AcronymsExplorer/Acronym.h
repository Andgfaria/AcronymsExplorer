//
//  Acronym.h
//  AcronymsExplorer
//
//  Created by André Gimenez Faria on 26/03/16.
//  Copyright © 2016 AGF. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Acronym : MTLModel <MTLJSONSerializing>

@property (atomic,copy) NSString *longForm;
// Number of occurrences
@property (atomic, assign) NSUInteger frequency;
@property (atomic, assign) NSUInteger sinceYear;
// Array of Acronyms objects of possible variations, in case they exist
@property (atomic, weak) NSArray *variations;

@end
