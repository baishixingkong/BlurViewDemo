//
//  UIVisualEffectViewVC.m
//  BlurViewDemo
//
//  Created by 百事&可乐 on 2019/6/14.
//  Copyright © 2019 百事&可乐. All rights reserved.
//

#import "UIVisualEffectViewVC.h"

@interface UIVisualEffectViewVC ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation UIVisualEffectViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Blur effect 模糊效果
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle: UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect: blurEffect];
    blurView.frame = self.view.bounds;
    [self.bgImageView addSubview: blurView];
    
    //无生动效果
    UIImageView *withoutVibrancy = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"minIcon"]];
    withoutVibrancy.frame = CGRectMake(50, 150, 40, 40);
    [self.bgImageView addSubview: withoutVibrancy];
    
    UILabel *withouttitle = [[UILabel alloc]init];
    withouttitle.frame = CGRectMake(100, 150, 150, 40);
    withouttitle.text = @"无生动效果～～";
    withouttitle.textColor = [UIColor whiteColor];
    [self.bgImageView addSubview:withouttitle];
    
    //有生动效果
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *vibrancyView = [[UIVisualEffectView alloc] initWithEffect: vibrancyEffect];
    vibrancyView.frame = blurView.bounds;
    [blurView.contentView addSubview: vibrancyView];
    
    UIImageView *iconView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"minIcon"]];
    iconView.frame = CGRectMake(50, 250, 40, 40);
    [vibrancyView.contentView addSubview: iconView];
    
    UILabel *title = [[UILabel alloc]init];
    title.frame = CGRectMake(100, 250, 150, 40);
    title.text = @"有生动效果～～";
    title.textColor = [UIColor whiteColor];
    [vibrancyView.contentView addSubview:title];

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
