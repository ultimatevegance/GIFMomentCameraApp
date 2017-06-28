//
//  MTSTextSelectorViewCell.m
//  GIFMomentCamera
//
//  Created by Monster on 27/06/2017.
//  Copyright © 2017 MonsterTech Studio. All rights reserved.
//

#import "MTSTextSelectorViewCell.h"
@interface MTSTextSelectorViewCell()
@property (weak, nonatomic) IBOutlet UIView *colorSelecterView;
@property (weak, nonatomic) IBOutlet UICollectionView *fontSelectorCollectionView;
@end

@implementation MTSTextSelectorViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
