//
//  VariaveisGlobais.h
//  AppDownloader
//
//  Created by Aluno on 9/15/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import <Foundation/Foundation.h>

//Singleton - Instância única - Iremos guardar váriaveis que poderão ser acessadas em qualquer parte do projeto

@interface VariaveisGlobais : NSObject

@property (nonatomic, assign) BOOL estaBaixando;
@property (nonatomic, assign) UIBackgroundTaskIdentifier identificadorTarefa;

+(VariaveisGlobais*)shared;

@end
