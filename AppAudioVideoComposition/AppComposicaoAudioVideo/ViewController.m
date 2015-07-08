//
//  ViewController.m
//  AppComposicaoAudioVideo
//
//  Created by Aluno on 8/29/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *pathComposition;
@property (nonatomic, strong) AVAssetExportSession *exportador;

- (IBAction)montarComposicaoPressionado:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.pathComposition = [NSHomeDirectory() stringByAppendingString:@"/Documents/composicao.mov"];
}

- (IBAction)montarComposicaoPressionado:(id)sender {
    //Custo alto de processamento, não podemos fazer na main thread
    //Disparar outra thread
    //dispatch_async(*,*);
    //Dispara um selector em uma thread nova
    [NSThread detachNewThreadSelector:@selector(montarComposicaoAssincrono) toTarget:self withObject:nil];
}

- (void)montarComposicaoAssincrono {
    //Define assets que irão montar a composição
    NSString *pathAudio = [[NSBundle mainBundle] pathForResource:@"minhaMusica" ofType:@"m4a"];
    NSString *pathVideo = [[NSBundle mainBundle] pathForResource:@"meuFilme" ofType:@"m4v"];
    
    AVURLAsset *recursoAudio = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:pathAudio] options:nil];
    AVURLAsset *recursoVideo = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:pathVideo] options:nil];
    
    //Inicializa a composição
    AVMutableComposition *composicao = [AVMutableComposition composition];
    
    //Define as trilhas
    AVMutableCompositionTrack *trilhaAudio = [composicao addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    AVMutableCompositionTrack *trilhaVideo = [composicao addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    
    //Definições
    CMTime tempoInicial = CMTimeMake(1, 1);
    
    //Adiciona assets as trilhas
    //---------------AUDIO---------------
    AVAssetTrack *musica = [[recursoAudio tracksWithMediaType:AVMediaTypeVideo] firstObject];
    
    //Definições
    CMTime duracaoAudio = recursoAudio.duration;
    CMTimeRange rangeAudio = CMTimeRangeMake(tempoInicial, duracaoAudio);
    
    [trilhaAudio insertTimeRange:rangeAudio ofTrack:musica atTime:kCMTimeZero error:nil];
    
    //---------------VIDEO---------------
    AVAssetTrack *video = [[recursoVideo tracksWithMediaType:AVMediaTypeVideo] firstObject];
    
    //Definições
    CMTime duracaoVideo = recursoVideo.duration;
    CMTimeRange rangeVideo = CMTimeRangeMake(tempoInicial, duracaoVideo);
    
    [trilhaVideo insertTimeRange:rangeVideo ofTrack:video atTime:kCMTimeZero error:nil];
    
    //---------------EXPORT---------------
    //Verifica se o arquivo já existe
    if([[NSFileManager defaultManager] fileExistsAtPath:self.pathComposition]){
        [[NSFileManager defaultManager] removeItemAtPath:self.pathComposition error:nil];
    }
    //alloc - presets
    self.exportador = [[AVAssetExportSession alloc] initWithAsset:composicao presetName:AVAssetExportPresetPassthrough];
    //Local
    self.exportador.outputURL = [NSURL fileURLWithPath:self.pathComposition];
    //Formato
    self.exportador.outputFileType = AVFileTypeQuickTimeMovie;
    
    //Inicia export
    [self.exportador exportAsynchronouslyWithCompletionHandler:^{
        //Bloco executado após o processo terminar
        [[[UIAlertView alloc] initWithTitle:nil message:@"Composição pronta para executar!" delegate:self cancelButtonTitle:@"Fechar" otherButtonTitles: @"Executar", nil] show];
    }];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1){
        MPMoviePlayerViewController *playerVideo = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:self.pathComposition]];
        [self presentViewController:playerVideo animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
