//
//  ViewController.m
//  AppAccelerometer
//
//  Created by Claudio Shinohara on 02/07/15.
//  Copyright (c) 2015 Shinohara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imagem;
@property (nonatomic, assign) CGFloat velocidadeX;
@property (nonatomic, assign) CGFloat velocidadeY;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Aloca o gerenciador de movimento
    self.gerenciadorMovimento = [[CMMotionManager alloc] init];
    
    //Criando uma nova fila para processar as leituras do acelerômetro
    NSOperationQueue *fila = [[NSOperationQueue alloc] init];
    
    //Começa a receber as leituras do acelerômetro
    [self.gerenciadorMovimento startDeviceMotionUpdatesToQueue:fila withHandler:^(CMDeviceMotion *motion, NSError *error) {
        //Bloco processado para cada leitura (CMDeviceMotion) do acelerômetro
        if(error){
            NSLog(@"Erro acelerômetro %@", error.description);
        }
        
        // motion.gravity -> Varia entre 0 e 1 nos eixos x, y e z;
        //NSLog(@"X: %.2f - Y: %.2f - Z: %.2f", motion.gravity.x, motion.gravity.y, motion.gravity.z);
        self.velocidadeX += motion.gravity.x * 0.25 + motion.userAcceleration.x;
        self.velocidadeY -= motion.gravity.y * 0.25 + motion.userAcceleration.y;
        
        CGFloat novoX = self.imagem.center.x + self.velocidadeX;
        CGFloat novoY = self.imagem.center.y + self.velocidadeY;
        
        //Testar se novos pontos extrapolam a tela
        CGFloat wTela = self.view.frame.size.width;
        CGFloat hTela = self.view.frame.size.height;
        CGFloat wImagem = self.imagem.frame.size.width;
        CGFloat hImagem = self.imagem.frame.size.height;
        if(novoX > wTela-wImagem/2){
            novoX = wTela-wImagem/2;
            self.velocidadeX = -self.velocidadeX * 0.7;
        }
        if(novoX < wImagem/2){
            novoX = wImagem/2;
            self.velocidadeX = -self.velocidadeX * 0.7;
        }
        
        if(novoY > hTela-hImagem/2){
            novoY = hTela-hImagem/2;
            self.velocidadeY = -self.velocidadeY * 0.7;
        }
        if(novoY < hImagem/2){
            novoY = hImagem/2;
            self.velocidadeY = -self.velocidadeY * 0.7;
        }
        
        //Dispara a alteração da posição na imagem na main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imagem.center = CGPointMake(novoX, novoY);
        });
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
