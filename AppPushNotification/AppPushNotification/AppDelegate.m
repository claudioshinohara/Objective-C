//
//  AppDelegate.m
//  AppPushNotification
//
//  Created by Claudio Shinohara on 16/09/14.
//  Copyright (c) 2014 Shinohara. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //Cadastra este usuário no servidor da Apple
    [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound)];
    
    //Capta se o app foi aberto por um Push Notification
    NSDictionary *notificacao = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(notificacao){
        [[[UIAlertView alloc] initWithTitle:@"App Abriu Por Push Notification" message:notificacao.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"App Abriu Normalmente" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    
    
    return YES;
}

//Método acionando quando recebe um Push Notification e o app está aberto
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[[UIAlertView alloc] initWithTitle:@"Chegou um Push Notification" message:userInfo.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

//Método acionado quando o token do usuário já tiver sido cadastrado no servidor da Apple
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"O token é %@", deviceToken);
    //Local utilizado para implentar um método para salvar o token do usuário em uma base de dados
}

//Método acionado quando falha o registro do token na Apple por algum motivo de conexão
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Erro: %@", error.description);
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
