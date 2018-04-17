//
//  XQLPlaySound.h
//  ColorsGame
//
//  Created by TimeMachine on 2018/4/13.
//  Copyright © 2018年 TimeMachine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XQLPlaySound : NSObject

+(instancetype)shareInstance;

-(void)playButtonSoundName:(NSString*)name type:(NSString*)type;

@end
