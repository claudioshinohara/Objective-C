//
//  Livro.h
//  AppBancoDeDados
//
//  Created by Aluno on 9/10/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseHandler.h"

//Classe responsável por gerenciar a manipulação na tabela Livro

@interface Livro : NSObject

@property (nonatomic, strong) NSString *autor;
@property (nonatomic, strong) NSString *titulo;
@property (nonatomic, assign) int ano;
@property (nonatomic, assign) int identificador;

//INSERIR ou ATUALIZAR registro do Livro
-(void) salvar;

-(void) apagar;

+(NSArray*) retornarTodosLivros;

@end
