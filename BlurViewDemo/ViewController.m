//
//  ViewController.m
//  BlurViewDemo
//
//  Created by 百事&可乐 on 2019/6/13.
//  Copyright © 2019 百事&可乐. All rights reserved.
//

#import "ViewController.h"
#import "UIImage_ImageEffectsVC.h"
#import "UIToolbarVC.h"
#import "UIVisualEffectViewVC.h"
#import "CoreImageVC.h"
#import "FXblurViewVC.h"
@interface ViewController ()

@end

@implementation ViewController
#define ScreenWidth [[UIScreen mainScreen]bounds].size.width
#define ScreenHeight [[UIScreen mainScreen]bounds].size.height
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"几种常用模糊效果的实现";
    //
    NSArray *nameArr = @[@"UIImage+ImageEffects",@"用UIToolbar覆盖",@"使用UIVisualEffectView",@"CoreImage",@"FXblurView"];
    for (int i =0 ; i<5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:btn];
        btn.tag = 1000+i;
        btn.frame = CGRectMake(30, 20 + i*(20+40), ScreenWidth-60, 40);
        [btn setTitle:nameArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }

}
-(void)click:(UIButton*)sender{
    switch (sender.tag) {
        case 1000:
        {
            /*
             这种办法实际上是对加载出的UIImage进行处理，得到模糊效果后，可以使用UIImage对象创建视图。
             使用场景：需要对静态的图片进行模糊时
             优点：
             iOS7就可以使用；
             官方代码，质量上有保证；
             API简单易用；
             可以控制参数，调节模糊效果；
             */
            UIImage_ImageEffectsVC *vc =[[UIImage_ImageEffectsVC alloc] initWithNibName:@"UIImage_ImageEffectsVC" bundle:[NSBundle mainBundle]];
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc]init];
            backItem.title=@"";
            self.navigationItem.backBarButtonItem=backItem;
            vc.title = @"IImage+ImageEffects";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1001:
        {
            /*
             这个控件覆盖在其它视图上方时，能够看到下面的内容，并且是模糊效果
             使用场景：如果被模糊的内容不是静态内容，会在屏幕上动，那么只能使用这种办法。
             优点：
             可以支持较低的系统版本
             缺点：
             不可调节模糊效果，并且与第一种方法的效果并不一致
             */
            UIToolbarVC *vc = [[UIToolbarVC alloc]initWithNibName:@"UIToolbarVC" bundle:[NSBundle mainBundle]];
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc]init];
            backItem.title=@"";
            self.navigationItem.backBarButtonItem=backItem;
            vc.title = @"用UIToolbar覆盖";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1002:
        {
            /*
            在iOS8中,苹果引入了UIVisualEffectView以及UIVisualEffect，利用这些新的特性，非常容易添加两种效果: UIBlurEffect（高斯模糊）以及UIVibrancyEffect(这种效果能把当前视图和背景视图混合起来)。
             优点：苹果原生支持
             缺点：iOS8及以上的系统可使用；不支持调节参数。
             */
            UIVisualEffectViewVC *vc = [[UIVisualEffectViewVC alloc]initWithNibName:@"UIVisualEffectViewVC" bundle:[NSBundle mainBundle]];
            UIBarButtonItem*backItem=[[UIBarButtonItem alloc]init];
            backItem.title=@"";
            self.navigationItem.backBarButtonItem=backItem;
            vc.title = @"UIVisualEffectView";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1003:
        {
            /*
             Core Image 是苹果用来简化图片处理的框架，在 iOS 平台上，5.0 之后就出现了 Core Image 的 API。Core Image 的 API 被放在 CoreImage.framework 库中。不过直到iOS6.0才开始支持模糊。这个API调用起来很方便简洁。
             优点: 模糊效果较好，模糊程度的可调范围很大，可以根据实际的需求随意调试。
             缺点: 耗时
             需要导入: #import <CoreImage/CoreImage.h>
            */
            CoreImageVC *vc = [[CoreImageVC alloc]init];
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
            backItem.title = @"";
            self.navigationItem.backBarButtonItem = backItem;
            vc.title = @"CoreImage";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1004:
        {
            /*
             FXBlurView 是一个UIView的子类，效果和iOS7的背景实时模糊效果一样，但是支持到了 iOS 5.0。
             
             FXBlurView 有两种模式，一种是 static 静态模糊：也就是只模糊一次，后面即使背景图片变化了，模糊效果也不会变化；另外就是 dynamic 动态模糊：这会实时的对背景图片进行模糊，是会不断变化的。
             */
            FXblurViewVC *vc = [[FXblurViewVC alloc]initWithNibName:@"FXblurViewVC" bundle:[NSBundle mainBundle]];
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
            backItem.title = @"";
            self.navigationItem.backBarButtonItem = backItem;
            vc.title = @"FXblurView";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
        default:
            break;
    }
}


@end
