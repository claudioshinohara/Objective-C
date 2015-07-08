//
//  GerenciadoArquivo.h
//  AppCloud
//
//  Created by Claudio Shinohara on 18/09/14.
//  Copyright (c) 2014 Shinohara. All rights reserved.
//

#import <UIKit/UIKit.h>

//Classe responsável por salvar e baixar o conteúdo do iCloud

@interface GerenciadoArquivo : UIDocument

@property (nonatomic, strong) NSMutableArray *arrAtualizacao;

@end
