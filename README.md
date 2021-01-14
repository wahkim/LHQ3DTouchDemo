
@[TOC](主屏幕快捷操作（Quick Actions）)

## 简介
在iOS 9及以上系统，支持3D Touch的手机设备中，触摸并短按任何应用程序以编辑主屏幕并获得一组快速操作。当用户选择快速操作时，您的应用程序将激活或启动，并且您的应用程序委托对象会收到快速操作消息。

每个主屏幕快速操作均包括标题，左侧或右侧的图标（取决于应用程序在主屏幕上的位置）以及可选的字幕。在构建时从应用程序==静态定义==快速操作，或者在运行时==动态定义==快速操作。有关您可能会使用快速操作公开的功能类型的信息，请参见[《人机界面指南》](https://developer.apple.com/design/human-interface-guidelines/ios/system-capabilities/home-screen-actions/)。

## 支持
1. 设备： iPhone 6S 和 6S Plus 及后续出的 iPhone 系列
2. 系统：iOS 9及以上系统（iOS 9.0 开始支持 3D Touch）。

## 效果图
![在这里插入图片描述](https://img-blog.csdnimg.cn/20210114151641704.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0hRX0xJTg==,size_16,color_FFFFFF,t_70 =350x667)


## 定义方式
- 定义静态快速动作（Info.plist 文件添加创建）

以下是定义了两个静态快速动作：一个用于搜索，另一个用于共享。在该关键文件包含两本词典是代表了两个静态快速行动的数组
```javascript
<key>UIApplicationShortcutItems</key>
<array>
    <dict>
        <key>UIApplicationShortcutItemType</key>
        <string>SearchAction</string>
        <key>UIApplicationShortcutItemIconType</key>
        <string>UIApplicationShortcutIconTypeSearch</string>
        <key>UIApplicationShortcutItemTitle</key>
        <string>Search</string>
        <key>UIApplicationShortcutItemSubtitle</key>
        <string>Search for an item</string>
    </dict>
    <dict>
        <key>UIApplicationShortcutItemType</key>
        <string>ShareAction</string>
        <key>UIApplicationShortcutItemIconType</key>
        <string>UIApplicationShortcutIconTypeShare</string>
        <key>UIApplicationShortcutItemTitle</key>
        <string>Share</string>
        <key>UIApplicationShortcutItemSubtitle</key>
        <string>Share an item</string>
    </dict>
</array>
```

- 定义动态快速动作（代码创建）

以下是定义了两个静态快速动作：一个是联系人，另一个是添加。
```javascript
UIApplicationShortcutIcon *contactIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeContact];
UIApplicationShortcutItem *contact = [[UIApplicationShortcutItem alloc] initWithType:@"ContactAction" localizedTitle:@"Contact" localizedSubtitle:@"Address Book" icon:contactIcon userInfo:nil];
UIApplicationShortcutIcon *addIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"add_icon"];
UIApplicationShortcutItem *add = [[UIApplicationShortcutItem alloc] initWithType:@"AddAction" localizedTitle:@"Add" localizedSubtitle:nil icon:addIcon userInfo:nil];
application.shortcutItems = @[contact, add];
```

> `UIApplicationShortcutItemType` 唯一标识
> `UIApplicationShortcutItemTitle` 	显示的标题
> `UIApplicationShortcutItemSubtitle` 显示的副标题
> `UIApplicationShortcutItemIconType`	使用系统的图标
> `UIApplicationShortcutItemIconFile` 使用项目的图标
> `UIApplicationShortcutItemUserInfo` 附加的信息

要支持旧版本的iOS，您可以在给定的应用程序中指定多个与图标相关的键。iOS按以下顺序选择图标：Info.plistUIApplicationShortcutItem
- UIApplicationShortcutItemIconSymbolName
- UIApplicationShortcutItemIconFile
- UIApplicationShortcutItemIconType

如果已定义，iOS会首选符号名称图标，否则，则首选图标文件，否则，最后的选择是图标类型。

## 响应触发
### <1> 如果项目工程里保留了`scene（场景）`
-  如果尚未加载该应用程序，则会启动该应用程序。通过函数`scene: willConnectToSession: options:`传递快捷方式项的详细信息。
```javascript
- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
	// 获取动作信息
    self.saveShortcutItem = connectionOptions.shortcutItem; 
}
```

- 如果应用程序已经加载，则系统将调用场景委托的功能。通过函数`windowScene:performActionForShortcutItem: completionHandler:`传递快捷方式项的详细信息。
 ```javascript
- (void)windowScene:(UIWindowScene *)windowScene performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler  API_AVAILABLE(ios(13.0))  {
	 // 获取动作信息
    self.saveShortcutItem = shortcutItem;
}
```

- 最后通过函数`sceneDidBecomeActive:` 及`UIApplicationShortcutItemType` 实现你想要的操作。
```javascript
- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    if ([self.saveShortcutItem.type isEqualToString:@"SearchAction"]) {
        NSLog(@"Quick Action [Search] ->");
    } else if ([self.saveShortcutItem.type isEqualToString:@"ShareAction"]) {
        NSLog( @"Quick Action [Share] ->");
    } else if ([self.saveShortcutItem.type isEqualToString:@"ContactAction"]) {
        NSLog(@"Quick Action [Contact] ->");
    } else if ([self.saveShortcutItem.type isEqualToString:@"AddAction"]) {
        NSLog(@"Quick Action [Add] ->");
    } else {
        NSLog(@"NULL");
    }
}
```


### <2> 如果项目工程里只有`window（窗口）`

-  如果尚未加载该应用程序，则会启动该应用程序。通过函数`application: didFinishLaunchingWithOptions::`传递快捷方式项的详细信息。
```javascript
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    UIApplicationShortcutItem *shortItem = [launchOptions objectForKey:UIApplicationLaunchOptionsShortcutItemKey];
    if (shortItem != nil) {
     	// 获取动作信息
        self.saveShortcutItem = shortItem;
        return NO;
    } else {
        self.saveShortcutItem = nil;
        return YES;
    }
    
    return YES;
}
```

- 如果应用程序已经加载，则系统将调用场景委托的功能。通过函数`application:performActionForShortcutItem: completionHandler:`传递快捷方式项的详细信息。
 ```javascript
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    self.saveShortcutItem = shortcutItem;  
}
```

- 最后通过函数`applicationDidBecomeActive:` 及`UIApplicationShortcutItemType` 实现你想要的操作。
```javascript
- (void)applicationDidBecomeActive:(UIApplication *)application {
    if ([self.saveShortcutItem.type isEqualToString:@"SearchAction"]) {
        NSLog(@"Quick Action [Search] ->");
    } else if ([self.saveShortcutItem.type isEqualToString:@"ShareAction"]) {
        NSLog( @"Quick Action [Share] ->");
    } else if ([self.saveShortcutItem.type isEqualToString:@"ContactAction"]) {
        NSLog(@"Quick Action [Contact] ->");
    } else if ([self.saveShortcutItem.type isEqualToString:@"AddAction"]) {
        NSLog(@"Quick Action [Add] ->");
    } else {
        NSLog(@"NULL");
    }
}
```

## 修改快捷项数据
>notice: 无法修改静态定义的快捷项的数据。

场景：在App页面中做了数据修改，点击home键回到主屏幕短按，显示快捷项列表，需更新其中一项数据。
函数:  在程序回到后台的时候修改（`sceneWillResignActive:`）
- 尝试一：==✖️==
修改`UIApplicationShortcutItem` , 中的`localizedTitle`、`localizedSubtitle`发现是只读（readonly）的，不可修改。

- 尝试二：==✖️==
查看里面的API，发现有一个可变的`UIMutableApplicationShortcutItem`, 获取应用的shortcutItems，找到对应的item修改`localizedTitle`、`localizedSubtitle`,代码看起来没问题，其实没效果。
```javascript
for (UIMutableApplicationShortcutItem *item in [UIApplication sharedApplication].shortcutItems) {
        if ([item.type isEqualToString:self.saveShortcutItem.type]) {
            item.localizedTitle = @"test";
            item.localizedSubtitle = @"test Subtitle";
        }
    }
```

- 尝试三：==✔️==
重新赋值`[UIApplication sharedApplication].shortcutItems`.

```javascript
UIApplicationShortcutIcon *contactIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeContact];
    UIApplicationShortcutItem *contact = [[UIMutableApplicationShortcutItem alloc] initWithType:@"ContactAction" localizedTitle:@"Contact test" localizedSubtitle:@"Address Book" icon:contactIcon userInfo:nil];
    UIApplicationShortcutIcon *addIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"add_icon"];
    UIApplicationShortcutItem *add = [[UIMutableApplicationShortcutItem alloc] initWithType:@"AddAction" localizedTitle:@"Add test" localizedSubtitle:nil icon:addIcon userInfo:nil];
    [UIApplication sharedApplication].shortcutItems = @[contact, add];
```

## 参考资料
[Menus and Shortcuts](https://developer.apple.com/documentation/uikit/menus_and_shortcuts)
[Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/user-interaction/3d-touch/)
[Adopting 3D Touch on iPhone](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/Adopting3DTouchOniPhone/index.html#//apple_ref/doc/uid/TP40016543-CH1-SW1)
