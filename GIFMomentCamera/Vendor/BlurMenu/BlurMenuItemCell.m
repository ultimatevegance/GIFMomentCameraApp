//
//  BlurMenuItemCell.m
//  BlurMenu
//
//  Created by Ali Yılmaz on 06/02/14.
//  Copyright (c) 2014 Ali Yılmaz. All rights reserved.
//

#import "BlurMenuItemCell.h"
#import "Common.h"
@implementation BlurMenuItemCell
@synthesize title;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        title = [[UILabel alloc] initWithFrame:self.contentView.frame];
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont fontWithName:@"Phosphate-Inline" size:25.0f];
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = ShotButtonColor;
        title.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:title];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
