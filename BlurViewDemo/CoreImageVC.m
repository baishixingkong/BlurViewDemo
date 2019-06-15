//
//  CoreImageVC.m
//  BlurViewDemo
//
//  Created by 百事&可乐 on 2019/6/15.
//  Copyright © 2019 百事&可乐. All rights reserved.
//

#import "CoreImageVC.h"
#import <CoreImage/CoreImage.h>
@interface CoreImageVC ()
@property(nonatomic)UIImageView *imageView;
@property(nonatomic) UIImage *image;
@property(nonatomic,retain)UISlider *slider;
@property(nonatomic,retain)UISegmentedControl *segmentControl;
@property(nonatomic,copy) NSString *filterName;
@end

@implementation CoreImageVC
#define ScreenWidth [[UIScreen mainScreen]bounds].size.width
#define ScreenHeight [[UIScreen mainScreen]bounds].size.height
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self print_filterattributes];
    //
    self.image = [UIImage imageNamed:@"bgView.jpg"];
    self.imageView = [[UIImageView alloc]init];
    self.imageView.frame = self.view.bounds;
    self.imageView.image = _image;
    [self.view addSubview:self.imageView];
    //
    self.slider = [[UISlider alloc]initWithFrame:CGRectMake(50,ScreenHeight-64-100,ScreenWidth-100,20)];
    _slider.maximumValue = 1.0;
    _slider.minimumValue = 0;
    _slider.maximumTrackTintColor         = [UIColor grayColor];//大于当前滑动的颜色
    _slider.minimumTrackTintColor         = [UIColor orangeColor];//小于当前滑动的颜色
    _slider.continuous = YES;
    [_slider addTarget:self action:@selector(valueChange)forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    //
    self.segmentControl = [[UISegmentedControl alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(_slider.frame) + 30,ScreenWidth - 20,40)];
    _segmentControl.tintColor = [UIColor orangeColor];
    [_segmentControl insertSegmentWithTitle:@"0"atIndex:0 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"1"atIndex:1 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"2"atIndex:2 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"3"atIndex:3 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"4"atIndex:4 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"5"atIndex:5 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"6"atIndex:6 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"7"atIndex:7 animated:YES];
    [_segmentControl insertSegmentWithTitle:@"8"atIndex:8 animated:YES];
    [_segmentControl addTarget:self action:@selector(clickAction)forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentControl];
    
    
}
//动态迷糊
-(void)valueChange{
   
    CIImage *ciimage = [CIImage imageWithCGImage:[_image CGImage]];
    CIFilter *gaussianBlur = [CIFilter filterWithName:@"CIGaussianBlur"];
    [gaussianBlur setValue:ciimage forKey:@"inputImage"];
    [gaussianBlur setValue:[NSNumber numberWithFloat:_slider.value*20] forKey:@"inputRadius"];
    CIImage *resultImage = [gaussianBlur valueForKey:@"outputImage"];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:resultImage fromRect:[ciimage extent]];
    UIImage *currImg = [UIImage imageWithCGImage:imageRef];
    [_imageView setImage:currImg];
    CFRelease(imageRef);
}

