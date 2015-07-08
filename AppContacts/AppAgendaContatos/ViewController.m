//
//  ViewController.m
//  AppAgendaContatos
//
//  Created by Aluno on 8/22/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)inserirContato:(id)sender;
- (IBAction)selecionarContato:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)inserirContato:(id)sender {
    ABNewPersonViewController *insercaoContato = [[ABNewPersonViewController alloc] init];
    insercaoContato.newPersonViewDelegate = self;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:insercaoContato];
    
    [self presentViewController:navController animated:YES completion:nil];
    
}

-(void)newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if(person){
        [[[UIAlertView alloc] initWithTitle:nil message:@"Contato Salvo Com Sucesso!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    } else {
        //Cancel
    }
}

- (IBAction)selecionarContato:(id)sender {
    ABPeoplePickerNavigationController *selecaoContato = [[ABPeoplePickerNavigationController alloc] init];
    selecaoContato.peoplePickerDelegate = self;
    [self presentViewController:selecaoContato animated:YES completion:nil];
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person{
    NSString *nome = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    
    NSLog(@"Selecionou: %@", nome);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    return NO;
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    return YES;
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
