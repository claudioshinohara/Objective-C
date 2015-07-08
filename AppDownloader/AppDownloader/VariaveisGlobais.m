//
//  VariaveisGlobais.m
//  AppDownloader
//
//  Created by Aluno on 9/15/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "VariaveisGlobais.h"

@implementation VariaveisGlobais

static VariaveisGlobais *instaciaCompartilhada;

//Método chamado para obter esta instância compartilhada
+(VariaveisGlobais*)shared {
    if (instaciaCompartilhada == nil) {
        instaciaCompartilhada = [[self alloc] init];
    }
    return instaciaCompartilhada;
}

@end
