# TabBarController
###  1. 防闲鱼app 
######  效果图如下：
![xianyu.gif](https://upload-images.jianshu.io/upload_images/1471722-3626a44d6b9a4079.gif?imageMogr2/auto-orient/strip)
######  实现思路：
- 此时的tabbar的话也是遵循主流，自定义一个继承自系统UITabbar的LJTabbar，然后用KVC和系统的进行替换。
- 中间的凸起按钮和tabbar内部的子控件不是同一类型，中间的按钮是一个自定义的button。
- 最后给tabbar弄一个代理，添加一个点击中间凸起按钮的代理方法，让LJTabBarController成为它的代理，实现对应代理方法即可实现按钮点击。
######  核心方法：
- 动态添加button 后，重新布局子控件代码
```
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
```
``` objc
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
```
### 2. 防金琉璃app（一款医疗软件）
> 这个实现思路比较推荐，特色点是“选中对应 tabbarItem 不仅有动画效果， 而且tabbar上的按钮都为tabbarItem , 没有使用自定义的button， 点击顺序非常好控制， 不需要再次处理中的凸出按钮的点击事件了” 
######  效果图如下：
![doctor.gif](https://upload-images.jianshu.io/upload_images/1471722-67321f84bfa601f5.gif?imageMogr2/auto-orient/strip)
######  实现思路：
- 此时的tabbar也是一个继承自系统UITabbar的LJTabbar，用KVC和系统的进行替换，这样方便为tabbar 增加一个中间按钮的背景图片， 使其凸出来！代码如下：
```
- (void)layoutSubviews{
    [super layoutSubviews];
    Class class = NSClassFromString(@"UITabBarButton");
    int btnIndex = 0;
    for (UIView *btn in self.subviews){
        if ([btn isKindOfClass:class]) {
            if (btnIndex == 2) { // btnIndex == 2 的时候， 为中间按钮， 添加一个背景图片
                self.imageView.frame = CGRectMake(5, -17, btn.lj_width - 10, btn.lj_height + 17);
                [btn insertSubview:self.imageView atIndex:0];
                self.btn = btn;
            }
            btnIndex++;
        }
    }
}
```

- 为了使突出来的按钮也有点击事件， 也需要重写hitTest方法， 但此时要计算转换背景按钮的坐标系， 以便计算出来， 点击按钮 的响应区域。
 ```
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {}
    if (self.isHidden == NO) {
        CGPoint newP = [self convertPoint:point toView:self.imageView];
        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
        if ( [self.imageView pointInside:newP withEvent:event]) {
            return self.btn;
        }else{ //如果点不在发布按钮身上，直接让系统处理就可以了
            return [super hitTest:point withEvent:event];
        }
    }
    else {  //tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
}
```
- 动画效果的实现， 是实现TabBarController 的 tabBarController：shouldSelectViewController： 这个代理方法， 并且添加一个选中的item 动态添加一个动画组， 如下代码：
```
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
```
> 这样就能实现上述的效果了，选择对应的按钮， 有动画、 选中颜色也有对应的色彩，tabbar顺序也不会更改。

