//
//  ViewController.m
//  AppPopOver
//
//  Created by Aluno on 9/2/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIPopoverController *popOverController;
@property (nonatomic, strong) ViewControllerSlider *vcs;

- (IBAction)mudarCorPressionado:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Cria UIViewController para o UIPopover
    self.vcs = [self.storyboard instantiateViewControllerWithIdentifier:@"idVCSlider"];
    self.vcs.delegate = self;
    
    //Cria uma UIPopover e inicia com a UIViewController desejada
    self.popOverController = [[UIPopoverController alloc] initWithContentViewController:self.vcs];
    self.popOverController.delegate = self;
}

- (IBAction)mudarCorPressionado:(id)sender {
    UIButton *btn = sender;
    [self.popOverController presentPopoverFromRect:btn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
    //Método chamado quando o usuário tenta fechar o UIPopoverController
    [[[UIAlertView alloc] initWithTitle:nil message:@"Tem certeza que deseja fechar?" delegate:self cancelButtonTitle:@"Sim" otherButtonTitles:@"Não", nil] show];
    return NO;
}

//Método acionado quando o usuário clica em um botão do alertView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self.popOverController dismissPopoverAnimated:YES];
            break;
        case 1:
            //Não faz nada
            break;
        default:
            break;
    }
}

//Método implementado no Protocolo Delegate da ViewControllerSlider para avisar quando mudaram o slider.
- (void)acionaramSliderEACorMudouPara:(UIColor*)novaCor {
    self.view.backgroundColor = novaCor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
