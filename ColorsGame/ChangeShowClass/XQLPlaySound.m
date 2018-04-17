//
//  XQLPlaySound.m
//  ColorsGame
//
//  Created by TimeMachine on 2018/4/13.
//  Copyright © 2018年 TimeMachine. All rights reserved.
//

#import "XQLPlaySound.h"
#import <AVFoundation/AVFoundation.h>

@implementation XQLPlaySound
{
    
    SystemSoundID sousdndFileOsdbject;
}


+(instancetype)shareInstance
{
    static XQLPlaySound *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[XQLPlaySound alloc] init];
    });
    return manager;
}

-(void)playButtonSoundName:(NSString*)name type:(NSString*)type

{
    
    //得到音效文件的地址
    
    NSString*soundFilePath =[[NSBundle mainBundle]pathForResource:name ofType:type];
    
    //将地址字符串转换成url
    
    NSURL*soundURL = [NSURL fileURLWithPath:soundFilePath];
    
    //生成系统音效id
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &sousdndFileOsdbject);
    
    //播放系统音效
    
    AudioServicesPlaySystemSound(sousdndFileOsdbject);
    
}

@end
