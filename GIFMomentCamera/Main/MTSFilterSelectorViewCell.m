//
//  MTSFilterSelectorViewCell.m
//  GIFMomentCamera
//
//  Created by Monster on 27/06/2017.
//  Copyright © 2017 MonsterTech Studio. All rights reserved.
//

#import "MTSFilterSelectorViewCell.h"
#import "MTSFilterCollectionViewCell.h"
#import "Common.h"
static NSString *mFilterCellID = @"MTSFilterCollectionViewCell";

@interface MTSFilterSelectorViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *filtersData;

@end
@implementation MTSFilterSelectorViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView.collectionViewLayout = layout;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:mFilterCellID bundle:nil] forCellWithReuseIdentifier:mFilterCellID];
    [self loadFiltersData];

}

- (void)loadFiltersData {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"filtersData" ofType:@"json"];
    NSString *filterJSONString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    if (filterJSONString) {
        NSDictionary *filterJSONDic = [self dictionaryWithJsonString:filterJSONString];
        _filtersData = [MTLJSONAdapter modelsOfClass:[MTSFilterDataModel class] fromJSONArray:filterJSONDic[@"Filters"] error:nil];
    }
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}

#pragma mark - UICollectionViewDataSource
//cell config
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MTSFilterCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:mFilterCellID forIndexPath:indexPath];
    cell.filterData = _filtersData[indexPath.row];
    return  cell;
}
// items number for section
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _filtersData.count;
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
    NSInteger cellWidth = kScreenWidth * 0.24;
    NSInteger cellHeight = cellWidth * 1.2;
    return CGSizeMake(cellWidth,cellHeight );
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectCellAtIndex) {
        _selectCellAtIndex(indexPath.row);
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
}



@end
