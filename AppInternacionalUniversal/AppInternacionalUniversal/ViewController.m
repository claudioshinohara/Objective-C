//
//  ViewController.m
//  AppInternacionalUniversal
//
//  Created by Aluno on 9/4/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *minhaView;
@property (weak, nonatomic) IBOutlet UIButton *btnAnimar;
- (IBAction)animar:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.btnAnimar setTitle:NSLocalizedString(@"textoBotaoAnimar", nil) forState:UIControlStateNormal];
}

- (IBAction)animar:(id)sender {
    int duracao;
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone){
        duracao = 1;
    } else {
        duracao = 3;
    }
    
    //if([UIDevice currentDevice].model isEqualToString:@"iPod")
    
    [UIView animateWithDuration:duracao animations:^{
        
        self.minhaView.center = CGPointMake(self.view.frame.size.width - self.minhaView.frame.size.width/2, self.view.frame.size.height - self.minhaView.frame.size.height/2);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
