//
//  LJTabbar.m
//  LJTabbarController
//
//  Created by 刘鹿杰的mac on 2018/11/29.
//  Copyright © 2018年 刘鹿杰的mac. All rights reserved.
//

#import "LJTabbar.h"
#import "UIView+Frame.h"
#import "UIImage+Image.h"


#define LJMagin 10


@interface LJTabbar ()

/** plus按钮 */
@property (nonatomic, weak) UIButton *plusBtn ;

@end


@implementation LJTabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
        
        UIButton *plusBtn = [[UIButton alloc] init];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"post_normal"] forState:UIControlStateHighlighted];
        
        self.plusBtn = plusBtn;
        
        
        [plusBtn addTarget:self action:@selector(plusBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:plusBtn];

    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    //系统自带的按钮类型是UITabBarButton，找出这些类型的按钮，然后重新排布位置，空出中间的位置
    Class class = NSClassFromString(@"UITabBarButton");
    
    self.plusBtn.lj_centerX = self.lj_centerX;
    //调整发布按钮的中线点Y值
    self.plusBtn.lj_centerY = self.lj_height * 0.5 - 2* LJMagin ;
    
    self.plusBtn.lj_size = CGSizeMake(self.plusBtn.currentBackgroundImage.size.width, self.plusBtn.currentBackgroundImage.size.height);
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"发布";
    label.font = [UIFont systemFontOfSize:11];
    [label sizeToFit];
    label.textColor = [UIColor grayColor];
    [self addSubview:label];
    label.lj_centerX = self.plusBtn.lj_centerX;
    label.lj_centerY = CGRectGetMaxY(self.plusBtn.frame) + LJMagin ;
    
    int btnIndex = 0;
    for (UIView *btn in self.subviews) {//遍历tabbar的子控件
        if ([btn isKindOfClass:class]) {
            btn.lj_width = self.lj_width / 5;
            
            btn.lj_x = btn.lj_width * btnIndex;
            
            btnIndex++;
            if (btnIndex == 2) {
                btnIndex++;
            }
        }
    }
    
    [self bringSubviewToFront:self.plusBtn];
}

//点击了发布按钮
- (void)plusBtnDidClick{
//    如果tabbar的代理实现了对应的代理方法，那么就调用代理的该方法
    if ([self.delegate respondsToSelector:@selector(tabBarPlusBtnClick:)]) {
        [self.myDelegate tabBarPlusBtnClick:self];
    }
    
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.isHidden == NO) {
        
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newP = [self convertPoint:point toView:self.plusBtn];
        
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.plusBtn pointInside:newP withEvent:event]) {
            return self.plusBtn;
        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
            
            return [super hitTest:point withEvent:event];
        }
    }
    
    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}


@end
