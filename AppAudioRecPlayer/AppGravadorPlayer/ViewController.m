//
//  ViewController.m
//  AppGravadorPlayer
//
//  Created by Aluno on 8/25/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *botaoGravar;
@property (weak, nonatomic) IBOutlet UIButton *botaoReproduzir;
@property (weak, nonatomic) IBOutlet UILabel *labelStatus;
@property (nonatomic, assign) NSTimer *timer;
//Referência para os recursos de áudio do iOS
@property (nonatomic, strong) AVAudioSession *sessaoAudio;
@property (nonatomic, strong) AVAudioRecorder *gravador;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) NSString *pathAudio;

- (IBAction)gravarPressionado:(id)sender;
- (IBAction)reproduzirPressionado:(id)sender;



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Setando uma referência à sessão de audio do iOS
    self.sessaoAudio = [AVAudioSession sharedInstance];
    
    NSError *erroAudio;
    
    //Ativando a sessão
    [self.sessaoAudio setActive:YES error:&erroAudio];
    
    if(erroAudio){
        NSLog(@"Erro ao ativar sessão: %@", erroAudio);
    }
    
    //Define o local onde será salva a gravação - Documents
    self.pathAudio = [NSHomeDirectory() stringByAppendingString:@"/Documents/meuAudio.wav"];
}

- (IBAction)gravarPressionado:(id)sender {
    //Muda a categoria para utilizar recusros de gravação
    [self.sessaoAudio setCategory:AVAudioSessionCategoryRecord error:nil];
    
    if (self.gravador){
        [self.gravador stop];
        self.gravador = nil;
        [self.botaoGravar setTitle:@"Gravar" forState:UIControlStateNormal];
        [self.botaoReproduzir setEnabled:YES];
        self.labelStatus.text = @"Parado";
    } else {
        //Objeto responsável em gravar um áudio
        NSURL *urlGravacao = [NSURL fileURLWithPath:self.pathAudio];
        self.gravador = [[AVAudioRecorder alloc] initWithURL:urlGravacao settings:nil error:nil];
        [self.gravador record];
        [self.botaoGravar setTitle:@"Parar" forState:UIControlStateNormal];
        [self.botaoReproduzir setEnabled:NO];
        self.labelStatus.text = @"Gravando...";
    }
    
}

- (IBAction)reproduzirPressionado:(id)sender {
    //Muda a categoria para utilizar recusros de reprodução
    [self.sessaoAudio setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    if(self.player){
        [self.timer invalidate];
        [self.player stop];
        self.player = nil;
        [self.botaoReproduzir setTitle:@"Reproduzir" forState:UIControlStateNormal];
        [self.botaoGravar setEnabled:YES];
        self.labelStatus.text = @"Parado";
    } else {
        NSURL *urlGravacao = [NSURL fileURLWithPath:self.pathAudio];
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:urlGravacao error:nil];
        self.player.delegate = self;
        [self.player play];
        [self.botaoReproduzir setTitle:@"Parar" forState:UIControlStateNormal];
        [self.botaoGravar setEnabled:NO];
        self.labelStatus.text = @"Reproduzindo...";
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(metodoTimer) userInfo:nil repeats:YES];
    }
}

- (void) metodoTimer {
    NSLog(@"%f", self.player.currentTime);
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self reproduzirPressionado:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
