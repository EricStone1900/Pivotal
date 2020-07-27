//
//  MainViewController.m
//  Pivotal
//
//  Created by song on 2020/7/21.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import "MainViewController.h"
#import "PTRouter.h"
#import "SVProgressHUD.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)goLogin:(UIButton *)sender {
    [PTRouter openURL:@"InnerJump://account/login?paramA=233&paramB=hhh"];
}

- (IBAction)goSetting:(UIButton *)sender {
    [PTRouter openURL:@"InnerJump://setting/browse?userID=007" callback:^(BOOL result) {
        if (!result) {
            [SVProgressHUD showInfoWithStatus:@"打开失败"];
        }
    }];
}
- (IBAction)goProfile:(UIButton *)sender {
    [PTRouter openURL:@"InnerJump://profile/profile?userID=007&nickName=jamesbond&sex=male&address=London" callback:^(BOOL result) {
        if (!result) {
            [SVProgressHUD showInfoWithStatus:@"打开失败"];
        }
    }];
}

- (IBAction)goError:(UIButton *)sender {
    [PTRouter openURL:@"jack://error/hero?userID=008" callback:^(BOOL result) {
        if (!result) {
            [SVProgressHUD showInfoWithStatus:@"打开失败"];
        }
    }];
}

@end
