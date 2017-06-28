//
//  MTSFilterSelectorViewCell.h
//  GIFMomentCamera
//
//  Created by Monster on 27/06/2017.
//  Copyright © 2017 MonsterTech Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTSFilterSelectorViewCell : UICollectionViewCell

@property (nonatomic, copy) void (^selectCellAtIndex)(NSInteger index);

@end
