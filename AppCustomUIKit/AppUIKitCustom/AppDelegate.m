//
//  AppDelegate.m
//  AppUIKitCustom
//
//  Created by Aluno on 9/3/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

-(void) customizarAparencia {
    //UINavigationBar - Customizar fundo do navigation
    UIImage *imgNavBar = [[UIImage imageNamed:@"navBar_44"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UINavigationBar appearance] setBackgroundImage:imgNavBar forBarMetrics:UIBarMetricsDefault];
    
    UIImage *imgNavBarLand = [[UIImage imageNamed:@"navBar_22"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UINavigationBar appearance] setBackgroundImage:imgNavBarLand forBarMetrics:UIBarMetricsLandscapePhone];
    
    //UINavigationBar - Customizar fundo do botão
    UIImage *imgBarButton = [[UIImage imageNamed:@"btn_30"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [[UIBarButtonItem appearance] setBackgroundImage:imgBarButton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIImage *imgBarButtonLand = [[UIImage imageNamed:@"btn_24"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [[UIBarButtonItem appearance] setBackgroundImage:imgBarButtonLand forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    
    //UINavigationBar - Customizar font do texto do navigation
    NSDictionary *dictFontBarra = @{
                                    NSForegroundColorAttributeName:[UIColor grayColor],
                                    NSFontAttributeName:[UIFont fontWithName:@"FuturaStd-Bold" size:20]};
    [[UINavigationBar appearance] setTitleTextAttributes:dictFontBarra];
    
    //UINavigationBar - Customizar font do texto do botão
    NSDictionary *dictFontBotao = @{
                                NSForegroundColorAttributeName:[UIColor blackColor],
                                NSFontAttributeName:[UIFont fontWithName:@"FuturaStd-Bold" size:14]};
    [[UIBarButtonItem appearance] setTitleTextAttributes:dictFontBotao forState:UIControlStateNormal];
    
    //UISlider
    UIImage *imgMin = [[UIImage imageNamed:@"slider_minimum"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [[UISlider appearance] setMinimumTrackImage:imgMin forState:UIControlStateNormal];
    UIImage *imgMax = [[UIImage imageNamed:@"slider_maximum"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [[UISlider appearance] setMaximumTrackImage:imgMax forState:UIControlStateNormal];
    UIImage *thumb = [UIImage imageNamed:@"thumb"];
    [[UISlider appearance] setThumbImage:thumb forState:UIControlStateNormal];
    
    //UISegmentedControl
    UIImage *imgSegSelect = [[UIImage imageNamed:@"segcontrol_sel"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 12)];
    [[UISegmentedControl appearance] setBackgroundImage:imgSegSelect forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    UIImage *imgSegNormal = [[UIImage imageNamed:@"segcontrol_uns"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 12)];
    [[UISegmentedControl appearance] setBackgroundImage:imgSegNormal forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    UIImage *imgSegDivSN = [[UIImage imageNamed:@"segcontrol_sel-uns"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 12)];
    [[UISegmentedControl appearance] setDividerImage:imgSegDivSN forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    UIImage *imgSegDivNS = [[UIImage imageNamed:@"segcontrol_uns-sel"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 12)];
    [[UISegmentedControl appearance] setDividerImage:imgSegDivNS forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    UIImage *imgSegDivNN = [[UIImage imageNamed:@"segcontrol_uns-uns"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 12)];
    [[UISegmentedControl appearance] setDividerImage:imgSegDivNN forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self customizarAparencia];
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
