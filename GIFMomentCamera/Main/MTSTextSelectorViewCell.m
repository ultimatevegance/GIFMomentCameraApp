//
//  MTSTextSelectorViewCell.m
//  GIFMomentCamera
//
//  Created by Monster on 27/06/2017.
//  Copyright © 2017 MonsterTech Studio. All rights reserved.
//

#import "MTSTextSelectorViewCell.h"
#import "Common.h"
#import "MTSFontCollectionViewCell.h"
static NSString *mFontCellID = @"MTSFontCollectionViewCell";
@interface MTSTextSelectorViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *colorSelecterView;
@property (weak, nonatomic) IBOutlet UICollectionView *fontSelectorCollectionView;
@property (strong, nonatomic)UIColor *mSelectedColor;
@property (strong, nonatomic)UIFont *mSelectedFont;
@property (strong, nonatomic)NSMutableArray *fonts;
@end

@implementation MTSTextSelectorViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    // add color buttons
    CGFloat buttonMargin = 12;
    CGFloat colorButtonWidth = (kScreenWidth - buttonMargin * 9) / 8;
    for (int i = 0; i < 8; i ++) {
        UIButton *colorButton = [[UIButton alloc] init];
        [colorButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"C%d",i + 1]] forState:UIControlStateNormal];
        colorButton.frame = CGRectMake(buttonMargin * (i + 1) + colorButtonWidth * i, 8, colorButtonWidth, colorButtonWidth);
        colorButton.tag = 1000 + i;
        [colorButton addTarget:self action:@selector(colorButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [_colorSelecterView addSubview:colorButton];
        
    }
    //config fontSelectorCollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _fontSelectorCollectionView.collectionViewLayout = layout;
    _fontSelectorCollectionView.delegate = self;
    _fontSelectorCollectionView.dataSource = self;
    [_fontSelectorCollectionView registerNib:[UINib nibWithNibName:mFontCellID bundle:nil] forCellWithReuseIdentifier:mFontCellID];
    [self loadAllFontsListData];
    
    
}

- (void)loadAllFontsListData {
    _fonts = [NSMutableArray arrayWithArray:[UIFont familyNames]];
}

- (void)colorButtonSelected:(UIButton *)button {
    NSLog(@"%ld", (long)button.tag);
    NSInteger index = button.tag - 1000;
    switch (index) {
        case 0:
        _mSelectedColor = [UIColor colorWithHexString:@"34d6fd"];
        break;
        case 1:
        _mSelectedColor = [UIColor colorWithHexString:@"58e2c2"];
        break;
        case 2:
        _mSelectedColor = [UIColor colorWithHexString:@"20c57a"];
        break;
        case 3:
        _mSelectedColor = [UIColor colorWithHexString:@"ec4a4f"];
        break;
        case 4:
        _mSelectedColor = [UIColor colorWithHexString:@"4a4a4a"];
        break;
        case 5:
        _mSelectedColor = [UIColor colorWithHexString:@"f7e53b"];
        break;
        case 6:
        _mSelectedColor = [UIColor colorWithHexString:@"d42eef"];
        break;
        case 7:
        _mSelectedColor = [UIColor colorWithHexString:@"ffffff"];
        break;
        
        default:
        _mSelectedColor = [UIColor colorWithHexString:@"ffffff"];
        break;
    }
    _selectedColor(_mSelectedColor);
}
#pragma mark - UICollectionViewDataSource
//cell config
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MTSFontCollectionViewCell *cell = [_fontSelectorCollectionView dequeueReusableCellWithReuseIdentifier:mFontCellID forIndexPath:indexPath];
    [cell.fontLabel setText: _fonts[indexPath.row]];
    [cell.fontLabel setFont:[UIFont fontWithName:_fonts[indexPath.row] size:13]];
    return  cell;
}
// items number for section
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _fonts.count;
}
// sections number
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
#pragma mark - UICollectionViewDelegateFlowLayout
// cell margins
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
// cell size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger cellWidth = kScreenWidth * 0.3;
    NSInteger cellHeight = cellWidth * 0.37;
    return CGSizeMake(cellWidth,cellHeight );
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedFontName) {
        _selectedFontName(_fonts[indexPath.row]);
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
}


@end
