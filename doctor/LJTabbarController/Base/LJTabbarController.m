//
//  LJTabbarController.m
//  LJTabbarController
//
//  Created by 刘鹿杰的mac on 2018/11/29.
//  Copyright © 2018年 刘鹿杰的mac. All rights reserved.
//

#import "LJTabbarController.h"
#import "LJNaviControllrer.h"
#import "LJTabbar.h"

#import "HomeViewController.h"
#import "C2CViewController.h"
#import "C3CViewController.h"
#import "C4CViewController.h"
#import "MineViewController.h"


static NSInteger const ImageCount = 3;  // 动画图片个数
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface LJTabbarController ()<UITabBarControllerDelegate>

/** 四个tabbar对应的动画图片数组 */
@property (strong, nonatomic) NSMutableArray <UIImage *>*homeImages;     // 首页动画图片
@property (strong, nonatomic) NSMutableArray <UIImage *>*caseImages;     // 医生动画图片
@property (strong, nonatomic) NSMutableArray <UIImage *>*shendengImages; // 神灯动画图片
@property (strong, nonatomic) NSMutableArray <UIImage *>*shareImages;    // 分享动画图片
@property (strong, nonatomic) NSMutableArray <UIImage *>*mineImages;     // 我的动画图片
@property (strong, nonatomic) NSMutableArray *allImages;  /** 所有图片数组 */

@end

@implementation LJTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加图片数组
    [self.allImages addObject:self.homeImages];
    [self.allImages addObject:self.caseImages];
    [self.allImages addObject:self.shendengImages];
    [self.allImages addObject:self.shareImages];
    [self.allImages addObject:self.mineImages];
    // 设置代理监听tabBar的点击
    self.delegate = self;
    // 1.添加所有的子控制器
    [self addAllChildViewControllers];
    // 定制化设置Tabbar
    [self setValue:[[LJTabbar alloc] init] forKey:@"tabBar"];
}


#pragma mark - 1.添加所有的子控制器
- (void)addAllChildViewControllers{
    [self addOneViewController:[[HomeViewController alloc] init] image:@"home_normal" selectedImage:@"home_sel3" title:@"首页"];
    [self addOneViewController:[[C2CViewController alloc] init] image:@"doctor_normal" selectedImage:@"doctor_sel3" title:@"医生"];
    [self addOneViewController:[[C3CViewController alloc] init] image:@"shendeng_normal" selectedImage:@"shendeng_sel3" title:@"医生神灯"];
    [self addOneViewController:[[C4CViewController alloc] init] image:@"share_normal" selectedImage:@"share_sel3" title:@"分享"];
    [self addOneViewController:[[MineViewController alloc] init] image:@"me_normal" selectedImage:@"me_sel3" title:@"我的"];
}

#pragma mark - 1.1.添加一个子控制器的方法
- (void)addOneViewController:(UIViewController *)childViewController image:(NSString *)imageName selectedImage:(NSString *)selectedImageName title:(NSString *)title{

    LJNaviControllrer *nav = [[LJNaviControllrer alloc] initWithRootViewController:childViewController];
    //     设置图片和文字之间的间
    if ([title isEqualToString:@"医生神灯"]) {
        nav.tabBarItem.imageInsets = UIEdgeInsetsMake(-10, 0, 10, 0);
        nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
        [self setSelectedTitleTextWithTabbarItem:nav.tabBarItem andSelectedColor:RGBCOLOR(232, 156, 0)]; // 设置琉璃神灯页面的颜色
    }else{
        nav.tabBarItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0);
        nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -2);
        [self setSelectedTitleTextWithTabbarItem:nav.tabBarItem andSelectedColor:RGBCOLOR(42,182,124)]; // 设置正常状态下的颜色
    }
    nav.title = title;
    if (imageName.length) { // 图片名有具体
        nav.tabBarItem.image = [self imageWithOriRenderingImage:imageName];
        nav.tabBarItem.selectedImage = [self imageWithOriRenderingImage:selectedImageName];
    }
    [self addChildViewController:nav];
}

#pragma mark - 1.2 设置文字、图片选中的状态效果
-(void)setSelectedTitleTextWithTabbarItem:(UITabBarItem *)tabbarItem andSelectedColor:(UIColor *)color{
    // 2.1 正常状态下的文字
    NSMutableDictionary *normalAttr = [NSMutableDictionary dictionary];
    normalAttr[NSForegroundColorAttributeName] = RGBCOLOR(85, 85, 85);
    normalAttr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    // 2.2 选中状态下的文字
    NSMutableDictionary *selectedAttr = [NSMutableDictionary dictionary];
    selectedAttr[NSForegroundColorAttributeName] = color;
    selectedAttr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    // 设置对应的颜色
    [tabbarItem setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    [tabbarItem setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSInteger index = [tabBarController.childViewControllers indexOfObject:viewController];  // 获取当前选中的控制器位置
    UIButton *tabBarBtn = tabBarController.tabBar.subviews[index+1];
    Class clase = NSClassFromString(@"UITabBarSwappableImageView");
    UIImageView *imageView = nil;  // 获取对应的ImageView，添加动画。
    for (UIView *view in tabBarBtn.subviews) {
        if ([view isKindOfClass:clase]) {
            imageView = (UIImageView *)view;
        }
    }
    imageView.animationImages = self.allImages[index];
    imageView.animationRepeatCount = 1;
    imageView.animationDuration = ImageCount * 0.08;
    [imageView startAnimating];
    return YES;
}


#pragma mark -  *******  懒加载数据 *************

- (NSMutableArray *)allImages {
    if (!_allImages) {
        _allImages = [NSMutableArray array];
    }
    return _allImages;
}

- (NSMutableArray<UIImage *> *)homeImages {
    if (!_homeImages) {
        _homeImages = [self addImage:@"home_sel"];
    }
    return _homeImages;
}

-(NSMutableArray<UIImage *> *)caseImages{
    if (!_caseImages) {
        _caseImages = [self addImage:@"doctor_sel"];
    }
    return _caseImages;
}

-(NSMutableArray<UIImage *> *)shendengImages{
    if (!_shendengImages) {
        _shendengImages = [self addImage:@"shendeng_sel"];
    }
    return _shendengImages;
}

-(NSMutableArray<UIImage *> *)shareImages{
    if (!_shareImages) {
        _shareImages = [self addImage:@"share_sel"];
    }
    return _shareImages;
}

- (NSMutableArray<UIImage *> *)mineImages {
    if (!_mineImages) {
        _mineImages = [self addImage:@"me_sel"];
    }
    return _mineImages;
}

- (NSMutableArray <UIImage *>*)addImage:(NSString *)imageName{
    NSMutableArray <UIImage *>*images = [NSMutableArray arrayWithCapacity:ImageCount];
    for (int i = 1; i <= ImageCount; i++) {
        NSString *name = [NSString stringWithFormat:@"%@%d", imageName, i];
        UIImage *img = [UIImage imageNamed:name];
        [images addObject:img];
    }
    return images;
}

- (UIImage *)imageWithOriRenderingImage:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


@end
