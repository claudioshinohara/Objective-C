//
//  ViewController.m
//  AppSelecaoMusicas
//
//  Created by Aluno on 8/29/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) MPMediaPickerController *selecaoMusicas;
@property (nonatomic, strong) MPMusicPlayerController *player;

@property (weak, nonatomic) IBOutlet UILabel *artista;
@property (weak, nonatomic) IBOutlet UILabel *nomeMusica;
@property (weak, nonatomic) IBOutlet UILabel *nomeAlbum;
@property (weak, nonatomic) IBOutlet UIImageView *capa;


- (IBAction)selecionarMusicasPressionado:(id)sender;
- (IBAction)voltarPressionado:(id)sender;
- (IBAction)avancarPressionado:(id)sender;
- (IBAction)stopPressionado:(id)sender;
- (IBAction)playPressionado:(id)sender;
- (IBAction)pausePressionado:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //MPMediaItem - Áudio
    //MPMediaItemCollection - Playlist
    
    //Recuperar player do iOS
    self.player = [MPMusicPlayerController iPodMusicPlayer];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(devePararPlayer) name:@"AppVaiEntrarEmEspera" object:nil];
    
    [self.player beginGeneratingPlaybackNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(atualizarInterface) name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AppVaiEntrarEmEspera" object:nil];
}

-(void) devePararPlayer {
    [self.player stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selecionarMusicasPressionado:(id)sender {
    self.selecaoMusicas = [MPMediaPickerController new];
    self.selecaoMusicas.delegate = self;
    self.selecaoMusicas.allowsPickingMultipleItems = YES;
    
    [self presentViewController:self.selecaoMusicas animated:YES completion:nil];
}

- (void)mediaPicker: (MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
    [self dismissViewControllerAnimated:YES completion:nil];
    //Passa seleção do usuário para o player
    [self.player setQueueWithItemCollection:mediaItemCollection];
    
    [self.player play];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)voltarPressionado:(id)sender {
    [self.player skipToPreviousItem];
}

- (IBAction)avancarPressionado:(id)sender {
    [self.player skipToNextItem];
}

- (IBAction)stopPressionado:(id)sender {
    [self.player stop];
}

- (IBAction)playPressionado:(id)sender {
    [self.player play];
}

- (IBAction)pausePressionado:(id)sender {
    [self.player pause];
}

- (void) atualizarInterface {
    MPMediaItem *musicaAtual = self.player.nowPlayingItem;
    self.artista.text = [musicaAtual valueForProperty:MPMediaItemPropertyArtist];
    self.nomeMusica.text = [musicaAtual valueForProperty:MPMediaItemPropertyTitle];
    self.nomeAlbum.text = [musicaAtual valueForProperty:MPMediaItemPropertyAlbumTitle];
    
    MPMediaItemArtwork *arteCapa = [musicaAtual valueForProperty:MPMediaItemPropertyArtwork];
    self.capa.image = [arteCapa imageWithSize:self.capa.frame.size];
}

@end
