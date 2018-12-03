

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setLj_x:(CGFloat)lj_x{
    
    CGRect frame = self.frame;
    frame.origin.x = lj_x;
    self.frame = frame;
}

- (CGFloat)lj_x {
    
    return self.frame.origin.x;
}

- (void)setLj_y:(CGFloat)lj_y {
    
    CGRect frame = self.frame;
    frame.origin.y = lj_y;
    self.frame = frame;
}

- (CGFloat)lj_y {
    
    return self.frame.origin.y;
}

- (CGFloat)lj_maxX {
    
    return CGRectGetMaxX(self.frame);
}

- (void)setLj_maxX:(CGFloat)lj_maxX {}

- (CGFloat)lj_maxY {
    
    return CGRectGetMaxY(self.frame);
}

- (void)setLj_maxY:(CGFloat)lj_maxY {}

- (void)setLj_width:(CGFloat)lj_width {
    CGRect frame = self.frame;
    frame.size.width = lj_width;
    self.frame = frame;
}

- (CGFloat)lj_width {
    
    return self.frame.size.width;
}

- (void)setLj_height:(CGFloat)lj_height {
    CGRect frame = self.frame;
    frame.size.height = lj_height;
    self.frame = frame;
}

- (CGFloat)lj_height {
    
    return self.frame.size.height;
}

- (void)setLj_size:(CGSize)lj_size {
    
    CGRect frame = self.frame;
    frame.size = lj_size;
    self.frame = frame;
}

- (CGSize)lj_size {
    
    return self.frame.size;
}

- (void)setLj_origin:(CGPoint)lj_origin {
    
    CGRect frame = self.frame;
    frame.origin = lj_origin;
    self.frame = frame;
}

- (CGPoint)lj_origin {
    
    return self.frame.origin;
}

- (void)setLj_centerX:(CGFloat)lj_centerX {
    
    CGPoint center = self.center;
    center.x = lj_centerX;
    self.center = center;
}

- (CGFloat)lj_centerX {
    
    return self.center.x;
}

- (void)setLj_centerY:(CGFloat)lj_centerY {
    
    CGPoint center = self.center;
    center.y = lj_centerY;
    self.center = center;
}

- (CGFloat)lj_centerY {
    
    return self.center.y;
}

- (void)setLj_top:(CGFloat)lj_top {
    CGRect frame = self.frame;
    frame.origin.y = lj_top;
    self.frame = frame;
}

- (CGFloat)lj_top {
    return self.frame.origin.y;
}

- (void)setLj_left:(CGFloat)lj_left {
    CGRect frame = self.frame;
    frame.origin.x = lj_left;
    self.frame = frame;
}

- (CGFloat)lj_left {
    return self.frame.origin.x;
}

- (void)setLj_bottom:(CGFloat)lj_bottom {
    CGRect frame = self.frame;
    frame.origin.y = lj_bottom - self.lj_height;
    self.frame = frame;
}

- (CGFloat)lj_bottom {
    return self.frame.origin.y + self.lj_height;
}

- (void)setLj_right:(CGFloat)lj_right {
    CGRect frame = self.frame;
    frame.origin.x = lj_right - self.lj_width;
    self.frame = frame;
}

- (CGFloat)lj_right {
    return self.frame.origin.x + self.lj_width;
}

@end












