//
//  MTSCustomizationViewController.m
//  GIFMomentCamera
//
//  Created by Monster on 22/06/2017.
//  Copyright © 2017 MonsterTech Studio. All rights reserved.
//

#import "MTSCustomizationViewController.h"
#import "MTSFilterDataModel.h"
#import "MTSVideoOverlayView.h"
#import "HMSegmentedControl.h"
#import "MTSFilterSelectorViewCell.h"
#import "MTSTextSelectorViewCell.h"
static NSString *mFilterSelectorViewID = @"MTSFilterSelectorViewCell";
static NSString *mTextSelectorViewID = @"MTSTextSelectorViewCell";

@interface MTSCustomizationViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UIButton *save;
@property (weak, nonatomic) IBOutlet SCSwipeableFilterView *swipeableFilterView;
@property (weak, nonatomic) IBOutlet UIView *segmentCtrl;
@property (strong, nonatomic)UIColor *mSelectedColor;
@property (copy, nonatomic)NSString *mSelectedFontName;
@property (weak, nonatomic) IBOutlet UIView *customizationOptionsView;
@property (strong, nonatomic) SCPlayer *player;
@property (weak, nonatomic) IBOutlet UIButton *customizationOptions;
@property (strong, nonatomic) NSArray *filtersData;
@property (strong, nonatomic) NSMutableArray *filters;
@property (strong, nonatomic) FCAlertView *alert;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation MTSCustomizationViewController

#pragma mark - LIFE CYCLE

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadFiltersData];
    //scroll view
    MTSFilterSelectorViewCell *filterSelectorView = [[[NSBundle mainBundle] loadNibNamed:mFilterSelectorViewID owner:self options:nil] firstObject];
    filterSelectorView.selectCellAtIndex = ^(NSInteger index) {
        [_swipeableFilterView setSelectedFilter:_filters[index]];
    };
    filterSelectorView.frame = CGRectMake(0, 0, kScreenWidth,  CGRectGetHeight(_scrollView.frame));
    MTSTextSelectorViewCell *textSelectorView = [[[NSBundle mainBundle] loadNibNamed:mTextSelectorViewID owner:self options:nil] firstObject];
    textSelectorView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth,  CGRectGetHeight(_scrollView.frame));
    textSelectorView.selectedColor = ^(UIColor *selectedColor) {
        _mSelectedColor = selectedColor;
    };
    textSelectorView.selectedFontName = ^(NSString *mSelectedFontName) {
        _mSelectedFontName = mSelectedFontName;
    };
    _scrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetHeight(_scrollView.frame));
    [_scrollView addSubview:filterSelectorView];
    [_scrollView addSubview:textSelectorView];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.directionalLockEnabled = YES;
    //segmentCtrl
    NSArray *sectionImages = @[[UIImage imageNamed:@"Filters"],[UIImage imageNamed:@"Text"]];
    HMSegmentedControl *segCtrl = [[HMSegmentedControl alloc] initWithSectionImages:sectionImages sectionSelectedImages:sectionImages];
    segCtrl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segCtrl.selectionIndicatorColor = [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:CGRectMake(0, 400, 200, 5) andColors:@[MSOrganish,MSBarbiePink]];
    segCtrl.selectionIndicatorHeight = 3;
    segCtrl.backgroundColor = [UIColor clearColor];
    [segCtrl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    segCtrl.frame = _segmentCtrl.frame;
    [_segmentCtrl addSubview:segCtrl];

    //player
    _player = [SCPlayer player];
    _player.loopEnabled = YES;
    _swipeableFilterView.contentMode = UIViewContentModeScaleAspectFill;
    _player.SCImageView = self.swipeableFilterView;
    _swipeableFilterView.filters = _filters;
    
}

- (void)configAppearance {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_player setItemByAsset:_recordSession.assetRepresentingSegments];
    [_player play];
//    MTSVideoOverlayView *overlayView = [[MTSVideoOverlayView alloc] initWithFrame:_swipeableFilterView.frame];
//    overlayView.center = _swipeableFilterView.center;
//    [_swipeableFilterView addSubview:overlayView];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_recordSession removeAllSegments];
    [_player pause];
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    [_scrollView setContentOffset:CGPointMake(kScreenWidth * segmentedControl.selectedSegmentIndex,0 ) animated:YES];
}

#pragma mark - ACTIONS

- (IBAction)cancel:(UIButton *)sender {
    _alert = [[FCAlertView alloc] init];
    _alert.colorScheme = [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:_alert.frame andColors:@[MSOrganish,MSBarbiePink]];
    _alert.customImageScale = 2;
    _alert.darkTheme = YES;
    _alert.bounceAnimations = YES;
    _alert.avoidCustomImageTint = YES;
    _alert.animateAlertInFromTop = YES;
    _alert.animateAlertOutToBottom = YES;
    [_alert showAlertInView:self withTitle:@"Quit Customization?" withSubtitle:@"All the data will not be saved" withCustomImage:[UIImage imageNamed:@"Logo_small"] withDoneButtonTitle:@"YES" andButtons:nil];
    __weak typeof(self) weakSelf = self;
    [_alert doneActionBlock:^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [_alert addButton:@"Nope" withActionBlock:^{
        [weakSelf dismissAlert];
    }];
}

- (void)dismissAlert {
    [_alert dismissAlertView];
}
- (IBAction)save:(UIBarButtonItem *)sender {
    
}

#pragma mark - HELPERS

- (void)loadFiltersData {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"filtersData" ofType:@"json"];
    NSString *filterJSONString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    if (filterJSONString) {
        NSDictionary *filterJSONDic = [self dictionaryWithJsonString:filterJSONString];
        _filtersData = [MTLJSONAdapter modelsOfClass:[MTSFilterDataModel class] fromJSONArray:filterJSONDic[@"Filters"] error:nil];
        NSMutableArray *temp = [NSMutableArray array];
        if ([_filtersData count]) {
            for (int i = 0; i < _filtersData.count; i ++) {
                MTSFilterDataModel *filterData = _filtersData[i];
              SCFilter *filter = [SCFilter filterWithContentsOfURL:[[NSBundle mainBundle] URLForResource:filterData.FilterPath withExtension:@"cisf"]];
                [temp addObject:filter];

            }
            _filters = [NSMutableArray arrayWithArray:temp];
        }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
