//
//  TableViewControllerAnotacoes.m
//  AppCloud
//
//  Created by Claudio Shinohara on 18/09/14.
//  Copyright (c) 2014 Shinohara. All rights reserved.
//

#import "TableViewControllerAnotacoes.h"

@interface TableViewControllerAnotacoes ()

@property (weak, nonatomic) IBOutlet UITextField *txtAnotacao;

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSMutableArray *arrAnotacoes;

@property (nonatomic, strong) NSURL *urlArquivo; //URL do arquivo no iCloud
@property (nonatomic, strong) NSURL *ubiq; //URL da raiz do iCloud
@property (nonatomic, strong) NSMetadataQuery *busca;

@property (nonatomic, strong) GerenciadoArquivo *gerenciador;

- (IBAction)anotar:(id)sender;

-(void) atualizar;
-(void) buscaPronta;

@end

@implementation TableViewControllerAnotacoes

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.arrAnotacoes = [[NSMutableArray alloc] init];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(atualizar) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    self.ubiq = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:nil];
    if(self.ubiq){
        NSLog(@"iCloud OK!");
        [self atualizar];
    }
}

- (IBAction)anotar:(id)sender {
    UIBarButtonItem *btn = sender;
    btn.enabled = NO;
    
    [self.txtAnotacao resignFirstResponder];
    [self.arrAnotacoes addObject:self.txtAnotacao.text];
    self.gerenciador.arrAtualizacao = self.arrAnotacoes;
    [self.gerenciador saveToURL:self.gerenciador.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
        if(success){
            NSLog(@"Arquivo salvo com sucesso!");
            [self.tableView reloadData];
        } else {
            NSLog(@"Erro ao salvar o arquivo!");
            [self.arrAnotacoes removeLastObject];
        }
        btn.enabled = YES;
    }];
}

-(void) atualizar {
    //Procurar se já existe o documento na pasta Documents no iCloud
    self.busca = [[NSMetadataQuery alloc] init];
    [self.busca setSearchScopes:@[NSMetadataQueryUbiquitousDocumentsScope]];
    //Seta o nome do arquivo a ser procurado
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K == %@", NSMetadataItemFSNameKey, @"dadosAppCloud.plist"];
    [self.busca setPredicate:pred];
    //Adiciona um observador para ser acionado quando a busca estiver pronta
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buscaPronta) name:NSMetadataQueryDidFinishGatheringNotification object:nil];
    //Dispara a busca
    [self.busca startQuery];
}

-(void) buscaPronta{
    [self.busca disableUpdates];
    [self.busca stopQuery];
    
    if(self.busca.resultCount == 1){
        //Encontrou o arquivo - Traz o conteúdo
        NSMetadataItem *arquivo = [self.busca resultAtIndex:0];
        self.urlArquivo = [arquivo valueForAttribute:NSMetadataItemURLKey];
        //Baixa o arquivo para o gerenciador
        self.gerenciador = [[GerenciadoArquivo alloc] initWithFileURL:self.urlArquivo];
        [self.gerenciador openWithCompletionHandler:^(BOOL success) {
            if(success){
                NSLog(@"Arquivo aberto com sucesso!");
                self.arrAnotacoes = self.gerenciador.arrAtualizacao;
                [self.tableView reloadData];
            } else {
                NSLog(@"Erro ao abrir o arquivo!");
            }
        }];
    } else {
        //Não encontrou o arquivo - Cria um arquivo
        NSURL *percursoGravar = [[self.ubiq URLByAppendingPathComponent:@"Documents"] URLByAppendingPathComponent:@"dadosAppCloud.plist"];
        self.gerenciador = [[GerenciadoArquivo alloc] initWithFileURL:percursoGravar];
        self.gerenciador.arrAtualizacao = self.arrAnotacoes;
        [self.gerenciador saveToURL:self.gerenciador.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if(success){
                NSLog(@"Arquivo criado com sucesso!");
            } else {
                NSLog(@"Erro ao criar o arquivo!");
            }
        }];
    }
    
    [self.refreshControl endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.arrAnotacoes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCelula" forIndexPath:indexPath];
    cell.textLabel.text = self.arrAnotacoes[indexPath.row];
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
