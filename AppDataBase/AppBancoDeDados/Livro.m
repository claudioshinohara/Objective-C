//
//  Livro.m
//  AppBancoDeDados
//
//  Created by Aluno on 9/10/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "Livro.h"

@interface Livro()

@property (nonatomic) BOOL jaFoiInserido;

@end

@implementation Livro

-(void) salvar{
    if(!self.jaFoiInserido){
        //Insere
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO Livro (titulo, autor, ano) VALUES ('%@', '%@',%d);", self.titulo, self.autor, self.ano];
        [[DatabaseHandler shared] runSQL:sql];
        self.jaFoiInserido = YES;
        self.identificador = [[DatabaseHandler shared] idDoUltimoItemCadastrado];
    } else {
        //Atualizar
        //Insere
        NSString *sql = [NSString stringWithFormat:@"UPDATE Livro SET titulo = '%@', autor = '%@', ano = %d WHERE identificador = %d;", self.titulo, self.autor, self.ano, self.identificador];
        [[DatabaseHandler shared] runSQL:sql];
    }
}

-(void) apagar{
    if(self.jaFoiInserido){
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM Livro WHERE identificador = %d", self.identificador];
        [[DatabaseHandler shared] runSQL:sql];
    } else {
        NSLog(@"O livro ainda não foi inserido.");
    }
}

+(NSArray*) retornarTodosLivros{
    NSMutableArray *arrLivros = [[NSMutableArray alloc] init];
    
    NSString *sql = @"SELECT * FROM Livro;";
    sqlite3_stmt *resultado = [[DatabaseHandler shared] runSQL:sql];
    
    while (sqlite3_step(resultado) == SQLITE_ROW) {
        Livro *row = [[self alloc] init];
        
        const char *textoAutor = (const char*)sqlite3_column_text(resultado, 0);
        row.autor = [NSString stringWithCString:textoAutor encoding:NSUTF8StringEncoding];
        
        const char *textoTitulo = (const char*)sqlite3_column_text(resultado, 1);
        row.titulo = [NSString stringWithCString:textoTitulo encoding:NSUTF8StringEncoding];
        
        row.ano = sqlite3_column_int(resultado, 2);
        row.identificador = sqlite3_column_int(resultado, 3);
        
        row.jaFoiInserido = YES;
        
        [arrLivros addObject:row];
    }
    
    return arrLivros;
}

@end
