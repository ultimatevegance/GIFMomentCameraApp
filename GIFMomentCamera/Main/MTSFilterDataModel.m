//
//  MTSFilterDataModel.m
//  GIFMomentCamera
//
//  Created by Monster on 23/06/2017.
//  Copyright © 2017 MonsterTech Studio. All rights reserved.
//

#import "MTSFilterDataModel.h"

@implementation MTSFilterDataModel

+ (NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{
             @"FilterName" : @"FilterName",
             @"FilterCoverImagePath" : @"FilterCoverImagePath",
             @"FilterPath" : @"FilterPath"
             };
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    
    // Store a value that needs to be determined locally upon initialization.
    
    return self;
}

@end
