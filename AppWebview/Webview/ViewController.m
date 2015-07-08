//
//  ViewController.m
//  Webview
//
//  Created by Bruno Daniele on 8/19/14.
//  Copyright (c) 2014 BRUNODANIELE. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *campoEndereco;
@property (weak, nonatomic) IBOutlet UIWebView *meuWebview;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicador;
- (IBAction)botaoSearchPressionado:(id)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *barraBusca;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Carregamento de uma pagina inicial
    [self CarregarPagina:@"http://iai.art.br"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)botaoSearchPressionado:(id)sender {
    
    if (self.barraBusca.center.x < 0){
        [UIView animateWithDuration:0.3 animations:^{
            //codigo
            self.barraBusca.center = CGPointMake(160.0, 64.0);
            self.barraBusca.alpha = 1.0;
        } completion:^(BOOL finished) {
            [self.barraBusca becomeFirstResponder];
        }];
    }
    else{
        [UIView animateWithDuration:0.3 animations:^{
            //codigo
            self.barraBusca.center = CGPointMake(-160, 64.0);
            self.barraBusca.alpha = 0.0;
        }];
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //remover qualquer http
    self.campoEndereco.text = [self.campoEndereco.text stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    
    //remover qualquer https
    self.campoEndereco.text = [self.campoEndereco.text stringByReplacingOccurrencesOfString:@"https://" withString:@""];
    
    //adicionar o http:
    
    NSString *textoNovaURL = [NSString stringWithFormat:@"http://%@",self.campoEndereco.text];
    
    [self CarregarPagina:textoNovaURL];
    [textField resignFirstResponder];
    return YES;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.indicador stopAnimating];
    self.indicador.hidden = YES;
    
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    NSString *semHTTP = [self.meuWebview.request.URL.absoluteString stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    
    semHTTP = [self.meuWebview.request.URL.absoluteString stringByReplacingOccurrencesOfString:@"https://" withString:@""];
    
    self.campoEndereco.text = semHTTP;
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    self.indicador.hidden = NO;
    [self.indicador startAnimating];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //codigo aqui
    
    self.indicador.hidden = YES;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Ops!" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    
    [alerta show];
}

-(void)CarregarPagina:(NSString *)endereco{
   
    // Do any additional setup after loading the view, typically from a nib.
    
    //Carregamento de uma pagina inicial
    //Montando a URL com o carregamento da pagina inicial
    NSURL *urlInicial = [NSURL URLWithString:endereco];
    
    //Montando uma requisicao a partir desta URL
    NSURLRequest *requisicao = [NSURLRequest requestWithURL:urlInicial];
    
    //Solicitando ao webview o carregamento da requisicao
    [self.meuWebview loadRequest:requisicao];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    
    
    if (self.barraBusca.selectedScopeButtonIndex == 0){
        self.campoEndereco.text = [NSString stringWithFormat:@"http://www.google.com/search?q=%@",self.barraBusca.text];
        
        
    }
    else{
        self.campoEndereco.text = [NSString stringWithFormat:@"http://search.yahoo.com/search?p=%@",self.barraBusca.text];
        
    }
    
    self.campoEndereco.text = [self.campoEndereco.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    //Esconder o teclado
    [self.barraBusca resignFirstResponder];
    
    //Esconder a barra
    [self botaoSearchPressionado:nil];
    
    //Carregar a busca no webview
    [self textFieldShouldReturn:self.campoEndereco];
}

@end
