//
//  ViewControllerSalaChat.m
//  AppChat
//
//  Created by Aluno on 9/11/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewControllerSalaChat.h"

@interface ViewControllerSalaChat ()

@property (weak, nonatomic) IBOutlet UILabel *lblApelido;
@property (weak, nonatomic) IBOutlet UITextField *txtMensagem;
@property (weak, nonatomic) IBOutlet UITableView *tabela;

- (IBAction)sair:(id)sender;
- (IBAction)enviar:(id)sender;

@property (nonatomic, strong) NSMutableArray *mensagens;

//Objeto que vai se comunicar com a rede na troca de dados
@property (nonatomic, strong) MCSession *gerenciadorSessao;
//Objeto onde iremos guardar nosso usuario que está na rede
@property (nonatomic, strong) MCPeerID *meuPeerID;
//Objeto que possibilita encontro de peers que estiverem no mesmo serviço
@property (nonatomic, strong) MCNearbyServiceAdvertiser *divulgaPeers;
@property (nonatomic, strong) MCNearbyServiceBrowser *reconhecePeers;


@end

@implementation ViewControllerSalaChat

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
    
    self.lblApelido.text = self.strApelido;
    
    self.meuPeerID = [[MCPeerID alloc] initWithDisplayName:self.strApelido];
    
    self.gerenciadorSessao = [[MCSession alloc] initWithPeer:self.meuPeerID];
    self.gerenciadorSessao.delegate = self;
    
    self.divulgaPeers = [[MCNearbyServiceAdvertiser alloc] initWithPeer:self.meuPeerID discoveryInfo:nil serviceType:@"iaichat2"];
    self.divulgaPeers.delegate = self;
    
    self.reconhecePeers = [[MCNearbyServiceBrowser alloc] initWithPeer:self.meuPeerID serviceType:@"iaichat2"];
    self.reconhecePeers.delegate = self;
    
    [self.divulgaPeers startAdvertisingPeer];
    [self.reconhecePeers startBrowsingForPeers];
    
    self.mensagens = [[NSMutableArray alloc] init];
}

- (IBAction)sair:(id)sender {
    [self.divulgaPeers stopAdvertisingPeer];
    [self.reconhecePeers stopBrowsingForPeers];
    
    self.gerenciadorSessao = nil;
    self.divulgaPeers = nil;
    self.reconhecePeers = nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)enviar:(id)sender {
    //Enviar texto para rede
    NSData *dataMsg = [self.txtMensagem.text dataUsingEncoding:NSUTF8StringEncoding];
    [self.gerenciadorSessao sendData:dataMsg toPeers:self.gerenciadorSessao.connectedPeers withMode:MCSessionSendDataReliable error:nil];
    
    NSDictionary *dict = @{@"nome":self.strApelido, @"mensagem":self.txtMensagem.text};
    [self.mensagens addObject:dict];
    [self.tabela reloadData];
    
    self.txtMensagem.text = @"";
    [self.txtMensagem resignFirstResponder];
}

//Métido acionado quando recebemos algum dado da rede
-(void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    NSString *msgRecebida = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dict = @{@"nome":peerID.displayName, @"mensagem":msgRecebida};
    [self.mensagens addObject:dict];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tabela reloadData];
    });
}

//Método acionado quando o usuário muda de estado
-(void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    if(state == MCSessionStateConnected){
        NSDictionary *dict = @{@"nome":peerID.displayName, @"mensagem":@"Acabou de entrar na sala."};
        [self.mensagens addObject:dict];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tabela reloadData];
        });
    } else if(state == MCSessionStateConnecting) {
        //Conectando...
    } else if(state == MCSessionStateNotConnected) {
        //Ao sair, pedir para reconectar
        [self.reconhecePeers invitePeer:peerID toSession:self.gerenciadorSessao withContext:nil timeout:30];
    }
}

//Método acionado quando encontramos um usuário que ainda não realizamos conexão
-(void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info {
    //Pedir conexão para o usuário
    [browser invitePeer:peerID toSession:self.gerenciadorSessao withContext:nil timeout:30];
}

//Método quando usuário recebe convite
-(void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void (^)(BOOL, MCSession *))invitationHandler {
    //Recebemos um bloco pelo parâmetro para ser utilizado na hora de aceitar o pedido
    invitationHandler(YES, self.gerenciadorSessao);
}

//Método acionado quando alguém sair da sala
-(void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID {
    //Usuário saiu da rede
    NSDictionary *dict = @{@"nome":peerID.displayName, @"mensagem":@"Saiu da sala."};
    [self.mensagens addObject:dict];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tabela reloadData];
    });
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Mensagens";
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mensagens.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *celula = [tableView dequeueReusableCellWithIdentifier:@"celula"];
    celula.textLabel.text = self.mensagens[indexPath.row][@"nome"];
    celula.detailTextLabel.text = self.mensagens[indexPath.row][@"mensagem"];
    return celula;
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
