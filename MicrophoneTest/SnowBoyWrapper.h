//
//  SnowBoyWrapper.h
//  MicrophoneTest
//
//  Created by yoshiaki-yamada on 2017/02/09.
//  Copyright © 2017年 yoshiaki-yamada. All rights reserved.
//

#ifndef SnowBoyWrapper_h
#define SnowBoyWrapper_h

#import <AVFoundation/AVFoundation.h>

@interface SnowBoyWrapper : NSObject

- (void)snowboyDetection:(AVAudioPCMBuffer*)buffer;

@property (readonly) int sampleRate;

@end
#endif /* SnowBoyWrapper_h */
