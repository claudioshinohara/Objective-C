//
//  ViewController.m
//  AppNotificacaoLocal
//
//  Created by Aluno on 9/12/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)lancarNotificacao:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)lancarNotificacao:(id)sender {
    UILocalNotification *ln = [[UILocalNotification alloc] init];
    ln.alertBody = @"Sou uma notificação";
    
    //Seta uma data para lançar a notificação
    ln.fireDate = [NSDate dateWithTimeIntervalSinceNow:10]; //Seta a notificação para daqui 10 segundos
    
    //Seta uma data para lançar a notificação
    /*NSDateFormatter *formatador = [[NSDateFormatter alloc] init];
    [formatador setDateFormat:@"dd-MM-yyyy-HH:mm:ss"];
    NSString *strData = @"12-09-2014-21:21:00";
    NSDate *data = [formatador dateFromString:strData];
    ln.fireDate = data;*/
    
    //Seta uma imagem
    ln.alertLaunchImage = @"imagem.jpg";
    
    //Adicionando informações no alerta
    ln.userInfo = @{@"chave":@"Informação da Notificação"};
    
    //Número que aparecerá em cima do ícone do aplicativo
    ln.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    //Retiramos este número no didBecameActive do AppDelegate
    
    //Agenda a notificação
    [[UIApplication sharedApplication] scheduleLocalNotification:ln];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
