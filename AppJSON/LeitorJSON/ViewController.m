//
//  ViewController.m
//  LeitorJSON
//
//  Created by Aluno on 09/09/14.
//  Copyright (c) 2014 Escola iAi?. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //lendo um JSON
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dados" ofType:@"json"];
    
    NSData *dados = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:dados options:NSJSONReadingAllowFragments error:nil];
    
    NSLog(@"%@", dict);
    
    NSLog(@"%@", dict[@"firstName"]);
    
    //escrevendo um JSON
    NSArray *array = @[@"Fernando", @"João", @"Manuel", @"Paulo", @"Maria", @"Manuela"];
    
    NSDictionary *dicionario = @{@"nome": @"José", @"idade": @"59", @"profissao": @"empresário"};
    
    NSData *dataArray = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    
    NSData *dataDict = [NSJSONSerialization dataWithJSONObject:dicionario options:NSJSONWritingPrettyPrinted error:nil];
    
    [dataArray writeToFile:[NSHomeDirectory() stringByAppendingString:@"/Documents/array.json"] atomically:YES];
    
    [dataDict writeToFile:[NSHomeDirectory() stringByAppendingString:@"/Documents/dict.json"] atomically:YES];
    
    
}












- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
