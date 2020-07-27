//
//  SettingViewController.m
//  Pivotal
//
//  Created by song on 2020/7/21.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import "SettingViewController.h"
#import "PTRouter.h"
@interface SettingViewController ()<PTRouterVCProtocol>
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, strong) UILabel *desc;
@end

@implementation SettingViewController

- (instancetype)initWithParam:(NSDictionary *)param {
    self = [super init];
    if (self) {
        self.userID = [param objectForKey:@"userID"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    self.desc = [[UILabel alloc] init];
    self.desc.numberOfLines = 0;
    self.desc.frame = CGRectMake(30, 80, 300, 300);
    [self.view addSubview:self.desc];
    self.desc.textColor = [UIColor blueColor];
    self.desc.text = [NSString stringWithFormat:@"用户ID = %@",self.userID];
}


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
