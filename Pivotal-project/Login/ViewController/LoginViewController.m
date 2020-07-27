//
//  LoginViewController.m
//  Pivotal
//
//  Created by song on 2020/7/21.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import "LoginViewController.h"
#import "PTRouter.h"

@interface LoginViewController ()<PTRouterVCProtocol>
@property (nonatomic, strong) UILabel *desc;
@property (nonatomic, copy) NSDictionary *param;
@end

@implementation LoginViewController

- (instancetype)initWithParam:(NSDictionary *)param {
    self = [super init];
    if (self) {
        self.param = param;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    self.desc = [[UILabel alloc] init];
    self.desc.numberOfLines = 0;
    self.desc.frame = CGRectMake(30, 80, 300, 300);
    [self.view addSubview:self.desc];
    self.desc.textColor = [UIColor blueColor];
    self.desc.text = [NSString stringWithFormat:@"登录信息 = %@",self.param];
}

//根据项目需求自己写对应跳转
- (BOOL)presentingSelf {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UINavigationController *rootVC = (UINavigationController *)window.rootViewController;
    
    if (rootVC) {
        [rootVC pushViewController:self animated:YES];
        return YES;
    }
    return NO;
}


@end
