//
//  UIViewController+WBAddtion.m
//  Weibo-OC
//
//  Created by leeyii on 2017/9/25.
//  Copyright © 2017年 leeyii. All rights reserved.
//

#import "UIViewController+WBAddtion.h"
#import <objc/runtime.h>

@implementation UIViewController (WBAddtion)

+ (void)load {
    
    Method org = class_getInstanceMethod(self, @selector(viewWillAppear:));
    Method new = class_getInstanceMethod(self, @selector(swizz_viewWillAppear:));
    
    method_exchangeImplementations(org, new);
    
    Method org1 = class_getInstanceMethod(self, @selector(viewDidDisappear:));
    Method new1 = class_getInstanceMethod(self, @selector(swizz_viewDidDisappear:));
    
    method_exchangeImplementations(org1, new1);
}

- (void)swizz_viewWillAppear:(BOOL)animated {
    [self swizz_viewWillAppear:animated];
    NSLog(@"%s %@", __FUNCTION__, self);
}

- (void)swizz_viewDidDisappear:(BOOL)animated {
    [self swizz_viewDidDisappear:animated];
    NSLog(@"%s %@", __FUNCTION__, self);
}

@end
