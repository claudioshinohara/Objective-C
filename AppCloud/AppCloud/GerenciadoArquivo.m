//
//  GerenciadoArquivo.m
//  AppCloud
//
//  Created by Claudio Shinohara on 18/09/14.
//  Copyright (c) 2014 Shinohara. All rights reserved.
//

#import "GerenciadoArquivo.h"

@implementation GerenciadoArquivo

-(id)initWithFileURL:(NSURL *)url {
    self = [super initWithFileURL:url];
    
    if(self){
        self.arrAtualizacao = [[NSMutableArray alloc] init];
    }
    
    return self;
}

//Sobreescrevendo métodos para salvar e ler do iCloud

//Método acionado pelo iCloud para solicitar os dados que serão salvaos nele quando mandarmos fazer o upload de algo
-(id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    //O retorno deste método é aquilo que vai ser salvo no iCloud
    //Para fazer comunicação de dados pela rede, devemos usar NSData
    //Convertendo em NSData
    NSData *dadosArray = [NSKeyedArchiver archivedDataWithRootObject:self.arrAtualizacao];
    return dadosArray;
}

//Método acionado ao ler o conteúdo do iCloud
-(BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    if([contents length] > 0){
        self.arrAtualizacao = [NSKeyedUnarchiver unarchiveObjectWithData:contents];
    }
    return YES;
}

@end


