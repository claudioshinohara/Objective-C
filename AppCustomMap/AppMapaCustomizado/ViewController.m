//
//  ViewController.m
//  AppMapaCustomizado
//
//  Created by Aluno on 9/4/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapa;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Adiciona um pino
    MKPointAnnotation *pino = [MKPointAnnotation new];
    pino.coordinate = CLLocationCoordinate2DMake(-23.581410, -46.683736);
    pino.title = @"iAi?";
    pino.subtitle = @"Instituto de Artes Interativas";
    [self.mapa addAnnotation:pino];
    
    //Adiciona um circulo
    MKCircle *circulo = [MKCircle circleWithCenterCoordinate:pino.coordinate radius:50];
    [self.mapa addOverlay:circulo];
    
    //Adiciona uma linha
    CLLocationCoordinate2D arrayPontosLinha[2];
    arrayPontosLinha[0] = CLLocationCoordinate2DMake(-23.581786, -46.683993);
    arrayPontosLinha[1] = CLLocationCoordinate2DMake(-23.580640, -46.682287);
    
    MKPolyline *linha = [MKPolyline polylineWithCoordinates:arrayPontosLinha count:2];
    [self.mapa addOverlay:linha];
    
    //Seta local e zoom do mapa
    [self.mapa setRegion:MKCoordinateRegionMake(pino.coordinate, MKCoordinateSpanMake(0.0001, 0.0001))];
    
    //Traçar rota
    CLLocationCoordinate2D minhaCasa = CLLocationCoordinate2DMake(-23.517103, -46.590225);
    
    MKPlacemark *iaiPlace = [[MKPlacemark alloc] initWithCoordinate:pino.coordinate addressDictionary:nil];
    MKPlacemark *casaPlace = [[MKPlacemark alloc] initWithCoordinate:minhaCasa addressDictionary:nil];
    
    MKDirectionsRequest *requisicao = [[MKDirectionsRequest alloc] init];
    requisicao.source = [[MKMapItem alloc] initWithPlacemark:iaiPlace];
    requisicao.destination = [[MKMapItem alloc] initWithPlacemark:casaPlace];
    requisicao.transportType = MKDirectionsTransportTypeAutomobile;
    requisicao.requestsAlternateRoutes = YES;
    
    MKDirections *roteador = [[MKDirections alloc] initWithRequest:requisicao];
    [roteador calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        //response - Recebe as informações da direção
        
        if(error){
            [[[UIAlertView alloc] initWithTitle:@"Erro!" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        } else {
            MKRoute *rota = response.routes[0];
            NSLog(@"%f",rota.distance);
            //rota.expectedTravelTime
            
            [self.mapa addOverlay:rota.polyline level:MKOverlayLevelAboveRoads];
        }
    }];
    
    CLGeocoder *geo = [[CLGeocoder alloc] init];
    [geo geocodeAddressString:@"Rua Guaranésia, 780 - São Paulo" completionHandler:^(NSArray *placemarks, NSError *error) {
        if(placemarks.count > 0){
            CLPlacemark *dadosCasa = placemarks[0];
            NSLog(@"Latitude: %f - Longitude: %f", dadosCasa.location.coordinate.latitude, dadosCasa.location.coordinate.longitude);
        }
    }];
}

//Método acionado quando um objeto é adicionado no mapa
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if([overlay isKindOfClass:[MKCircle class]]) {
        MKCircleRenderer *c = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        c.lineWidth = 3;
        c.strokeColor = [UIColor redColor];
        c.fillColor = [UIColor blackColor];
        c.alpha = 0.5;
        return c;
    } else if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *linha = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        linha.strokeColor = [UIColor blueColor];
        return linha;
    } else {
        return nil;
    }
    
}

//Método acionado ao adicionar um pino no mapa
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *meuPino = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    meuPino.image = [UIImage imageNamed:@"pin"];
    meuPino.canShowCallout = YES;
    meuPino.draggable = YES;
    
    //Adiciona uma imagem nas infos do pino
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    imgV.image = [UIImage imageNamed:@"casa_bola.jpeg"];
    meuPino.leftCalloutAccessoryView = imgV;
    
    //Adiciona um botão nas infos do pino
    UIButton *botao = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [botao addTarget:self action:@selector(irParaDetalhe) forControlEvents:UIControlEventTouchUpInside];
    meuPino.rightCalloutAccessoryView = botao;
    
    return meuPino;
}

-(void)irParaDetalhe{
    [self performSegueWithIdentifier:@"idSegueDetalhe" sender:nil];
}

//Método acionado ao arrastar um pino
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
    
    MKPointAnnotation *p = view.annotation;
    
    if(newState == MKAnnotationViewDragStateStarting){
        p.title = @"Carregando...";
        p.subtitle = @"";
    }
    
    if(newState == MKAnnotationViewDragStateEnding){
        
        CLLocation *localizacao = [[CLLocation alloc] initWithLatitude:p.coordinate.latitude longitude:p.coordinate.longitude];
        
        CLGeocoder *geocoder = [CLGeocoder new];
        
        [geocoder reverseGeocodeLocation:localizacao completionHandler:^(NSArray *placemarks, NSError *error) {
            if(placemarks.count > 0){
                CLPlacemark *local = placemarks[0];
                
                if(local.thoroughfare.length != 0){
                    p.title = local.thoroughfare;
                    p.subtitle = local.locality;
                } else {
                    p.title = @"Não Encontrado";
                    p.subtitle = @"";
                }
            }
        }];
        
        //Evita que o pino flutue no mapa
        view.dragState = MKAnnotationViewDragStateNone;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
