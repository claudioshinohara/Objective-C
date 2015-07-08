//
//  ViewController.m
//  AppDocumentos
//
//  Created by Aluno on 8/21/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) QLPreviewController *preview;
@property (nonatomic, strong) NSMutableArray *listaURLs;

- (IBAction)abrirDocumento:(id)sender;
- (IBAction)abrirVariosDocumentos:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Criando lista com nomes dos documentos
    NSArray *extensoes = @[@"pdf", @"docx", @"key", @"numbers", @"xlsx"];
    self.listaURLs = [[NSMutableArray alloc] init];
    for (NSString *tipo in extensoes){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"exemplo" ofType:tipo];
        NSURL *urlDoc = [NSURL fileURLWithPath:path];
        [self.listaURLs addObject:urlDoc];
    }
    
    //Alocando QLPreviewController
    self.preview = [[QLPreviewController alloc] init];
    self.preview.dataSource = self;
    self.preview.delegate = self;
    
}

- (IBAction)abrirDocumento:(id)sender {
    //Localizando arquivo no projeto
    NSString *path = [[NSBundle mainBundle] pathForResource:@"exemplo" ofType:@"pdf"];
    NSURL *urlDoc = [NSURL fileURLWithPath:path];
    
    //Criando VC para o documento
    UIDocumentInteractionController *docController = [UIDocumentInteractionController interactionControllerWithURL:urlDoc];
    docController.delegate = self;
    
    //Exibindo o documento
    [docController presentPreviewAnimated:YES];
}

//VC que apresentará o documento - Método obrigatório do UIDocumentInteractionControllerDelegate
-(UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self;
}

- (IBAction)abrirVariosDocumentos:(id)sender {
    //Mostrando tela de vários arquivos
    [self presentViewController:self.preview animated:YES completion:nil];
}

//Define quantidade de docs - Método obrigatório do QLPreviewControllerDelegate
- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller {
    return self.listaURLs.count;
}

//Documento para uma dada posição - Método obrigatório do QLPreviewControllerDelegate
-(id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    return self.listaURLs[index];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
