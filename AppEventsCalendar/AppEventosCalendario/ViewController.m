//
//  ViewController.m
//  AppEventosCalendario
//
//  Created by Aluno on 8/21/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *botaoDataInicio;
@property (weak, nonatomic) IBOutlet UIButton *botaoDataFim;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerData;
@property (weak, nonatomic) IBOutlet UITableView *tabela;

@property (nonatomic, strong) NSDateFormatter *formatData;
@property (nonatomic, strong) NSDate *dataInicio;
@property (nonatomic, strong) NSDate *dataFim;
@property (nonatomic, strong) NSMutableArray *listaEventos;

- (IBAction)criarEvento:(id)sender;
- (IBAction)selecionarDataInicio:(id)sender;
- (IBAction)selecionarDataFim:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //Criar uma referência à base de dados do calendário
    self.baseEventos = [[EKEventStore alloc] init];
    
    //Pedir autorização para o usuário para acessar os eventos
    [self.baseEventos requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        //Bloco executado quando o usuário seleciona uma das opções do alerta
        if(granted){
            NSLog(@"Acesso autorizado!");
        } else {
            NSLog(@"Acesso negado!");
        }
    }];
    
    /* Exemplo de formatador de datas:
    NSDate *dataAtual = [NSDate date];
    NSDateFormatter *formatadorDatas = [[NSDateFormatter alloc] init];;
    [formatadorDatas setDateFormat:@"dd/MM/yyyy - HH:mm:ss"];
    NSString *hora = [formatadorDatas stringFromDate:dataAtual];
    NSLog(@"%@", hora); */
    
    self.formatData = [[NSDateFormatter alloc] init];
    [self.formatData setDateFormat:@"dd/MM/yyyy - HH:mm"];
}

- (IBAction)criarEvento:(id)sender {
    //Tela padrão para inclusão de eventos
    EKEventEditViewController *editorEvento = [[EKEventEditViewController alloc] init];
    //Referência de onde salvar os eventos
    editorEvento.eventStore = self.baseEventos;
    //Delegar EditViewController
    editorEvento.editViewDelegate = self;
    //Apresentar VC
    [self presentViewController:editorEvento animated:YES completion:nil];
}

-(void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action{

    [self dismissViewControllerAnimated:YES completion:nil];
    
    if(action == EKEventEditViewActionSaved){
        [[[UIAlertView alloc] initWithTitle:@"Calendário" message:@"Evento Salvo com Sucesso!" delegate:nil cancelButtonTitle:@"Fechar" otherButtonTitles: nil] show];
    }
}

- (IBAction)selecionarDataInicio:(id)sender {
    self.botaoDataFim.enabled = !self.botaoDataFim.enabled;
    self.pickerData.hidden = !self.pickerData.hidden;
    self.tabela.hidden = !self.tabela.hidden;
    if(self.pickerData.hidden){
        //Confirmar seleção da data
        [self.botaoDataInicio setTitle:[self.formatData stringFromDate:self.pickerData.date] forState:UIControlStateNormal];
        self.dataInicio = self.pickerData.date;
        [self buscarEventosCalendario];
    } else {
        //Iniciar seleção
        [self.botaoDataInicio setTitle:@"Confirmar" forState:UIControlStateNormal];
    }
}

- (IBAction)selecionarDataFim:(id)sender {
    self.botaoDataInicio.enabled = !self.botaoDataInicio.enabled;
    self.pickerData.hidden = !self.pickerData.hidden;
    self.tabela.hidden = !self.tabela.hidden;
    if(self.pickerData.hidden){
        //Confirmar seleção da data
        [self.botaoDataFim setTitle:[self.formatData stringFromDate:self.pickerData.date] forState:UIControlStateNormal];
        self.dataFim = self.pickerData.date;
        [self buscarEventosCalendario];
    } else {
        //Iniciar seleção
        [self.botaoDataFim setTitle:@"Confirmar" forState:UIControlStateNormal];
    }
}

- (void) buscarEventosCalendario {
    if(self.dataInicio && self.dataFim){
        //NSPredicate - Usado para condições e filtros
        //Criando filtro no intervalo de datas escolhidas
        NSPredicate *filtro = [self.baseEventos predicateForEventsWithStartDate:self.dataInicio endDate:self.dataFim calendars:nil];
        //Buscando por eventos com o filtro
        self.listaEventos = [[self.baseEventos eventsMatchingPredicate:filtro] mutableCopy];
        [self.tabela reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listaEventos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *celula = [tableView dequeueReusableCellWithIdentifier:@"celula"];
    
    EKEvent *evento = self.listaEventos[indexPath.row];
    celula.textLabel.text = evento.title;
    celula.detailTextLabel.text = [self.formatData stringFromDate:evento.startDate];
    
    return celula;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        //Evento selecionado
        EKEvent *evento = self.listaEventos[indexPath.row];
        //Apagar da base
        [self.baseEventos removeEvent:evento span:EKSpanThisEvent commit:YES error:nil];
        [self.listaEventos removeObject:evento];
        
        //Apagar visualmente
        [self.tabela deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
