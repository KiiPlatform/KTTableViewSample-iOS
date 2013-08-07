//
//  AppDelegate.m
//  KTTableViewSample
//
//  Created by Chris on 7/11/13.
//  Copyright (c) 2013 Kii. All rights reserved.
//

#import "AppDelegate.h"

#import "MyTableViewController.h"

#import <KiiSDK/Kii.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [Kii beginWithID:@""
              andKey:@""];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    MyTableViewController *vc = [[MyTableViewController alloc] initWithStyle:UITableViewStylePlain];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:vc];

    self.window.rootViewController = self.navigationController;

    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
