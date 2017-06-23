//
//  MTSFilterDataModel.h
//  GIFMomentCamera
//
//  Created by Monster on 23/06/2017.
//  Copyright © 2017 MonsterTech Studio. All rights reserved.
//

#import <Mantle/Mantle.h>
@interface MTSFilterDataModel : MTLModel <MTLJSONSerializing>

@property(nonatomic, copy)NSString *FilterName;
@property(nonatomic, copy)NSString *FilterCoverImagePath;
@property(nonatomic, copy)NSString *FilterPath;

@end
