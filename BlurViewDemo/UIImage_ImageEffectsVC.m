//
//  UIImage_ImageEffectsVC.m
//  BlurViewDemo
//
//  Created by 百事&可乐 on 2019/6/13.
//  Copyright © 2019 百事&可乐. All rights reserved.
//

#import "UIImage_ImageEffectsVC.h"
#import "UIImage+ImageEffects.h"
@interface UIImage_ImageEffectsVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) UIImage *image;
@property (nonatomic) UISlider *flySlider;
@end

@implementation UIImage_ImageEffectsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.image = [UIImage imageNamed:@"pic.jpg"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"复原" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction)];
}
-(void)rightAction{
    self.imageView.image = self.image;
    if (!self.flySlider.hidden) {
        self.flySlider.value = 0.0f;
    }
   
}
- (IBAction)light:(id)sender {
    UIImage *effectImage = [self.image applyLightEffect];
    self.imageView.image = effectImage;
    self.flySlider.hidden = YES;
}
- (IBAction)extralight:(id)sender {
    UIImage *effectImage = [self.image applyExtraLightEffect];
    self.imageView.image = effectImage;
    self.flySlider.hidden = YES;
}
- (IBAction)dark:(id)sender {
    UIImage *effectImage = [self.image applyDarkEffect];
    self.imageView.image = effectImage;
    self.flySlider.hidden = YES;
}
- (IBAction)colortint:(id)sender {
    UIImage *effectImage = [self.image applyTintEffectWithColor:[UIColor blueColor]];
    self.imageView.image = effectImage;
    self.flySlider.hidden = YES;
}
- (IBAction)custom:(id)sender {
    if (!self.flySlider) {
        self.flySlider = [[UISlider alloc] initWithFrame:CGRectMake(240, 130, 200, 10)];
    }
    self.flySlider.hidden = NO;
    self.flySlider.maximumValue                  = 1.0f;
    self.flySlider.minimumValue                  = 0.0f;
    self.flySlider.value                         = 0.0f;
    self.flySlider.maximumTrackTintColor         = [UIColor grayColor];//大于当前滑动的颜色
    self.flySlider.minimumTrackTintColor         = [UIColor orangeColor];//小于当前滑动的颜色
    //实现偏转
    self.flySlider.transform                     = CGAffineTransformMakeRotation(M_PI_2);

    [self.flySlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];

    [self.imageView addSubview:self.flySlider];
}
-(void)sliderValueChanged:(UISlider*)sender{
    CGFloat value = sender.value*50;
    UIImage *effectImage = [self.image applyBlurWithRadius:value tintColor:[UIColor clearColor] saturationDeltaFactor:1.0 maskImage:nil];
    self.imageView.image = effectImage;
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
