//
//  SceneDelegate.m
//  LHQ3DTouchDemo
//
//  Created by Xhorse_iOS3 on 2021/1/14.
//

#import "SceneDelegate.h"
#import "ViewController.h"

@interface SceneDelegate ()

@property (nonatomic, strong) UIApplicationShortcutItem *saveShortcutItem;

@end

@implementation SceneDelegate

/// 当用户触发主屏幕快速操作时 尚未加载该应用程序
- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    self.saveShortcutItem = connectionOptions.shortcutItem;
    
}


- (void)sceneDidDisconnect:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    
    NSString *triger = @"Not Load";
    NSString *tip;
    if ([self.saveShortcutItem.type isEqualToString:@"SearchAction"]) {
        tip = @"Quick Action [Search] ->";
    } else if ([self.saveShortcutItem.type isEqualToString:@"ShareAction"]) {
        tip = @"Quick Action [Share] ->";
    } else if ([self.saveShortcutItem.type isEqualToString:@"ContactAction"]) {
        tip = @"Quick Action [Contact] ->";
    } else if ([self.saveShortcutItem.type isEqualToString:@"AddAction"]) {
        tip = @"Quick Action [Add] ->";
    } else {
        tip = @"NULL";
    }
    NSString *msg = [NSString stringWithFormat:@"%@ - %@",triger, tip];
    NSLog(@"%@",msg);
    
    ViewController *vc = (ViewController *)self.window.rootViewController;
    vc.quickStr = msg;
    
}


- (void)sceneWillResignActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
    NSLog(@"sceneWillResign");
    
    
    if (self.saveShortcutItem == nil) {
        return;
    }
    // 1. 这里只是测试数据修改，直接写死type
//    NSMutableArray *cutItems = [NSMutableArray new];
//    for (UIMutableApplicationShortcutItem *item in [UIApplication sharedApplication].shortcutItems) {
//        if ([item.type isEqualToString:self.saveShortcutItem.type]) {
//            item.localizedTitle = @"test";
//            item.localizedSubtitle = @"test Subtitle";
//        }
//        [cutItems addObject:item];
//    }
//    [UIApplication sharedApplication].shortcutItems = cutItems;
    
    // 2. 直接替换数据测试
    UIApplicationShortcutIcon *contactIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeContact];
    UIApplicationShortcutItem *contact = [[UIMutableApplicationShortcutItem alloc] initWithType:@"ContactAction" localizedTitle:@"Contact test" localizedSubtitle:@"Address Book" icon:contactIcon userInfo:nil];
    UIApplicationShortcutIcon *addIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"add_icon"];
    UIApplicationShortcutItem *add = [[UIMutableApplicationShortcutItem alloc] initWithType:@"AddAction" localizedTitle:@"Add test" localizedSubtitle:nil icon:addIcon userInfo:nil];
    [UIApplication sharedApplication].shortcutItems = @[contact, add];
}


- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}

/// 当用户触发主屏幕快速操作时 如果应用程序已经加载，则系统将调用场景委托的功能
- (void)windowScene:(UIWindowScene *)windowScene performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler  API_AVAILABLE(ios(13.0)) {
    
    self.saveShortcutItem = shortcutItem;

}


@end
