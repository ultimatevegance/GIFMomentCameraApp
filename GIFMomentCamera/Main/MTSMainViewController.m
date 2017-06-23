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
#import "SCRecordSessionManager.h"
#import "MTSCustomizationViewController.h"
const int videoDuration  = 5;

@interface MTSMainViewController ()<SCRecorderDelegate,BlurMenuDelegate>
@property (weak, nonatomic) IBOutlet UIView *videoPreviewLayer;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraChangeButton;
@property (nonatomic, strong) SCRecorder *recorder;
@property (nonatomic, strong) SCRecordSession *recordSession;
@property (weak, nonatomic) IBOutlet SDRecordButton *recordButton;
@property (nonatomic, strong) NSTimer *progressTimer;
@property (nonatomic) CGFloat progress;
@property (nonatomic, strong) BlurMenu *menu;
@property (nonatomic, strong) NSArray *settingItems;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@end

@implementation MTSMainViewController

#pragma mark - LIFE CYCLE

- (void)dealloc {
    _recorder.previewView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MSPrimaryBGColor;
    //config recorder
    _recorder = [SCRecorder recorder];
    _recorder.session = [SCRecordSession recordSession];
    _recorder.device = AVCaptureDevicePositionBack;
    _recorder.delegate = self;
    _recorder.autoSetVideoOrientation = NO;
    _recorder.previewView = _videoPreviewLayer;
    // Get the audio configuration object
    SCAudioConfiguration *audio = _recorder.audioConfiguration;
    audio.enabled = NO;
    NSError *error;
    if (![_recorder prepare:&error]) {
        NSLog(@"Prepare error: %@", error.localizedDescription);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self prepareSession];
    // Configure recorder button
    _recordButton.buttonColor = [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:CGRectMake(0, 0,CGRectGetWidth(_recordButton.frame) ,CGRectGetHeight(_recordButton.frame)) andColors:@[PrimaryColororangish,PrimaryColorbarbiePink]];
    _recordButton.progressColor = PrimaryColorbarbiePink ;
    [_recordButton addTarget:self action:@selector(recording) forControlEvents:UIControlEventTouchDown];
    [_recordButton addTarget:self action:@selector(pausedRecording) forControlEvents:UIControlEventTouchUpInside];
    [_recordButton addTarget:self action:@selector(pausedRecording) forControlEvents:UIControlEventTouchUpOutside];
    if (!_settingItems) {
        _settingItems = [[NSArray alloc] initWithObjects:@"Generals", @"Rate Five Star", @"Share ", @"About", nil];
        if (!_menu) {
            _menu = [[BlurMenu alloc] initWithItems:_settingItems parentView:self.view delegate:self];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_recorder startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_recorder stopRunning];
    self.progress = 0;
    _progressView.progress = 0;
}

#pragma mark - SCRecorderDelegate

- (void)recorder:(SCRecorder *)recorder didSkipVideoSampleBufferInSession:(SCRecordSession *)recordSession {
    NSLog(@"Skipped video buffer");
}

- (void)recorder:(SCRecorder *)recorder didReconfigureAudioInput:(NSError *)audioInputError {
    NSLog(@"Reconfigured audio input: %@", audioInputError);
}

- (void)recorder:(SCRecorder *)recorder didReconfigureVideoInput:(NSError *)videoInputError {
    NSLog(@"Reconfigured video input: %@", videoInputError);
}

- (void)recorder:(SCRecorder *)recorder didCompleteSession:(SCRecordSession *)recordSession {
    NSLog(@"didCompleteSession:");
    [self saveAndShowSession:recordSession];
}

- (void)recorder:(SCRecorder *)recorder didInitializeAudioInSession:(SCRecordSession *)recordSession error:(NSError *)error {
    if (error == nil) {
        NSLog(@"Initialized audio in record session");
    } else {
        NSLog(@"Failed to initialize audio in record session: %@", error.localizedDescription);
    }
}

- (void)recorder:(SCRecorder *)recorder didInitializeVideoInSession:(SCRecordSession *)recordSession error:(NSError *)error {
    if (error == nil) {
        NSLog(@"Initialized video in record session");
    } else {
        NSLog(@"Failed to initialize video in record session: %@", error.localizedDescription);
    }
}

- (void)recorder:(SCRecorder *)recorder didBeginSegmentInSession:(SCRecordSession *)recordSession error:(NSError *)error {
    NSLog(@"Began record segment: %@", error);
}

#pragma mark - HELPERS

- (void)prepareSession {
    if (_recorder.session == nil) {
        SCRecordSession *session = [SCRecordSession recordSession];
        session.fileType = AVFileTypeQuickTimeMovie;
        _recorder.session = session;
    }
}

- (void)saveAndShowSession:(SCRecordSession *)recordSession {
    [[SCRecordSessionManager sharedInstance] saveRecordSession:recordSession];
    
    _recordSession = recordSession;
    [self showPreview];
}

- (void)showPreview {
    MTSCustomizationViewController *previewVC = [[MTSCustomizationViewController alloc] init];
    previewVC.recordSession = _recorder.session;
    [self presentViewController:previewVC animated:YES completion:nil];
}

- (void)recording {
    NSLog(@"Started recording");
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    [_recorder record];
}

- (void)pausedRecording {
    NSLog(@"Paused recording");
    [self.progressTimer invalidate];
    [_recorder pause:^{
        [self saveAndShowSession:_recorder.session];
    }];
}

- (void)updateProgress {
    self.progress += 0.05/videoDuration;
    [self.recordButton setProgress:self.progress];
    [_progressView setProgress:self.progress animated:YES];
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
