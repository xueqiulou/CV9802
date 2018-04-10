//
//  ViewController.m
//  ColorsGame
//
//  Created by TimeMachine on 2018/4/10.
//  Copyright © 2018年 TimeMachine. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *mode30sB;
@property (weak, nonatomic) IBOutlet UIButton *mode60sB;
@property (weak, nonatomic) IBOutlet UILabel *titleL;

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
    
    self.mode60sB.titleLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:35];
    self.mode30sB.titleLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:35];
    
    self.view.layer.backgroundColor = [[[UIColor blackColor] colorWithAlphaComponent:0.5] CGColor];
}


@end
