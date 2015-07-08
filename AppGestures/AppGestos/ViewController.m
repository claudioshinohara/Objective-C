//
//  ViewController.m
//  AppGestos
//
//  Created by Aluno on 8/26/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImagePickerController *selecaoFotos;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.selecaoFotos = [UIImagePickerController new];
    self.selecaoFotos.delegate = self;
    self.selecaoFotos.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    //Alocando qual o tipo de gesto que quero capturar
    UILongPressGestureRecognizer *gestoAbrirFotos = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(abrirAlbumFotos:)];
    //Definindo segundos de duração do gesto
    gestoAbrirFotos.minimumPressDuration = 1.0;
    //Adicionando o controle na view
    [self.view addGestureRecognizer:gestoAbrirFotos];
    
}

- (void) abrirAlbumFotos:(UILongPressGestureRecognizer*) gesto {
    if(gesto.state == UIGestureRecognizerStateBegan){
        [self presentViewController:self.selecaoFotos animated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    //Monta imagame view e adiciona na tela
    MinhaFoto *novaFoto = [[MinhaFoto alloc] initWithImage:info[UIImagePickerControllerOriginalImage]];
    
    novaFoto.escala = 1.0;
    novaFoto.rotacao = 0.0;
    
    //Atributo para ativar interação - UIImageView não tem como padrão interação
    novaFoto.userInteractionEnabled = YES;
    novaFoto.frame = CGRectMake(20, 20, 200, 100);
    
    //Controle de como a imagem será apresentada
    novaFoto.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:novaFoto];
    [self adicionarGestosNaFoto:novaFoto];
}

- (void) adicionarGestosNaFoto:(UIImageView*)foto {
    //Double Tap
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapReconhecido:)];
    doubleTap.numberOfTapsRequired = 2;
    [foto addGestureRecognizer:doubleTap];
    
    //Triple Tap
    UITapGestureRecognizer *tripleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tripleTapReconhecido:)];
    tripleTap.numberOfTapsRequired = 3;
    [foto addGestureRecognizer:tripleTap];
    
    //Define uma prioridade entre gestos
    [doubleTap requireGestureRecognizerToFail:tripleTap];
    
    //Zoom / Pinça
    UIPinchGestureRecognizer *zoomGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomGestureReconhecido:)];
    zoomGesture.delegate = self;
    [foto addGestureRecognizer:zoomGesture];
    
    //Rotação
    UIRotationGestureRecognizer *rotacao = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationReconhecido:)];
    rotacao.delegate = self;
    [foto addGestureRecognizer:rotacao];
    
    //Panorâmico
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panReconhecido:)];
    pan.delegate = self;
    [foto addGestureRecognizer:pan];
}

- (void) panReconhecido: (UIPanGestureRecognizer*) gesto {
    //Cast para utilizar atributos específicos da view controlada pelo gesto
    MinhaFoto *foto = (MinhaFoto*) gesto.view;
    
    CGPoint deslocamento = [gesto translationInView:foto];
    foto.center = CGPointMake(foto.center.x + deslocamento.x, foto.center.y + deslocamento.y);
    
    [gesto setTranslation:CGPointZero inView:foto];
}

- (void) rotationReconhecido: (UIRotationGestureRecognizer*) gesto {
    //Cast para utilizar atributos específicos da view controlada pelo gesto
    MinhaFoto *foto = (MinhaFoto*) gesto.view;
    
    if(gesto.state == UIGestureRecognizerStateBegan){
        gesto.rotation = foto.rotacao;
    } else {
        foto.rotacao = gesto.rotation;
        [self transformarImagem:foto];
    }
    
}

- (void) transformarImagem: (MinhaFoto*) foto {
    CGAffineTransform rotacao = CGAffineTransformMakeRotation(foto.rotacao);
    foto.transform = CGAffineTransformScale(rotacao, foto.escala, foto.escala);
}

- (void) zoomGestureReconhecido: (UIPinchGestureRecognizer*) gesto {
    //Cast para utilizar atributos específicos da view controlada pelo gesto
    MinhaFoto *foto = (MinhaFoto*) gesto.view;
    
    if(gesto.state == UIGestureRecognizerStateBegan){
        gesto.scale = foto.escala;
    } else {
        foto.escala = gesto.scale;
        [self transformarImagem:foto];
    }
    
}

- (void) tripleTapReconhecido: (UITapGestureRecognizer*) gesto{
    //Foto para um ponto randomico
    CGFloat randX = arc4random() % (int)self.view.frame.size.width;
    CGFloat randY = arc4random() % (int)self.view.frame.size.height;
    //Cast para utilizar atributos específicos da view controlada pelo gesto
    UIImageView *foto = (UIImageView*) gesto.view;
    [UIView animateWithDuration:0.5 animations:^{
        foto.center = CGPointMake(randX, randY);
    }];
}

- (void) doubleTapReconhecido: (UITapGestureRecognizer*) gesto{
    //Foto para o meio da tela
    //Cast para utilizar atributos específicos da view controlada pelo gesto
    UIImageView *foto = (UIImageView*) gesto.view;
    [UIView animateWithDuration:0.5 animations:^{
        foto.center = self.view.center;
    }];
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if(motion == UIEventSubtypeMotionShake){
        for (UIView *subview in self.view.subviews) {
            [subview removeFromSuperview];
        }
    }
}

//Reconhecer gestos simultâneos da classe UIGestureRecognizer
- (BOOL)gestureRecognizer: (UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
