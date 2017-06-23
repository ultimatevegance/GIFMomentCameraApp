//
//  MTSCustomizationViewController.m
//  GIFMomentCamera
//
//  Created by Monster on 22/06/2017.
//  Copyright © 2017 MonsterTech Studio. All rights reserved.
//

#import "MTSCustomizationViewController.h"

@interface MTSCustomizationViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *save;
@property (weak, nonatomic) IBOutlet SCVideoPlayerView *playerView;
@property (weak, nonatomic) IBOutlet UIView *customizationOptionsView;
@property (strong, nonatomic) SCPlayer *player;

@end

@implementation MTSCustomizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _player = [SCPlayer player];
    _playerView.player = _player;
    _playerView.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _player.loopEnabled = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_player setItemByAsset:_recordSession.assetRepresentingSegments];
    [_player play];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_player pause];
}

- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(UIBarButtonItem *)sender {
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
