//
//  MTSVideoOverlayView.m
//  GIFMomentCamera
//
//  Created by Monster on 27/06/2017.
//  Copyright © 2017 MonsterTech Studio. All rights reserved.
//

#import "MTSVideoOverlayView.h"
@interface MTSVideoOverlayView ()

@property(strong, nonatomic)UIImageView *waterMarkImageView;

@end

@implementation MTSVideoOverlayView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
//        _waterMarkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo_watermark"]];
        _labelView = [IQLabelView new];
        _labelView.textColor = [UIColor whiteColor];
        _labelView.fontName = @"Phosphate-Inline";
        _labelView.fontSize = 20;
        _labelView.frame = CGRectMake(0, 0, 100, 50);
        _labelView.center = self.center;
        [_labelView setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:NSLocalizedString(@"Add Text", nil) attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }]];
        [self addSubview:_waterMarkImageView];
        [self addSubview:_labelView];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addNewLabel:)]];
    }
    
    return self;
}

- (void)addNewLabel:(UITapGestureRecognizer *)sender{
    IQLabelView *label = [IQLabelView new];
    CGPoint touchPoint = [sender locationInView: self];
    label.fontName = @"Phosphate-Inline";
    label.fontSize = 20;
    label.frame = CGRectMake(0, 0, 100, 50);
    label.center = touchPoint;
    [self addSubview:label];
}
@end
