//
//  ViewController.m
//  AppChat
//
//  Created by Aluno on 9/11/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerSalaChat.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtNick;
- (IBAction)entrar:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)entrar:(id)sender {
    if(self.txtNick.text.length > 0){
        ViewControllerSalaChat *sala = [self.storyboard instantiateViewControllerWithIdentifier:@"vcSalaChat"];
        sala.strApelido = self.txtNick.text;
        [self presentViewController:sala animated:YES completion:nil];
        self.txtNick.text = @"";
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Digite um apelido." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
