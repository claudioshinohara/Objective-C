//
//  AppDelegate.h
//  AppMonitorExterno
//
//  Created by Claudio Shinohara on 17/09/14.
//  Copyright (c) 2014 Shinohara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;
//Declarando property para a janela externa
@property (nonatomic, strong) UIWindow *windowExterna;
//Comunicação enter o device a a UIWindow : UIScreen
@property (nonatomic, strong) UIScreen *screenExterna;

-(void)configurarMonitorExterno;

@end
