//
//  TecladoViewController.m
//  AppTecladoCustom
//
//  Created by Aluno on 9/8/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "TecladoViewController.h"

@interface TecladoViewController ()

- (IBAction)teclaPressionada:(id)sender;

@end

@implementation TecladoViewController

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
}

- (IBAction)teclaPressionada:(id)sender {
    UIButton *btn = sender;
    NSString *textoCapturado = [btn titleForState:UIControlStateNormal];
    
    if([self.target isKindOfClass:[UITextField class]]){
        UITextField *campo = self.target;
        campo.text = [campo.text stringByAppendingString:textoCapturado];
    } else if([self.target isKindOfClass:[UITextView class]]){
        UITextView *campo = self.target;
        campo.text = [campo.text stringByAppendingString:textoCapturado];
    }
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
