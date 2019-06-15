//
//  UIToolbarVC.m
//  BlurViewDemo
//
//  Created by 百事&可乐 on 2019/6/14.
//  Copyright © 2019 百事&可乐. All rights reserved.
//

#import "UIToolbarVC.h"

@interface UIToolbarVC ()
@property(nonatomic)UIToolbar *toolbar;
@end

@implementation UIToolbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"change" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction)];
    
    self.toolbar = [[UIToolbar alloc] initWithFrame: self.view.bounds];
    self.toolbar.barStyle= UIBarStyleDefault;//UIBarStyleBlack
    self.toolbar.hidden = NO;
    [self.view addSubview: self.toolbar];
}
-(void)rightAction{
    if (self.toolbar.hidden) {
        self.toolbar.hidden = NO;
    }else{
        self.toolbar.hidden = YES;
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
