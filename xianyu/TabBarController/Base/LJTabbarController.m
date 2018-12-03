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

#import "LJHomeViewController.h"
#import "LJFishViewController.h"
#import "LJPlusBtnViewController.h"
#import "LJMeassageViewController.h"
#import "LJMineViewController.h"


@interface LJTabbarController ()<LJTabBarDelegate>


@end

@implementation LJTabbarController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    if (@available(iOS 9.0, *)) {
        UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
        
        NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
        dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
        dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
        
        NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
        dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
        dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
        
        [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
        [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    } else {
        // Fallback on earlier versions
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpAllChildVc];
    
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    LJTabbar *tabbar = [[LJTabbar alloc] init];
    tabbar.myDelegate = self;
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
}


#pragma mark - ------------------------------------------------------------------
#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc{
    
    
    LJHomeViewController *HomeVC = [[LJHomeViewController alloc] init];
    [self setUpOneChildVcWithVc:HomeVC Image:@"home_normal" selectedImage:@"home_highlight" title:@"首页"];
    
    LJFishViewController *FishVC = [[LJFishViewController alloc] init];
    [self setUpOneChildVcWithVc:FishVC Image:@"fish_normal" selectedImage:@"fish_highlight" title:@"鱼塘"];
    
    LJMeassageViewController *MessageVC = [[LJMeassageViewController alloc] init];
    [self setUpOneChildVcWithVc:MessageVC Image:@"message_normal" selectedImage:@"message_highlight" title:@"消息"];
    
    LJMineViewController *MineVC = [[LJMineViewController alloc] init];
    [self setUpOneChildVcWithVc:MineVC Image:@"account_normal" selectedImage:@"account_highlight" title:@"我的"];
    
    
}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    LJNaviControllrer *nav = [[LJNaviControllrer alloc] initWithRootViewController:Vc];
    
    
    Vc.view.backgroundColor = [self randomColor];
    
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Vc.tabBarItem.selectedImage = mySelectedImage;
    
    Vc.tabBarItem.title = title;
    
    Vc.navigationItem.title = title;
    
    [self addChildViewController:nav];
    
}



#pragma mark - ------------------------------------------------------------------
#pragma mark - LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(LJTabbar *)tabBar{
    
    LJPlusBtnViewController *plusVC = [[LJPlusBtnViewController alloc] init];
    plusVC.view.backgroundColor = [self randomColor];
    LJNaviControllrer *navVc = [[LJNaviControllrer alloc] initWithRootViewController:plusVC];
    [self presentViewController:navVc animated:YES completion:nil];

}


- (UIColor *)randomColor{
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}



@end
