//
//  MTSVideoOverlayView.h
//  GIFMomentCamera
//
//  Created by Monster on 27/06/2017.
//  Copyright © 2017 MonsterTech Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCVideoConfiguration.h"
#import "IQLabelView.h"

@interface MTSVideoOverlayView : UIView <SCVideoOverlay>

@property (copy,nonatomic)NSString *textContent;
@property(strong, nonatomic)IQLabelView *labelView;

@end
