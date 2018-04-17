//
//  UIImage+color.h
//  CV98
//
//  Created by TimeMachine on 2018/4/9.
//  Copyright © 2018年 TimeMachine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (color)

/**
 *  重新绘制图片
 *
 *  @param color 填充色
 *
 *  @return UIImage
 */
- (UIImage *)imageWithColor:(UIColor *)color;
@end
