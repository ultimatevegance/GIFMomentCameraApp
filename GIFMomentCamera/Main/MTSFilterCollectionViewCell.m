//
//  MTSFilterCollectionViewCell.m
//  GIFMomentCamera
//
//  Created by Monster on 23/06/2017.
//  Copyright © 2017 MonsterTech Studio. All rights reserved.
//

#import "MTSFilterCollectionViewCell.h"
#import "Common.h"
@interface MTSFilterCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *filterCoverImageView;

@property (weak, nonatomic) IBOutlet UILabel *filterNameLabel;
@end
@implementation MTSFilterCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _filterCoverImageView.layer.cornerRadius = 6;
    _filterCoverImageView.layer.masksToBounds = YES;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 6;
}

- (void)setFilterData:(MTSFilterDataModel *)filterData {
    _filterData = filterData;
    _filterNameLabel.text = _filterData.FilterName;
    [_filterCoverImageView setImage:[UIImage imageNamed:_filterData.FilterCoverImagePath]];
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.backgroundColor = SelectedBGColor;
        _filterNameLabel.textColor = PrimaryColorbarbiePink;
    } else {
        _filterNameLabel.textColor = [UIColor flatWhiteColor];
        self.backgroundColor = [UIColor clearColor];
    }
}
@end
