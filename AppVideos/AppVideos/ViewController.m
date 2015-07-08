//
//  ViewController.m
//  AppVideos
//
//  Created by Aluno on 8/27/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;

@property (weak, nonatomic) IBOutlet UIView *areaVideo;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicador;

- (IBAction)executarVideoLocal:(id)sender;
- (IBAction)executarVideoRemoto:(id)sender;
- (IBAction)abrirCamera:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Cadastra ViewController para ouvir notificações do player
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(estadoDoPlayerMudou:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"GolSantos" object:@"informacaoQualquer"];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(estadoDoPlayerMudou:) name:@"GolSantos" object:nil];
}

- (void) estadoDoPlayerMudou : (NSNotification*) notificacao{
    
    //id objetoQualquer = notificacao.object;
    
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            self.indicador.hidden = YES;
            break;
        case MPMoviePlaybackStateInterrupted:
            self.indicador.hidden = NO;
            break;
        case MPMoviePlaybackStateStopped:
            self.indicador.hidden = YES;
            break;
        default:
            break;
    }
}

- (void)criarNovoPlayerComURL:(NSURL *)urlVideo {
    //Aloca o MPMoviePlayerController
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:urlVideo];
    
    //Define área do vídeo na tela
    self.moviePlayer.view.frame = self.areaVideo.bounds;
    
    //Adiciona view do vídeo na área determinada
    [self.areaVideo addSubview:self.moviePlayer.view];
    
    //Play do vídeo
    [self.moviePlayer play];
}

- (IBAction)executarVideoLocal:(id)sender {
    //Localiza arquivo de midia local
    NSString *pathVideo = [[NSBundle mainBundle] pathForResource:@"meuFilme" ofType:@"m4v"];
    NSURL *urlVideo = [NSURL fileURLWithPath:pathVideo];
    
    [self criarNovoPlayerComURL:urlVideo];
}

- (IBAction)executarVideoRemoto:(id)sender {
    self.indicador.hidden = NO;
    //Localiza arquivo de midia externa
    NSURL *urlVideo = [NSURL URLWithString:@"http://tinyurl.com/4zwzmf7"];
    [self criarNovoPlayerComURL:urlVideo];
}

- (IBAction)abrirCamera:(id)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *telaCamera = [UIImagePickerController new];
        telaCamera.delegate = self;
        telaCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
        telaCamera.mediaTypes = @[@"public.movie", @"public.image"];
        [self presentViewController:telaCamera animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    if([info[UIImagePickerControllerMediaType] isEqualToString:@"public.image"]){
        //Salvar foto no rolo de câmera
        UIImageWriteToSavedPhotosAlbum(info[UIImagePickerControllerOriginalImage], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    } else {
        NSURL *urlVideo = info[UIImagePickerControllerMediaURL];
        UISaveVideoAtPathToSavedPhotosAlbum(urlVideo.path, nil, nil, nil);
        
        [self criarNovoPlayerComURL:info[UIImagePickerControllerMediaURL]];
    }
}

- (void) image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo {
    if(!error){
        [[[UIAlertView alloc] initWithTitle:nil message:@"Foto salva com sucesso!" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles:nil] show];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
