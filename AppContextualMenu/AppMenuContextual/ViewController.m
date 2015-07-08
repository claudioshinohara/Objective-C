//
//  ViewController.m
//  AppMenuContextual
//
//  Created by Aluno on 9/2/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

-(void) mudarParaAmarelo;
-(void) mudarParaBranco;

@end

@implementation ViewController

//Por padrão, o menu só pode aparecer em objetos que ganham foco, que não era foco antes
//Devemos implementar um método que permita ser foco

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //Dar foco ao pressionar a VC
    [self becomeFirstResponder];
    
    //UIMenuController é um singleton, só é instanciado uma vez
    UIMenuController *menu = [UIMenuController sharedMenuController];
    //Localiza onde foi o toque
    UITouch *toque = [touches anyObject];
    CGPoint posToque = [toque locationInView:self.view];
    //Cria botões para o menu
    UIMenuItem *btAmarelo = [[UIMenuItem alloc] initWithTitle:@"Amarelo" action:@selector(mudarParaAmarelo)];
    UIMenuItem *btBranco = [[UIMenuItem alloc] initWithTitle:@"Branco" action:@selector(mudarParaBranco)];
    //Insere os botões no menu
    [menu setMenuItems:@[btAmarelo, btBranco]];
    //Define onde irá aparecer o menu
    [menu setTargetRect:CGRectMake(posToque.x, posToque.y, 1, 1) inView:self.view];
    //Faz o menu aparecer
    [menu setMenuVisible:YES animated:YES];
    
}

-(void) mudarParaAmarelo{
    self.view.backgroundColor = [UIColor yellowColor];
}
-(void) mudarParaBranco{
    self.view.backgroundColor = [UIColor whiteColor];
}
//Método acionado quando o VC perde o foco
-(BOOL)resignFirstResponder {
    //Como estamos sobrecarregando o método, é interessante implementar as instruções já existentes para este método - [super ]
    [super resignFirstResponder];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:nil];
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