//几种系统默认滤镜效果
-(void)clickAction{
    switch (_segmentControl.selectedSegmentIndex) {
        case 0:
        {
            self.filterName = @"CILineOverlay";
            [self filter];
        }
            break;
            
        case 1:
        {
            self.filterName = @"CIGaussianBlur";
            [self filter];
        }
            break;
        case 2:
        {
            self.filterName = @"CIColorPosterize";
            [self filter];
        }
            break;
        case 3:
        {
            self.filterName = @"CIMinimumComponent";
            [self filter];
        }
            break;
        case 4:
        {
            self.filterName = @"CIPhotoEffectFade";
            [self filter];
        }
            break;
        case 5:
        {
            self.filterName = @"CICrystallize";
            [self filter];
        }
            break;
        case 6:
        {
            self.filterName = @"CIEdges";
            [self filter];
        }
            break;
        case 7:
        {
            self.filterName = @"CISpotColor";
            [self filter];
        }
            break;
        default:
        {
            //叠加模糊滤镜的效果
            self.filterName = @"CIBoxBlur";
            [self addFilter];
        }
            break;
    }
}
//
-(void)filter{
    //防止线程阻塞，用GCD异步执行滤镜与渲染操作，在获取渲染后的照片以后，返回主线程进行界面的更新。
    CoreImageVC* __block  blockSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        /* 0.导入CIImage图片 */
        UIImage *sourceImage = [UIImage imageNamed:@"bgView.jpg"];
        //CIImage
//        CIImage *ciImage = [CIImage imageWithCGImage:[sourceImage CGImage]];
        CIImage *ciImage = [[CIImage alloc] initWithImage:sourceImage];
        
        /* 1.创建出Filter滤镜 */
        //过滤器<有很多种, 在下边打印的有>
        CIFilter *blurFilter = [CIFilter filterWithName:self.filterName];
        //将图片输入到滤镜中
        [blurFilter setValue:ciImage forKey:kCIInputImageKey];
        //进行默认设置
        [blurFilter setDefaults];
      
        //将处理之后的图片输出
        CIImage *outCIImage = [blurFilter valueForKey:kCIOutputImageKey];
        
        /* 2.用CIContext将滤镜中的图片渲染出来 */
        /** 获取CGImage句柄
         *  createCGImage: 处理过的CIImage
         *  fromRect: 如果从处理过的图片获取frame会比原图小, 因此在此需要设置为原始的CIImage.frame
         */
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef outCGImageRef = [context createCGImage:outCIImage fromRect:[ciImage extent]];
        
        /* 3.导出图片 */
        //获取到最终图片
        UIImage *resultImage = [UIImage imageWithCGImage:outCGImageRef];
        //释放句柄
        CGImageRelease(outCGImageRef);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            /* 4.加载图片 */
            blockSelf.imageView.image = resultImage;
        });
        
    });

}
//滤镜叠加成滤镜链
-(void)addFilter{
   
        
    /* 0.导入CIImage图片 */
    UIImage *sourceImage = self.imageView.image;
    //CIImage
    CIImage *ciImage = [CIImage imageWithCGImage:[sourceImage CGImage]];

    /* 1.创建出Filter滤镜 */
    //过滤器<有很多种, 在下边打印的有>
    CIFilter *blurFilter = [CIFilter filterWithName:self.filterName];
    //将图片输入到滤镜中
    [blurFilter setValue:ciImage forKey:kCIInputImageKey];
    //进行默认设置
    [blurFilter setDefaults];

    //将处理之后的图片输出
    CIImage *outCIImage = [blurFilter valueForKey:kCIOutputImageKey];

    /* 2.用CIContext将滤镜中的图片渲染出来 */
    /** 获取CGImage句柄
     *  createCGImage: 处理过的CIImage
     *  fromRect: 如果从处理过的图片获取frame会比原图小, 因此在此需要设置为原始的CIImage.frame
     */
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef outCGImageRef = [context createCGImage:outCIImage fromRect:[ciImage extent]];

    /* 3.导出图片 */
    //获取到最终图片
    UIImage *resultImage = [UIImage imageWithCGImage:outCGImageRef];
    //释放句柄
    CGImageRelease(outCGImageRef);

    /* 4.加载图片 */
    self.imageView.image = resultImage;
   
}
//打印滤镜属性
-(void)print_filterattributes{
    /*
     //失真效果 改变几何形状创建3D效果
     CORE_IMAGE_EXPORT NSString * const kCICategoryDistortionEffect;
     //扭曲图片和纠正源图像问题，例如仿射变换来校正相对于地平线旋转的图像
     CORE_IMAGE_EXPORT NSString * const kCICategoryGeometryAdjustment;
     //合成滤镜，操作两个图像源
     CORE_IMAGE_EXPORT NSString * const kCICategoryCompositeOperation;
     //半色调效果
     CORE_IMAGE_EXPORT NSString * const kCICategoryHalftoneEffect;
     //色彩调整，用于消除色彩偏移、校正亮度和对比度
     CORE_IMAGE_EXPORT NSString * const kCICategoryColorAdjustment;
     //修改图像颜色，我们一般用的比较多，类似美图工具的滤镜效果
     CORE_IMAGE_EXPORT NSString * const kCICategoryColorEffect;
     //
     CORE_IMAGE_EXPORT NSString * const kCICategoryTransition;
     //瓦片效果 平铺图片
     CORE_IMAGE_EXPORT NSString * const kCICategoryTileEffect;
     //产生图案的过滤器，如纯色、棋盘或星星的光泽。生成的输出通常用作对另一个过滤器的输入。
     CORE_IMAGE_EXPORT NSString * const kCICategoryGenerator;
     //减少图像数据 解决图像分析问题
     CORE_IMAGE_EXPORT NSString * const kCICategoryReduction NS_AVAILABLE(10_5, 5_0);
     //渐变效果
     CORE_IMAGE_EXPORT NSString * const kCICategoryGradient;
     //绘画风格
     CORE_IMAGE_EXPORT NSString * const kCICategoryStylize;
     //锐化图像 锐化掩模和提高亮度。
     CORE_IMAGE_EXPORT NSString * const kCICategorySharpen;
     //柔滑图像，主要用于模糊图像
     CORE_IMAGE_EXPORT NSString * const kCICategoryBlur;
     //处理视频图像
     CORE_IMAGE_EXPORT NSString * const kCICategoryVideo;
     //处理静态图像
     CORE_IMAGE_EXPORT NSString * const kCICategoryStillImage;
     //处理交错图像
     CORE_IMAGE_EXPORT NSString * const kCICategoryInterlaced;
     //处理非方形图像
     CORE_IMAGE_EXPORT NSString * const kCICategoryNonSquarePixels;
     //处理高动态图像
     CORE_IMAGE_EXPORT NSString * const kCICategoryHighDynamicRange;
     //用于区分built-in filters  plug-in filters.
     CORE_IMAGE_EXPORT NSString * const kCICategoryBuiltIn;
     //链接几个过滤器
     CORE_IMAGE_EXPORT NSString * const kCICategoryFilterGenerator NS_AVAILABLE(10_5, 9_0);
     */
    //获取kCICategoryStylize类型所有滤镜的名字和属性设置
    NSArray* filters =  [CIFilter filterNamesInCategory:kCICategoryStylize];
    for (NSString* filterName in filters) {
        NSLog(@"filter name:%@",filterName);
        // 我们可以通过filterName创建对应的滤镜对象
        CIFilter* filter = [CIFilter filterWithName:filterName];
        NSDictionary* attributes = [filter attributes];
        // 获取属性键/值对（在这个字典中我们可以看到滤镜的属性以及对应的key）
        NSLog(@"filter attributes:%@",attributes);
    }
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
