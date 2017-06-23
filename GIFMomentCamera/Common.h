//
//  Common.h
//  GIFMomentCamera
//
//  Created by Monster on 22/06/2017.
//  Copyright © 2017 MonsterTech Studio. All rights reserved.
//

#ifndef Common_h
#define Common_h
#import <ChameleonFramework/Chameleon.h>
#import <SCRecorder/SCRecorder.h>
#import <JVTransitionAnimator.h>
#import "DGActivityIndicatorView.h"
//Constants
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
//Colors
#define PrimaryColororangish [UIColor colorWithRed:253.0f / 255.0f green:128.0f / 255.0f blue:65.0f / 255.0f alpha:1.0f]
#define PrimaryColorbarbiePink [UIColor colorWithRed:255.0f / 255.0f green:76.0f / 255.0f blue:161.0f / 255.0f alpha:1.0f]
#define ShotButtonColor [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:CGRectMake(0, 0,300 ,300) andColors:@[PrimaryColororangish,PrimaryColorbarbiePink]]
#define MSPrimaryBGColor  [UIColor colorWithHexString:@"2E2E2E"]
#endif /* Common_h */
