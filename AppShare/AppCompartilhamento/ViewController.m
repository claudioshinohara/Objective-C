//
//  ViewController.m
//  AppCompartilhamento
//
//  Created by Aluno on 8/20/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *foto;
@property (weak, nonatomic) IBOutlet UILabel *legenda;

- (IBAction)compartilharFacebook:(id)sender;
- (IBAction)compartilharTwitter:(id)sender;
- (IBAction)compartilharMail:(id)sender;
- (IBAction)compartilharSMS:(id)sender;
- (IBAction)abrirMenuCompartilhar:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

#pragma mark Compartilhar Facebook
- (IBAction)compartilharFacebook:(id)sender {
    SLComposeViewController *compositorFacebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [compositorFacebook setInitialText:self.legenda.text];
    [compositorFacebook addImage:self.foto.image];
    [self presentViewController:compositorFacebook animated:YES completion:nil];
}

#pragma mark Compartilhar Twitter
- (IBAction)compartilharTwitter:(id)sender {
    SLComposeViewController *compositorFacebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [compositorFacebook setInitialText:self.legenda.text];
    [compositorFacebook addImage:self.foto.image];
    [self presentViewController:compositorFacebook animated:YES completion:nil];
}

#pragma mark Compartilhar Email
- (IBAction)compartilharMail:(id)sender {
    if([MFMailComposeViewController canSendMail]){
        //Alocando uma nova controladora
        MFMailComposeViewController *compositorEmail = [[MFMailComposeViewController alloc] init];
        compositorEmail.mailComposeDelegate = self;
        
        //Apresentando modal
        [compositorEmail setToRecipients:@[@"claudio@shinohara.ad"]];
        [compositorEmail setSubject:@"AppCompartilhamento"];
        [compositorEmail setMessageBody:self.legenda.text isHTML:NO];
        
        [compositorEmail addAttachmentData:UIImageJPEGRepresentation(self.foto.image, 1.0) mimeType:@"image/jpeg" fileName:@"foto.jpg"];
        
        [self presentViewController:compositorEmail animated:YES completion:nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Ops!" message:@"Seu device não está configurado para mandar e-mails!" delegate:nil cancelButtonTitle:@"Voltar" otherButtonTitles: nil] show];
    }
}

//Cancel ou Send E-Mail
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    
    //Retira o modal
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSString *mensagem;
    switch (result) {
        case MFMailComposeResultCancelled:
            mensagem = @"Email cancelado!";
            break;
        case MFMailComposeResultFailed:
            mensagem = @"Email não enviado!";
            break;
        case MFMailComposeResultSaved:
            mensagem = @"Email salvo como rascunho!";
            break;
        case MFMailComposeResultSent:
            mensagem = @"Email enviado com sucesso!";
            break;
            
        default:
            break;
    }
    
    [[[UIAlertView alloc] initWithTitle:@"E-MAIL" message:mensagem delegate:nil cancelButtonTitle:@"Voltar" otherButtonTitles: nil] show];
}

#pragma mark Compartilhar SMS
- (IBAction)compartilharSMS:(id)sender {
    if([MFMessageComposeViewController canSendText]){
        MFMessageComposeViewController *compositorSMS = [[MFMessageComposeViewController alloc] init];
        compositorSMS.messageComposeDelegate = self;
        compositorSMS.recipients = @[@"11984370026"];
        compositorSMS.body = [NSString stringWithFormat:@"Vi o livro %@ e curti.", self.legenda.text];
        [compositorSMS addAttachmentData:UIImageJPEGRepresentation(self.foto.image, 1.0) typeIdentifier:@"image/jpeg" filename:@"foto.jpg"];
        [self presentViewController:compositorSMS animated:YES completion:nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Ops!" message:@"Seu device não está configurado para mandar SMS!" delegate:nil cancelButtonTitle:@"Voltar" otherButtonTitles: nil] show];
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    //Retira o modal
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSString *mensagem;
    switch (result) {
        case MessageComposeResultCancelled:
            mensagem = @"SMS cancelado!";
            break;
        case MessageComposeResultFailed:
            mensagem = @"SMS não enviado!";
            break;
        case MessageComposeResultSent:
            mensagem = @"SMS salvo como rascunho!";
            break;
            
        default:
            break;
    }
    
    [[[UIAlertView alloc] initWithTitle:@"SMS" message:mensagem delegate:nil cancelButtonTitle:@"Voltar" otherButtonTitles: nil] show];

}

#pragma mark Abrir Menu Compartilhar
- (IBAction)abrirMenuCompartilhar:(id)sender {
    NSArray *conteudo = @[self.foto.image, self.legenda.text];
    UIActivityViewController *menuCompartilhar = [[UIActivityViewController alloc] initWithActivityItems:conteudo applicationActivities:nil];
    [menuCompartilhar setValue:@"Your email Subject" forKey:@"subject"];
    [self presentViewController:menuCompartilhar animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
