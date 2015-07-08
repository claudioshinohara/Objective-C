//
//  ViewController.m
//  AppComprasInApp
//
//  Created by Claudio Shinohara on 19/09/14.
//  Copyright (c) 2014 Shinohara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblNome;
@property (weak, nonatomic) IBOutlet UITextView *txtDescricao;
@property (weak, nonatomic) IBOutlet UILabel *lblPreco;

- (IBAction)pedirInfo:(id)sender;
- (IBAction)comprar:(id)sender;

@property (nonatomic, strong) SKProduct *produtoBuscado;
@property (nonatomic, strong) SKProductsRequest *requisicaoProdutos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pedirInfo:(id)sender {
    NSString *idProduto = @"pacoteDezVidas";
    self.requisicaoProdutos = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:idProduto]];
    self.requisicaoProdutos.delegate = self;
    
    [self.requisicaoProdutos start];
}

//Método acionado pelo SKProductsRequest quando um pedido de produtos estiver pronto
-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    if(response.products.count > 0){
        self.produtoBuscado = [response.products objectAtIndex:0];
        self.lblNome.text = self.produtoBuscado.localizedTitle;
        self.txtDescricao.text = self.produtoBuscado.localizedDescription;
        self.lblPreco.text = [NSString stringWithFormat:@"%@", self.produtoBuscado.price];
    } else {
        NSLog(@"%@", response.invalidProductIdentifiers[0]);
        [[[UIAlertView alloc] initWithTitle:@"Erro" message:@"Produto não encontrado" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

- (IBAction)comprar:(id)sender {
    
    SKPayment *pagamento = [SKPayment paymentWithProduct:self.produtoBuscado];
    //Adiciona o pagamento na fila de transações, sendo enviado para AppStore
    [[SKPaymentQueue defaultQueue] addPayment:pagamento];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

//Método acionado pela fila de transações quando ocorrer alguma atualização
-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    //Recebemos todas as transações pendentes em uma NSArray transations
    for(int i=0; i<transactions.count; i++){
        SKPaymentTransaction *transacao = transactions[i];
        if(transacao.transactionState == SKPaymentTransactionStatePurchasing){
            //Transação bem sucedida
            [[[UIAlertView alloc] initWithTitle:@"Compra efetuda" message:@"Parabéns! Você acabou de receber um pacote de 10 vidas." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            //Libera a transação
            [[SKPaymentQueue defaultQueue] finishTransaction:transacao];
        } else if (transacao.transactionState == SKPaymentTransactionStateRestored){
            [[[UIAlertView alloc] initWithTitle:@"Compra efetuda" message:@"Parabéns! Você acabou de receber um pacote de 10 vidas." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            //Libera a transação
            [[SKPaymentQueue defaultQueue] finishTransaction:transacao];
        } else if (transacao.transactionState == SKPaymentTransactionStateFailed){
            [[[UIAlertView alloc] initWithTitle:@"Erro" message:@"Adicione crédito." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            NSLog(@"%@", transacao.error.description);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
