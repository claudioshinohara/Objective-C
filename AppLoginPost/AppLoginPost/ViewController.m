//
//  ViewController.m
//  AppLoginPost
//
//  Created by Aluno on 9/11/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtUsuario;
@property (weak, nonatomic) IBOutlet UITextField *txtLogin;
@property (weak, nonatomic) IBOutlet UITextView *txtRetorno;
@property (weak, nonatomic) IBOutlet UITableView *tableUsuario;

@property (nonatomic, strong) NSMutableData *dadosRecebidos;
@property (nonatomic, strong) NSURLConnection *minhaConexao;
@property (nonatomic, strong) NSMutableArray *arrUsuarios;

- (IBAction)loginPressionado:(id)sender;
- (IBAction)cadastrarPressionado:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.txtRetorno.text = @"";
    
    //Endereço da requisição
    NSURL *url = [NSURL URLWithString:@"http://www.fernandopastor.sitepessoal.com/aula/getUsuarios.php"];
    //Criando requisição com a url
    NSMutableURLRequest *requiscao = [NSMutableURLRequest requestWithURL:url];
    //Enviando a requisição
    self.minhaConexao = [NSURLConnection connectionWithRequest:requiscao delegate:self];
    
}

- (IBAction)loginPressionado:(id)sender {
    if(self.txtUsuario.text.length > 0 && self.txtLogin.text.length > 0) {
        [self.txtLogin becomeFirstResponder];
        [self.txtLogin resignFirstResponder];
        
        //Endereço da requisição
        NSURL *url = [NSURL URLWithString:@"http://www.fernandopastor.sitepessoal.com/aula/login.php"];
        //Criando requisição com a url
        NSMutableURLRequest *requiscao = [NSMutableURLRequest requestWithURL:url];
        //Definindo método de envio
        [requiscao setHTTPMethod:@"POST"];
        //Criando os parâmetros
        NSString *parametros = [NSString stringWithFormat:@"usuario=%@&senha=%@", self.txtUsuario.text, self.txtLogin.text];
        //Adicionando os parâmetros no corpo da requisição
        NSData *data = [parametros dataUsingEncoding:NSUTF8StringEncoding];
        [requiscao setHTTPBody:data];
        
        //Limpando os campos
        self.txtRetorno.text = @"";
        self.txtUsuario.text = @"";
        self.txtLogin.text = @"";
        
        //Enviando a requisição
        [NSURLConnection connectionWithRequest:requiscao delegate:self];
        
    } else {
        self.txtRetorno.text = @"Preencha os campos corretamente!";
    }
}

- (IBAction)cadastrarPressionado:(id)sender {
    if(self.txtUsuario.text.length > 0 && self.txtLogin.text.length > 0) {
        [self.txtLogin becomeFirstResponder];
        [self.txtLogin resignFirstResponder];
    
        //Endereço da requisição
        NSURL *url = [NSURL URLWithString:@"http://www.fernandopastor.sitepessoal.com/aula/cadastrar.php"];
        //Criando requisição com a url
        NSMutableURLRequest *requiscao = [NSMutableURLRequest requestWithURL:url];
        //Definindo método de envio
        [requiscao setHTTPMethod:@"POST"];
        //Criando os parâmetros
        NSString *parametros = [NSString stringWithFormat:@"usuario=%@&senha=%@", self.txtUsuario.text, self.txtLogin.text];
        //Adicionando os parâmetros no corpo da requisição
        NSData *data = [parametros dataUsingEncoding:NSUTF8StringEncoding];
        [requiscao setHTTPBody:data];
    
        //Limpando os campos
        self.txtRetorno.text = @"";
        self.txtUsuario.text = @"";
        self.txtLogin.text = @"";
        
        //Enviando a requisição
        [NSURLConnection connectionWithRequest:requiscao delegate:self];
        
    } else {
        self.txtRetorno.text = @"Preencha os campos corretamente!";
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.dadosRecebidos = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.dadosRecebidos appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if(connection == self.minhaConexao) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self.dadosRecebidos options:NSJSONReadingAllowFragments error:nil];
        self.arrUsuarios = dict[@"usuarios"];
        [self.tableUsuario reloadData];
    } else {
        self.txtRetorno.text = [[NSString alloc] initWithData:self.dadosRecebidos encoding:NSUTF8StringEncoding];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (error.code == -1009) {
        self.txtRetorno.text = @"Sem conexão!";
    } else if (error.code == -1003){
        self.txtRetorno.text = @"Servidor não encontrado!";
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *celula = [tableView dequeueReusableCellWithIdentifier:@"celula"];
    celula.textLabel.text = self.arrUsuarios[indexPath.row][@"usuario"];
    celula.detailTextLabel.text = self.arrUsuarios[indexPath.row][@"senha"];
    
    return celula;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrUsuarios.count;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
