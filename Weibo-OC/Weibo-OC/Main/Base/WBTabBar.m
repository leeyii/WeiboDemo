//
//  WBTabBar.m
//  Weibo-OC
//
//  Created by leeyii on 2017/9/21.
//  Copyright © 2017年 leeyii. All rights reserved.
//

#import "WBTabBar.h"

@implementation WBTabBar {
    UIBarButtonItem     *_centerItem;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _centerItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStyleDone target:self action:@selector(centerItemAction)];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}

- (void)centerItemAction {
    
}

@end
