//
//  AppDelegate.m
//  AppMonitorExterno
//
//  Created by Claudio Shinohara on 17/09/14.
//  Copyright (c) 2014 Shinohara. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewControllerExterna.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //Verifica se ao abrir o app existe algum monitor externo
    if([UIScreen screens].count > 1){
        [self configurarMonitorExterno];
    }
    //Se adiciona no Notification Center para saber quando um monitor externo se conectar futuramente
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configurarMonitorExterno) name:UIScreenDidConnectNotification object:nil];
    return YES;
}

-(void)configurarMonitorExterno {
    //Dentro da classe UIScreen temos um array chamado screens, onde estão armazenados os objetos UIScreen, referentes a cada monitor
    self.screenExterna = [[UIScreen screens] objectAtIndex:1];
    
    //Lança um alerta para o usuário selecionar a resolução desejada
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Monitor detectado" message:@"Selecione a resolução" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    NSArray *resolucoes = self.screenExterna.availableModes;
    for(int i=0; i<resolucoes.count; i++){
        UIScreenMode *r = resolucoes[i];
        [alerta addButtonWithTitle:[NSString stringWithFormat:@"%.0f x %.0f", r.size.width, r.size.height]];
    }
    [alerta show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //Quando o usuário selecionar uma resolução, cria a windowExterna
    self.screenExterna.currentMode = [self.screenExterna.availableModes objectAtIndex:buttonIndex];
    self.windowExterna = [[UIWindow alloc] initWithFrame:self.screenExterna.bounds];
    
    //Identificando o monitor que esta window aparecerá
    self.windowExterna.screen = self.screenExterna;
    self.windowExterna.backgroundColor = [UIColor greenColor];
    
    //Criando a ViewController para a windowExterna
    ViewControllerExterna *vce = [[ViewControllerExterna alloc] init];
    vce.view.frame = self.windowExterna.frame;
    vce.view.backgroundColor = [UIColor whiteColor];
    
    //Relaciona o vce com a windowExterna
    self.windowExterna.rootViewController = vce;
    
    [self.windowExterna makeKeyAndVisible];
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
