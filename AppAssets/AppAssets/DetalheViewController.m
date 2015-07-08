//
//  DetalheViewController.m
//  AppAssets
//
//  Created by Aluno on 8/28/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "DetalheViewController.h"

@interface DetalheViewController ()

@end

@implementation DetalheViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *imagem = [UIImage imageWithCGImage:self.assetSelecionado.defaultRepresentation.fullScreenImage];
    UIImageView *foto = [[UIImageView alloc] initWithImage:imagem];
    foto.frame = self.view.bounds;
    foto.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:foto];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
