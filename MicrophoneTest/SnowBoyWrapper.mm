//
//  SnowBoyWrapper.m
//  MicrophoneTest
//
//  Created by yoshiaki-yamada on 2017/02/09.
//  Copyright © 2017年 yoshiaki-yamada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnowBoyWrapper.h"
#import "snowboy-detect.h"

@interface SnowBoyWrapper()

@end

@implementation SnowBoyWrapper {
    snowboy::SnowboyDetect* _snowboyDetect;     // Detector.
}

- (instancetype)init
{
    self = [super init];

    _snowboyDetect = NULL;

    std::string resFilePath{[NSBundle.mainBundle pathForResource:@"common" ofType:@"res"].UTF8String};
    std::string umdlFilePath{[NSBundle.mainBundle pathForResource:@"snowboy" ofType:@"umdl"].UTF8String};
    _snowboyDetect = new snowboy::SnowboyDetect(resFilePath, umdlFilePath);
    _snowboyDetect->SetSensitivity("0.6");        // Sensitivity for each hotword
    _snowboyDetect->SetAudioGain(6.0);             // Audio gain for detection

    NSLog(@"SampleRate: %d", _snowboyDetect->SampleRate());
    NSLog(@"NumChannels: %d", _snowboyDetect->NumChannels());
    NSLog(@"BitsPerSample: %d", _snowboyDetect->BitsPerSample());

    return self;
}

- (int)sampleRate
{
    return _snowboyDetect->SampleRate();
}

- (void)snowboyDetection:(AVAudioPCMBuffer*)buffer
{
    int result = _snowboyDetect->RunDetection(buffer.floatChannelData[0], int(buffer.frameLength));
    if (result > 0){
        NSLog(@"detect snowboy");
    }
    NSLog(@"%d", result);
}

- (void)dealloc
{
    delete _snowboyDetect;
    _snowboyDetect = nullptr;
}

@end

