//
//  ViewController.m
//  AppTecladoCustom
//
//  Created by Aluno on 9/8/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"
#import "TecladoViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *text;

@property (nonatomic, weak) TecladoViewController *teclado;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Captura o foco usando o delegate
    self.text.delegate = self;
    
    self.teclado = [self.storyboard instantiateViewControllerWithIdentifier:@"idTeclado"];
    self.text.inputView = self.teclado.view;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.teclado.target = textField;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
