//
//  ViewController.m
//  AppBancoDeDados
//
//  Created by Aluno on 9/10/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"
#import "Livro.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtAutor;
@property (weak, nonatomic) IBOutlet UITextField *txtTitulo;
@property (weak, nonatomic) IBOutlet UITextField *txtAno;
@property (weak, nonatomic) IBOutlet UITableView *tabela;
@property (weak, nonatomic) IBOutlet UIButton *btnCadastrar;
@property (weak, nonatomic) IBOutlet UIButton *btnLimpar;

@property (nonatomic, strong) NSArray *todosLivros;
@property (nonatomic, assign) BOOL atualizando;
@property (nonatomic, strong) Livro *livroASerAtualizado;

- (IBAction)cadastrar:(id)sender;
- (IBAction)limparCampos:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.todosLivros = [Livro retornarTodosLivros];
    [self.tabela reloadData];
}

- (IBAction)cadastrar:(id)sender {
    [self.txtAno becomeFirstResponder];
    [self.txtAno resignFirstResponder];
    
    if(!self.atualizando){
        //Cadastra novo Livro
        Livro *novoLivro = [[Livro alloc] init];
        novoLivro.titulo = self.txtTitulo.text;
        novoLivro.autor = self.txtAutor.text;
        novoLivro.ano = [self.txtAno.text intValue];
        
        [novoLivro salvar];
    } else {
        self.livroASerAtualizado.titulo = self.txtTitulo.text;
        self.livroASerAtualizado.autor = self.txtAutor.text;
        self.livroASerAtualizado.ano = [self.txtAno.text intValue];
        
        [self.livroASerAtualizado salvar];
        [self.btnCadastrar setTitle:@"Cadastrar" forState:UIControlStateNormal];
    }
    
    self.todosLivros = [Livro retornarTodosLivros];
    [self.tabela reloadData];
    
    self.txtTitulo.text = nil;
    self.txtAutor.text = nil;
    self.txtAno.text = nil;
}

- (IBAction)limparCampos:(id)sender {
    self.txtTitulo.text = nil;
    self.txtAutor.text = nil;
    self.txtAno.text = nil;
    
    [self.btnCadastrar setTitle:@"Cadastrar" forState:UIControlStateNormal];
    
    self.atualizando = NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.livroASerAtualizado = self.todosLivros[indexPath.row];
    self.txtTitulo.text = self.livroASerAtualizado.titulo;
    self.txtAutor.text = self.livroASerAtualizado.autor;
    self.txtAno.text = [NSString stringWithFormat:@"%d",self.livroASerAtualizado.ano];
    
    [self.btnCadastrar setTitle:@"Atualizar" forState:UIControlStateNormal];
    self.atualizando = YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *celula = [tableView dequeueReusableCellWithIdentifier:@"idCelula"];
    Livro *livro = self.todosLivros[indexPath.row];
    celula.textLabel.text = livro.titulo;
    celula.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%d)", livro.autor, livro.ano];
    
    return celula;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    Livro *livroApagado = self.todosLivros[indexPath.row];
    [livroApagado apagar];
    self.todosLivros = [Livro retornarTodosLivros];
    [self.tabela reloadData];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Livros Cadastrados";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todosLivros.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
