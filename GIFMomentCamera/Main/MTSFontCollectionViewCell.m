//
//  MTSFontCollectionViewCell.m
//  GIFMomentCamera
//
//  Created by Monster on 28/06/2017.
//  Copyright © 2017 MonsterTech Studio. All rights reserved.
//

#import "MTSFontCollectionViewCell.h"

@implementation MTSFontCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8;
}

@end
