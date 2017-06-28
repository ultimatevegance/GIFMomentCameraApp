//
//  MTSTextSelectorViewCell.h
//  GIFMomentCamera
//
//  Created by Monster on 27/06/2017.
//  Copyright © 2017 MonsterTech Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTSTextSelectorViewCell : UICollectionViewCell

@property (nonatomic, copy) void (^selectedColor)(UIColor *selectedColor);
@property (nonatomic, copy) void (^selectedFontName)( NSString *mSelectedFontName);

@end
