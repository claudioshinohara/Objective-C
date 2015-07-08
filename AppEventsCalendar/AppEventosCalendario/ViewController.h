//
//  ViewController.h
//  AppEventosCalendario
//
//  Created by Aluno on 8/21/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import <UIKit/UIKit.h>

//Framework para manipulação de calendário e lembretes
@import EventKit;
@import EventKitUI;

@interface ViewController : UIViewController <EKEventEditViewDelegate, UITableViewDelegate, UITableViewDataSource>

//Objeto responsável por manipular eventos no calendário diretamente
@property (nonatomic, strong) EKEventStore *baseEventos;

@end
