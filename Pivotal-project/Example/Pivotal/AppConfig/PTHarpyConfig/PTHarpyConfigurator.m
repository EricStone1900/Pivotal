//
//  PTHarpyConfigurator.m
//  Pivotal
//
//  Created by song on 2020/7/21.
//  Copyright © 2020 huangbo. All rights reserved.
//

#import "PTHarpyConfigurator.h"
#import "PTAppLaunchHelper.h"
#import "Harpy.h"
#import "PTAppEventBus.h"
#import "Pivotal-Swift.h"

@interface PTHarpyConfigurator()<AppLaunchProtocol>
@property (nonatomic, assign) BOOL isAppStore;
@end

@implementation PTHarpyConfigurator
- (void)initializeWhenLaunch {
    NSDictionary *dict = [self dictWithPlist:@"AppConfigurator.plist"];
    [self safeSetValuesForKeys:[dict objectForKey:NSStringFromClass([self class])]];
    Harpy *harpyShare = [Harpy sharedInstance];
    harpyShare.presentingViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    harpyShare.alertControllerTintColor = [UIColor purpleColor];
    harpyShare.alertType = HarpyAlertTypeOption;
    harpyShare.forceLanguageLocalization = HarpyLanguageChineseSimplified;
    harpyShare.debugEnabled = FALSE;
    [harpyShare checkVersion];
    
    [PTAppEventBus.shared.didBecomeActive observeWithBlock:^(id newValue) {
        if (self.isAppStore == TRUE) {
            [harpyShare checkVersionWeekly];
        }
    }];
    
}

@end
