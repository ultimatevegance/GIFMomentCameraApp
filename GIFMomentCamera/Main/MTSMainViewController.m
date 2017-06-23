//
//  MTSMainViewController.m
//  GIFMomentCamera
//
//  Created by Monster on 22/06/2017.
//  Copyright © 2017 MonsterTech Studio. All rights reserved.
//

#import "MTSMainViewController.h"
#import "Common.h"
#import "SDRecordButton.h"
#import "BlurMenu.h"
const int videoDuration  = 5;

@interface MTSMainViewController ()<SCRecorderDelegate,BlurMenuDelegate>
@property (weak, nonatomic) IBOutlet UIView *videoPreviewLayer;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraChangeButton;
@property (strong, nonatomic) SCRecorder *recorder;
@property (weak, nonatomic) IBOutlet SDRecordButton *recordButton;
@property (nonatomic, strong) NSTimer *progressTimer;
@property (nonatomic) CGFloat progress;
@property (nonatomic, strong) BlurMenu *menu;

@end

@implementation MTSMainViewController

#pragma mark - LIFE CYCLE

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MSPrimaryBGColor;
    //config recorder
    _recorder = [SCRecorder recorder];
    _recorder.session = [SCRecordSession recordSession];
    _recorder.device = AVCaptureDevicePositionFront;
    _recorder.delegate = self;
    _recorder.previewView = _videoPreviewLayer;
   }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self prepareSession];
    // Configure recorder button
    _recordButton.buttonColor = [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:CGRectMake(0, 0,CGRectGetWidth(_recordButton.frame) ,CGRectGetHeight(_recordButton.frame)) andColors:@[PrimaryColororangish,PrimaryColorbarbiePink]];
    _recordButton.progressColor = PrimaryColororangish ;
    [_recordButton addTarget:self action:@selector(recording) forControlEvents:UIControlEventTouchDown];
    [_recordButton addTarget:self action:@selector(pausedRecording) forControlEvents:UIControlEventTouchUpInside];
    [_recordButton addTarget:self action:@selector(pausedRecording) forControlEvents:UIControlEventTouchUpOutside];
    NSArray *items = [[NSArray alloc] initWithObjects:@"Generals", @"Rate Five Star", @"Share ", @"About", nil];
    _menu = [[BlurMenu alloc] initWithItems:items parentView:self.view delegate:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_recorder startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_recorder stopRunning];
}

#pragma mark - HELPERS

- (void)prepareSession {
    if (_recorder.session == nil) {
        SCRecordSession *session = [SCRecordSession recordSession];
        session.fileType = AVFileTypeQuickTimeMovie;
        _recorder.session = session;
    }
}

- (void)recording {
    NSLog(@"Started recording");
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    [_recorder record];
}

- (void)pausedRecording {
    NSLog(@"Paused recording");
    [self.progressTimer invalidate];
    [_recorder pause];
}

- (void)updateProgress {
    self.progress += 0.05/videoDuration;
    [self.recordButton setProgress:self.progress];
    if (self.progress >= 1)
        [self.progressTimer invalidate];
}

#pragma mark - ACTIONS

- (IBAction)Setting:(UIButton *)sender {
    [_menu show];
}

- (IBAction)CameraChanger:(UIButton *)sender {
    [_recorder switchCaptureDevices];
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
