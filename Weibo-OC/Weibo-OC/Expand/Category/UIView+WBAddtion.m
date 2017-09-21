//
//  UIView+WBAddtion.m
//  Weibo-OC
//
//  Created by leeyii on 2017/9/21.
//  Copyright © 2017年 leeyii. All rights reserved.
//

#import "UIView+WBAddtion.h"

@implementation UIView (WBAddtion)

- (CGFloat)wb_x {
    return self.frame.origin.x;
}

- (void)setWb_x:(CGFloat)wb_x {
    CGRect frame = self.frame;
    frame.origin.x = wb_x;
    self.frame = frame;
}

- (CGFloat)wb_y {
    return self.frame.origin.y;
}

- (void)setWb_y:(CGFloat)wb_y {
    CGRect frame = self.frame;
    frame.origin.y = wb_y;
    self.frame = frame;
}

- (CGFloat)wb_w {
    return self.frame.size.width;
}

- (void)setWb_w:(CGFloat)wb_w {
    CGRect frame = self.frame;
    frame.size.width = wb_w;
    self.frame = frame;
}

- (CGFloat)wb_h {
    return self.frame.size.height;
}

- (void)setWb_h:(CGFloat)wb_h {
    CGRect frame = self.frame;
    frame.size.height = wb_h;
    self.frame = frame;
}

- (CGFloat)wb_bottom {
    return self.wb_y + self.wb_h;
}

- (void)setWb_bottom:(CGFloat)wb_bottom {
    CGRect frame = self.frame;
    frame.origin.y = wb_bottom - self.wb_h;
    self.frame = frame;
}

- (CGFloat)wb_right {
    return self.wb_x + self.wb_w;
}

- (void)setWb_right:(CGFloat)wb_right {
    CGRect frame = self.frame;
    frame.origin.x = wb_right - self.wb_w;
    self.frame = frame;
}

- (CGFloat)wb_centerX {
    return self.center.x;
}

- (void)setWb_centerX:(CGFloat)wb_centerX {
    CGPoint center = self.center;
    center.x = wb_centerX;
    self.center = center;
}

- (CGFloat)wb_centerY {
    return self.center.y;
}

- (void)setWb_centerY:(CGFloat)wb_centerY {
    CGPoint center = self.center;
    center.y = wb_centerY;
    self.center = center;
}


@end
