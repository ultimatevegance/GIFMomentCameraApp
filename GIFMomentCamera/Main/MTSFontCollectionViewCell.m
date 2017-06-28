//
//  MTSFontCollectionViewCell.m
//  GIFMomentCamera
//
//  Created by Monster on 28/06/2017.
//  Copyright © 2017 MonsterTech Studio. All rights reserved.
//

#import "MTSFontCollectionViewCell.h"
#import "Common.h"
@implementation MTSFontCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8;
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.layer.borderColor = MSBarbiePink.CGColor;
        self.layer.borderWidth = 1;
    } else {
        self.layer.borderColor = MSBarbiePink.CGColor;
        self.layer.borderWidth = 0;
    }
}

@end
