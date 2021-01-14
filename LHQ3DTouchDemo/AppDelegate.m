//
//  AppDelegate.m
//  LHQ3DTouchDemo
//
//  Created by Xhorse_iOS3 on 2021/1/14.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if (@available(iOS 9.0, *)) {
        UIApplicationShortcutIcon *contactIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeContact];
        UIApplicationShortcutItem *contact = [[UIMutableApplicationShortcutItem alloc] initWithType:@"ContactAction" localizedTitle:@"Contact" localizedSubtitle:@"Address Book" icon:contactIcon userInfo:nil];
        UIApplicationShortcutIcon *addIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"add_icon"];
        UIApplicationShortcutItem *add = [[UIMutableApplicationShortcutItem alloc] initWithType:@"AddAction" localizedTitle:@"Add" localizedSubtitle:nil icon:addIcon userInfo:nil];
        application.shortcutItems = @[contact, add];
    }
    
    
//    UIApplicationShortcutItem *shortItem = [launchOptions objectForKey:UIApplicationLaunchOptionsShortcutItemKey];
//    if (shortItem != nil) {
//        self.saveShortcutItem = shortItem;
//        return NO;
//    } else {
//        self.saveShortcutItem = nil;
//        return YES;
//    }
    return YES;
}

//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    NSString *triger = @"Not Load";
//    NSString *tip;
//    if ([self.saveShortcutItem.type isEqualToString:@"SearchAction"]) {
//        tip = @"Quick Action [Search] ->";
//    } else if ([self.saveShortcutItem.type isEqualToString:@"ShareAction"]) {
//        tip = @"Quick Action [Share] ->";
//    } else {
//        tip = @"NULL";
//    }
//    NSString *msg = [NSString stringWithFormat:@"%@ - %@",triger, tip];
//    NSLog(@"%@",msg);
//
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"quickActionNoitification" object:nil userInfo:@{@"title": msg}];
//}
//
//- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
//    self.saveShortcutItem = shortcutItem;
//}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
