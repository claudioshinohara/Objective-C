//
//  ViewController.m
//  AppRotacaoAutoLayout
//
//  Created by Aluno on 9/8/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)botaoPortrait:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

//Método para determinar quais rotações serão permitidas
-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

//Método para captar a rotação do aparelho
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    if(UIInterfaceOrientationIsLandscape(fromInterfaceOrientation)){
        //Estamos em Landscape
    } else {
        //Estamos em Portrait
    }
    
    switch (fromInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            //Viemos do Portrait
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            //Viemos do Portrait UpsideDown
            break;
        case UIInterfaceOrientationLandscapeLeft:
            //Viemos do Landscape Left
            break;
        case UIInterfaceOrientationLandscapeRight:
            //Viemos do Landscape Right
            break;
            
        default:
            break;
    }
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if(UIInterfaceOrientationIsPortrait(toInterfaceOrientation)){
        [UIView animateWithDuration:duration animations:^{
            self.view.backgroundColor = [UIColor whiteColor];
        }];
    } else {
        [UIView animateWithDuration:duration animations:^{
            self.view.backgroundColor = [UIColor orangeColor];
        }];
    }
}

- (IBAction)botaoPortrait:(id)sender {
    NSLog(@"Botão pressionado no portrait");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
