//
//  ViewController.m
//  AppAssets
//
//  Created by Aluno on 8/28/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *grid;

//Referência a todas as midias salvas no dispositivo
@property (nonatomic, strong) ALAssetsLibrary *bibliotecaMidia;
@property (nonatomic, strong) NSMutableArray *fotos;

@end

@implementation ViewController

static NSString *itemIdentifier = @"meuItem";

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.fotos = [NSMutableArray new];
    
    //Recupera uma referência ao arquivo de mídia
    self.bibliotecaMidia = [ALAssetsLibrary new];
    //Álbum = group
    //Arquivo = assets
    
    //Bloco para tratar cada grupo encontrado
    void (^enumerarGrupos)(ALAssetsGroup*, BOOL*) = ^(ALAssetsGroup *album, BOOL *stop){
        //Enumera cada asset
        [album enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if([result valueForProperty:ALAssetPropertyType] == ALAssetTypePhoto){
                [self.fotos addObject:result];
                [self.grid reloadData];
            }
        }];
    };
    
    [self.bibliotecaMidia enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:enumerarGrupos failureBlock:^(NSError *error) {
        //FALHOU NA ENUMERAÇÃO DOS GRUPOS
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //Precisamos registrar qual a classe que define o item do CollectionViewCell
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:itemIdentifier];
    
    //Faz uma tentativa de reciclagem
    UICollectionViewCell *novoItem = [collectionView dequeueReusableCellWithReuseIdentifier:itemIdentifier forIndexPath:indexPath];
    
    //Ajusta conteúdo - ALAsset -> UIImage -> UIImageView
    ALAsset *asset = self.fotos[indexPath.row];
    UIImage *imagem = [UIImage imageWithCGImage:asset.thumbnail];
    UIImageView *foto = [[UIImageView alloc] initWithImage:imagem];
    foto.frame = novoItem.contentView.bounds;
    
    [novoItem.contentView addSubview:foto];
    
    return novoItem;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"exibirDetalhe" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetalheViewController *telaDestino = segue.destinationViewController;
    NSIndexPath *indexSelecionado = self.grid.indexPathsForSelectedItems.firstObject;
    telaDestino.assetSelecionado = self.fotos[indexSelecionado.row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
