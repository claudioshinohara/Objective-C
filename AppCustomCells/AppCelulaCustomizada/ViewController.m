//
//  ViewController.m
//  AppCelulaCustomizada
//
//  Created by Aluno on 9/1/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"
#import "CelulaCDTableViewCell.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tabela;
@property (nonatomic, strong) NSMutableArray *arrCds;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *pathFile = [[NSBundle mainBundle] pathForResource:@"listaCds" ofType:@"plist"];
    self.arrCds = [[NSMutableArray alloc] initWithContentsOfFile:pathFile];
    
    //Ordenação de Arrays
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"artista" ascending:YES];
    self.arrCds = [[self.arrCds sortedArrayUsingDescriptors:@[sort]] mutableCopy];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrCds.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CelulaCDTableViewCell *celula = [tableView dequeueReusableCellWithIdentifier:@"idCelula"];
    celula.lblArtista.text = self.arrCds[indexPath.row][@"artista"];
    celula.lblTitulo.text = self.arrCds[indexPath.row][@"album"];
    celula.lblAno.text = self.arrCds[indexPath.row][@"ano"];
    celula.lblPreco.text = self.arrCds[indexPath.row][@"preco"];
    celula.imgCapa.image = [UIImage imageNamed:self.arrCds[indexPath.row][@"capa"]];
    
    return celula;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
