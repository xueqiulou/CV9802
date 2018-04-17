//
//  ViewController.m
//  ColorsGame
//
//  Created by TimeMachine on 2018/4/10.
//  Copyright © 2018年 TimeMachine. All rights reserved.
//

#import "ViewController.h"
#import "XQLGamingViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *mode30sB;
@property (weak, nonatomic) IBOutlet UIButton *mode60sB;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *best30L;
@property (weak, nonatomic) IBOutlet UILabel *best60L;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [[UIColor colorWithPatternImage:[UIImage imageNamed:@"homebgImage"]] colorWithAlphaComponent:0.6];
    
    UIImage *image = [UIImage imageNamed:@"homebgImage"];
    self.view.layer.contents = (id)image.CGImage;
    
    self.titleL.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:40];
    self.titleL.text = @"Different Color";
    
    self.mode30sB.layer.cornerRadius = 5;
    self.mode60sB.layer.cornerRadius = 5;
    
    self.mode60sB.titleLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:25];
    self.mode30sB.titleLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:25];
    
    self.view.layer.backgroundColor = [[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor];
    
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.best30L.font =  [UIFont fontWithName:@"MarkerFelt-Thin" size:35];
    self.best60L.font =  [UIFont fontWithName:@"MarkerFelt-Thin" size:35];
    if ([[NSUserDefaults standardUserDefaults] integerForKey:bestScore30]) {
        self.best30L.text = [NSString stringWithFormat:@"30s Best: %ld",[[NSUserDefaults standardUserDefaults] integerForKey:bestScore30]];
    }else{
        self.best30L.text = @"30s Best: 0";
    }
    if ([[NSUserDefaults standardUserDefaults] integerForKey:bestScore60]) {
        self.best60L.text = [NSString stringWithFormat:@"60s Best: %ld",[[NSUserDefaults standardUserDefaults] integerForKey:bestScore60]];
    }else{
        self.best60L.text = @"60s Best: 0";
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    XQLGamingViewController *gamingVC = segue.destinationViewController;
    UIButton *button = sender;
    if (button.tag == 100) {//30s
        
        gamingVC.timeCount = 30;
    }else if (button.tag == 101){//60s
        
        gamingVC.timeCount = 60;
    }
}


@end
