//
//  ViewController.m
//  AppSelecaoImagens
//
//  Created by Aluno on 8/25/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//ViewController padrão para selecionar uma foto da câmera ou do álbum
@property (nonatomic, strong) UIImagePickerController *telaSelecao;

@property (weak, nonatomic) IBOutlet UIImageView *fotoOriginal;
@property (weak, nonatomic) IBOutlet UIImageView *fotoRecortada;

- (IBAction)selecionarImagemPressionado:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.telaSelecao = [UIImagePickerController new];
    self.telaSelecao.delegate = self;
    self.telaSelecao.allowsEditing = YES;
}

- (IBAction)selecionarImagemPressionado:(id)sender {
    //Oferece opções de onde pegar a foto - Action Sheet -> Menu inferior
    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Qual a origem da foto?" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Álbum", @"Câmera", nil];
    [menu showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self abrirAlbum];
            break;
        case 1:
            [self abrirCamera];
            break;
        case 2:
            //
            break;
            
        default:
            break;
    }
}

- (void) abrirAlbum {
    //Define de onde selecionará a foto
    self.telaSelecao.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    //Transição - Modal
    [self presentViewController:self.telaSelecao animated:YES completion:nil];
}

- (void) abrirCamera {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        //Define de onde selecionará a foto
        self.telaSelecao.sourceType = UIImagePickerControllerSourceTypeCamera;
        //Transição - Modal
        [self presentViewController:self.telaSelecao animated:YES completion:nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:nil message:@"Camera indisponível" delegate:nil cancelButtonTitle:@"Voltar" otherButtonTitles:nil] show];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    //info - Dicionário que vai entregar todos os recursos encontrados no imagePicker
    self.fotoOriginal.image = info[UIImagePickerControllerOriginalImage];
    self.fotoRecortada.image = info[UIImagePickerControllerEditedImage];
    
    //picker.sourceTye -> Qual o tipo da imagem selecionada (camera, album)
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
