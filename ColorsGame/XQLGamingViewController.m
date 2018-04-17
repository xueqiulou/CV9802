//
//  XQLGamingViewController.m
//  ColorsGame
//
//  Created by TimeMachine on 2018/4/10.
//  Copyright © 2018年 TimeMachine. All rights reserved.
//

#import "XQLGamingViewController.h"

static CGFloat spaceInstance = 2;


@interface XQLGamingViewController ()
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UILabel *stageL;

@end

@implementation XQLGamingViewController
{
    NSInteger count;
    NSInteger answerIndex;//答案所在的索引
    NSInteger rowCount;//行数
    NSInteger columnCount;//列数
    CGFloat minusValue;//不同颜色差值.大小影响着难度
    NSInteger stageValue;//当前完成关卡
    NSInteger bestScore_zone;
    NSInteger modeCount;
    BOOL isFirstShowNewHighScore;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self customNavigationView];
    
    //设置行数,列数
    rowCount = 2;
    columnCount = 2;
    count = rowCount*columnCount;
    
    //设置题的难度
    minusValue = 20;
    
    modeCount = self.timeCount;
    
    [self createButtons:count];
    
//    self.timeCount = 30;
    
    self.timeL.text = [NSString stringWithFormat:@"Countdown: %ld s",(long)self.timeCount];
    
    self.timeL.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:25];
    
    if ([UIDevice currentDevice].systemVersion.floatValue*10<10.0*10) {
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeSecond) userInfo:nil repeats:YES];
        self.timer = timer;
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
    }else{
        
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self changeSecond];
        }];
        self.timer = timer;
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    
    
}

-(void)changeSecond
{
    self.timeCount--;
    if (self.timeCount == 0) {
        [self.timer invalidate];
        self.timeL.text = [NSString stringWithFormat:@"Game Over"];
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Game Over" message:nil preferredStyle:UIAlertControllerStyleAlert];
       
        [self presentViewController:alertVC animated:YES completion:nil];
        
        [[XQLPlaySound shareInstance] playButtonSoundName:@"failure" type:@"wav"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
            [alertVC dismissViewControllerAnimated:YES completion:nil];
            
        });
        
        return ;
    }
    self.timeL.text = [NSString stringWithFormat:@"Countdown: %ld s",(long)self.timeCount];
}

-(void)createButtons:(NSInteger)count//创建色块
{
    CGFloat viewWidth = screenSize.width-40*2;
//    CGFloat viewHeight = viewWidth;
    
    answerIndex = arc4random()%count;
    
    CGFloat r = 30+arc4random()%180;
    CGFloat g = 30+arc4random()%180;
    CGFloat b = 30+arc4random()%180;

    NSInteger rgbIndex = arc4random()%3;
    
    
    for (int index=0; index<count; index++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat scale = columnCount;
        CGFloat width = (viewWidth-(columnCount-1)*spaceInstance)*1/scale;
        CGFloat height = width;
        CGFloat x = (index%columnCount)*(width+spaceInstance);
        NSInteger currentRow = index/rowCount;
        CGFloat y = currentRow*(height+spaceInstance);
        button.frame = CGRectMake(x, y, width, height);
        
        [button setBackgroundColor:LGRGBColor(r, g, b)];
        if (answerIndex == index) {
            if (rgbIndex == 0) {//差值加载r上
                [button setBackgroundColor:LGRGBColor(r+minusValue, g, b)];
            }else if (rgbIndex == 1){//差值加载g上
                [button setBackgroundColor:LGRGBColor(r, g+minusValue, b)];
            }else if (rgbIndex == 2){//差值加载b上
                [button setBackgroundColor:LGRGBColor(r, g, b+minusValue)];
            }
        }
        NSLog(@"color:%@",button.backgroundColor);
        button.layer.cornerRadius = 1;
        button.tag = 1000+index;
        
        [button addTarget:self action:@selector(clickColor:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.gameView addSubview:button];
        
    }
    
    NSLog(@"answer: %ld",answerIndex);
}

-(void)clickColor:(UIButton *)sender
{
    if (answerIndex == sender.tag - 1000) {
        NSLog(@"回答正确");
        
        
        stageValue++;
        self.stageL.text = [NSString stringWithFormat:@"Stage: %ld",stageValue];
        if (stageValue%5==0) {//做够题数(每完成5道题添加一栏)添加色块数
            
            //设置行数,列数
            rowCount ++;
            columnCount ++;
            count = rowCount*columnCount;
            minusValue--;
        
        }
        
        NSInteger currentBestScore ;
        if (modeCount == 30) {
            currentBestScore = [[NSUserDefaults standardUserDefaults] integerForKey:bestScore30];
        }else if (modeCount == 60){
            currentBestScore = [[NSUserDefaults standardUserDefaults] integerForKey:bestScore60];
        }
        
        
        
        if (currentBestScore<stageValue) {//创造了新纪录
            
            if (modeCount == 30) {
                [[NSUserDefaults standardUserDefaults] setInteger:stageValue forKey:bestScore30];
            }else if (modeCount == 60){
                [[NSUserDefaults standardUserDefaults] setInteger:stageValue forKey:bestScore60];
            }
            
            if (stageValue == 1) {
                return;
            }
            
            if (!isFirstShowNewHighScore) {
                
                isFirstShowNewHighScore = YES;
                [[XQLPlaySound shareInstance] playButtonSoundName:@"victory" type:@"wav"];
                [self.timer setFireDate:[NSDate distantFuture]];
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"New high score!" message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                [self presentViewController:alertVC animated:YES completion:nil];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.timer setFireDate:[NSDate date]];
                    [alertVC dismissViewControllerAnimated:YES completion:nil];
                    
                });
            }else{
                [[XQLPlaySound shareInstance] playButtonSoundName:@"success" type:@"mp3"];
            }
        }else{
            
            [[XQLPlaySound shareInstance] playButtonSoundName:@"success" type:@"mp3"];
        }
        
        [self refeshQuestion];
    }else{
        [[XQLPlaySound shareInstance] playButtonSoundName:@"wrong" type:@"mp3"];
    }
}


-(void)customNavigationView
{
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 74)];
    navigationView.backgroundColor = [UIColor clearColor];
    
    MyButton *backB = [MyButton buttonWithType:UIButtonTypeCustom];
    backB.frame = CGRectMake(15, 30, 50, 40);
    [backB setImage:[[UIImage imageNamed:@"back.png"] imageWithColor:LGRGBColor(78, 170, 146)] forState:UIControlStateNormal];
    [backB addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [navigationView addSubview:backB];
    
    UILabel *stageL = [[UILabel alloc] initWithFrame:CGRectMake(screenSize.width*0.5-150*0.5, 20, 150, navigationView.xql_height-20)];
    stageL.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:22];
    stageL.text = @"Stage: 0";
    stageL.textAlignment = NSTextAlignmentCenter;
    stageL.textColor = LGRGBColor(78, 170, 146);
    self.stageL = stageL;
    [navigationView addSubview:stageL];
    
    
    [self.view addSubview:navigationView];
}

-(void)refeshQuestion
{
    for (UIView *view in self.gameView.subviews) {
        [view removeFromSuperview];
    }
    [self createButtons:count];
}

-(void)back:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.timer invalidate];
}

-(void)dealloc
{
    [self.timer invalidate];
}

@end
