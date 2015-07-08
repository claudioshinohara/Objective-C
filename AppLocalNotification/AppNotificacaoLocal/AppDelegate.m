//
//  AppDelegate.m
//  AppNotificacaoLocal
//
//  Created by Aluno on 9/12/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

//Método acionado quando chega uma notificação e o app está aberto
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [[[UIAlertView alloc] initWithTitle:@"Notificação Local" message:notification.userInfo.description  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    application.applicationIconBadgeNumber = 0;
}

//Método acionado quando o app está totalmente fechado e é aberto
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Verificando se o app foi aberto por uma notificação
    UILocalNotification *notificacao = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if(notificacao){
        [[[UIAlertView alloc] initWithTitle:@"Notificação Local" message:notificacao.userInfo.description  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    } else {
        [[[UIAlertView alloc] initWithTitle:nil message:@"App abriu normalmente"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
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
    //Retira o número de cima do ícone do App
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
