//
//  ViewController.m
//  AppMapas
//
//  Created by Aluno on 8/22/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipoMapa;
@property (strong, nonatomic) CLLocationManager *gps;
@property (strong, nonatomic) CLGeocoder *geocoder;
@property (weak, nonatomic) IBOutlet UIButton *botaoGPS;

- (IBAction)tipoMapaMudouValor:(id)sender;
- (IBAction)adicionarPino:(id)sender;
- (IBAction)ligarGPS:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.geocoder = [CLGeocoder new];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //Região Inicial
    
    //Coordenada central
    //CLLocationCoordinate2D coordenada = CLLocationCoordinate2DMake(-23.565893, -46.650874);
    
    //Span - Zoom
    //MKCoordinateSpan zoom = MKCoordinateSpanMake(0.001, 0.001);
    
    //Region - Coordenada, Zoom
    //MKCoordinateRegion region = MKCoordinateRegionMake(coordenada, zoom);
    
    //[self.mapa setRegion:region animated:YES];
    
    [self ligarGPS:self.botaoGPS];
    
}

- (IBAction)tipoMapaMudouValor:(id)sender {
    switch (self.tipoMapa.selectedSegmentIndex) {
        case 0:
            self.mapa.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapa.mapType = MKMapTypeHybrid;
            break;
        case 2:
            self.mapa.mapType = MKMapTypeSatellite;
            break;
            
        default:
            break;
    }
}

- (IBAction)adicionarPino:(id)sender {
    
    [self.mapa removeAnnotations:self.mapa.annotations];
    
    MKPointAnnotation *pino = [MKPointAnnotation new];
    pino.coordinate = self.mapa.centerCoordinate;
    pino.title = @"Carregando informações...";
    //pino.subtitle = @"Subtitulo";
    
    CLLocation *local = [[CLLocation alloc] initWithLatitude:pino.coordinate.latitude longitude:pino.coordinate.longitude];
    
    [self.geocoder reverseGeocodeLocation:local completionHandler:^(NSArray *placemarks, NSError *error) {
        //Dados sobre o local encontrados
        if (placemarks.count > 0) {
            //Primeira posição sempre é a mais relevante
            CLPlacemark *infoLocal = placemarks.firstObject;
            pino.title = infoLocal.thoroughfare;
            pino.subtitle = infoLocal.subLocality;
        }
    }];
    
    [self.mapa addAnnotation:pino];
    [self.mapa selectAnnotation:pino animated:YES];
}

- (IBAction)ligarGPS:(id)sender {
    UIButton *botao = (UIButton*)sender;
    if(self.gps){
        //Parando a GeoLocalização
        [self.gps stopUpdatingLocation];
        self.gps = nil;
        botao.tintColor = [UIColor blueColor];
    } else {
        self.gps = [CLLocationManager new];
        //Sempre que o usuário se movimentar uma ação é chamada por delegate
        self.gps.delegate = self;
        [self.gps startUpdatingLocation];
        botao.tintColor = [UIColor greenColor];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //Mover o mapa para nova localização - Alterar região - Vetor locatios armazena todas as localizações encontradas
    CLLocation *ultimaLocalizacao = locations.lastObject;
    MKCoordinateSpan zoom = MKCoordinateSpanMake(0.001, 0.001);
    MKCoordinateRegion region = MKCoordinateRegionMake(ultimaLocalizacao.coordinate, zoom);
    
    [self.mapa setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
