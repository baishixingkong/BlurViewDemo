//
//  FXblurViewVC.m
//  BlurViewDemo
//
//  Created by 百事&可乐 on 2019/6/14.
//  Copyright © 2019 百事&可乐. All rights reserved.
//

#import "FXblurViewVC.h"
#import "FXblurView.h"
@interface FXblurViewVC ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (nonatomic)FXBlurView *fxView;
@property (nonatomic)UISlider *flySlider;
@end

@implementation FXblurViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fxView = [[FXBlurView alloc] initWithFrame:CGRectMake(0, 0, self.bgImageView.frame.size.width, self.bgImageView.frame.size.height)];
    //动态
    self.fxView.dynamic = NO;
    //模糊范围
    self.fxView.blurRadius = 20;
    //背景色
    self.fxView.tintColor = [UIColor clearColor];
    [self.bgImageView addSubview:self.fxView];
    
  
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
