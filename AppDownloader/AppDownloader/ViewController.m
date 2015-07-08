//
//  ViewController.m
//  AppDownloader
//
//  Created by Aluno on 9/15/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btDownload;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblVelocidade;
@property (weak, nonatomic) IBOutlet UILabel *lblNome;
@property (weak, nonatomic) IBOutlet UIProgressView *barProgress;
@property (weak, nonatomic) IBOutlet UIImageView *imgDownloaded;

@property (nonatomic, assign) float tamanhoTotalArquivo, totalRecebidoAntes, totalRecebidoAteAgora;
@property (nonatomic, assign) BOOL downloadJaComecou;
@property (nonatomic, strong) NSTimer *timerParaVelocidade;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSURLConnection *downloadConnection;
@property (nonatomic, strong) NSMutableData *dadosRecebidos;

- (IBAction)iniciarCancelarDownload:(id)sender;

//Método acionado pelo Timer
-(void)atualizarVelocidade;
-(NSString*)ajustarUnidade:(float)tamanho;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.url = [NSURL URLWithString:@"http://fc08.deviantart.net/fs71/f/2011/268/5/e/megan_fox_2_by_yalim1907-d3b9aaw.jpg"];
}

- (IBAction)iniciarCancelarDownload:(id)sender {
    if(!self.downloadJaComecou){
        NSURLRequest *requisicao = [NSURLRequest requestWithURL:self.url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:20];
        self.downloadConnection = [NSURLConnection connectionWithRequest:requisicao delegate:self];
        
        self.downloadJaComecou = YES;
        [VariaveisGlobais shared].estaBaixando = YES;
        self.lblNome.text = @"";
        self.lblStatus.text = @"";
        self.lblVelocidade.text = @"";
        self.imgDownloaded.image = nil;
        [self.btDownload setTitle:@"Cancelar Download" forState:UIControlStateNormal];
    } else {
        self.lblStatus.text = @"";
        self.lblVelocidade.text = @"";
        self.lblNome.text = @"";
        
        [self.timerParaVelocidade invalidate];
        
        self.tamanhoTotalArquivo = 0;
        self.totalRecebidoAntes = 0;
        self.totalRecebidoAteAgora = 0;
        self.downloadJaComecou = NO;
        [VariaveisGlobais shared].estaBaixando = NO;
        
        self.barProgress.progress = 0;
        
        [self.downloadConnection cancel];
        
        [self.btDownload setTitle:@"Inicar Dowload" forState:UIControlStateNormal];
    }
}

-(void)atualizarVelocidade{
    int conteudoPorSegundo = self.totalRecebidoAteAgora - self.totalRecebidoAntes;
    NSString *unidadeAjsutada = [self ajustarUnidade:conteudoPorSegundo];
    self.totalRecebidoAntes = self.totalRecebidoAteAgora;
    self.lblVelocidade.text = [NSString stringWithFormat:@"%@/s", unidadeAjsutada];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.lblVelocidade.text = @"Iniciando Download...";
    self.dadosRecebidos = [[NSMutableData alloc] init];
    self.timerParaVelocidade = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(atualizarVelocidade) userInfo:nil repeats:YES];
    self.totalRecebidoAntes = 0;
    self.totalRecebidoAteAgora = 0;
    self.tamanhoTotalArquivo = response.expectedContentLength;
    self.lblNome.text = response.suggestedFilename;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    self.lblStatus.text = @"Baixando...";
    [self.dadosRecebidos appendData:data];
    self.totalRecebidoAteAgora += (float)data.length;
    self.barProgress.progress = self.totalRecebidoAteAgora/self.tamanhoTotalArquivo;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.lblStatus.text = error.description;
    self.lblVelocidade.text = @"";
    self.lblNome.text = @"";
    
    [self.timerParaVelocidade invalidate];
    
    self.tamanhoTotalArquivo = 0;
    self.totalRecebidoAntes = 0;
    self.totalRecebidoAteAgora = 0;
    self.downloadJaComecou = NO;
    [VariaveisGlobais shared].estaBaixando = NO;
    
    [self.btDownload setTitle:@"Inicar Dowload" forState:UIControlStateNormal];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    self.lblStatus.text = @"Download Concluído!";
    self.lblVelocidade.text = @"";
    [self.timerParaVelocidade invalidate];
    
    self.tamanhoTotalArquivo = 0;
    self.totalRecebidoAntes = 0;
    self.totalRecebidoAteAgora = 0;
    self.downloadJaComecou = NO;
    [VariaveisGlobais shared].estaBaixando = NO;
    
    self.imgDownloaded.image = [UIImage imageWithData:self.dadosRecebidos];
    [self.dadosRecebidos writeToFile:[NSHomeDirectory() stringByAppendingString:@"/Documents/foto.jpg"] atomically:YES];
    
    [self.btDownload setTitle:@"Refazer Dowload" forState:UIControlStateNormal];
    
    //Ao acabar o download, verifica se o app está em background para lançar uma notificação local e matar a tarefa que está em backgroud
    UIApplication *app = [UIApplication sharedApplication];
    if(app.applicationState == UIApplicationStateBackground){
        UILocalNotification *ln = [[UILocalNotification alloc] init];
        ln.alertBody = @"Download concluído com sucesso!";
        ln.soundName = UILocalNotificationDefaultSoundName;
        //ln.soundName = @"nomeAudio.mp3";
        
        [app presentLocalNotificationNow:ln];
        
        //Já que o download acabou e não tem mais nada para executar, pede para o iOS matar a tarefa
        [app endBackgroundTask:[VariaveisGlobais shared].identificadorTarefa];
    }
    
}

-(NSString*)ajustarUnidade:(float)tamanho{
    if(tamanho < 1024) {
        return [NSString stringWithFormat:@"%.2f Bytes", tamanho];
    }
    
    tamanho = tamanho/1024;
    if(tamanho < 1024){
        return [NSString stringWithFormat:@"%.2f KBytes", tamanho];
    }
    
    tamanho = tamanho/1024;
    if(tamanho < 1024){
        return [NSString stringWithFormat:@"%.2f MBytes", tamanho];
    }
    
    tamanho = tamanho/1024;
    return [NSString stringWithFormat:@"%.2f GBytes", tamanho];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
