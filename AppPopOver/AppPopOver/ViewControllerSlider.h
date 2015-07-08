//
//  ViewControllerSlider.h
//  AppPopOver
//
//  Created by Aluno on 9/2/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import <UIKit/UIKit.h>

//Vamos declarar a lista de métodos que poderão ser acionados dentro do objeto setado na property delegate
@protocol ViewControllerSliderDelegate <NSObject>

@required
-(void) acionaramSliderEACorMudouPara:(UIColor*)novaCor;

@end

@interface ViewControllerSlider : UIViewController

//Criando espaço de memória para guardar o endereço do objeto para ser acionado ao ocorrer um evento dentro desta classe
//Property do tipo id porque pode ser qualquer tipo de objeto
//<ViewControllerSliderDelegate> define que essa property tem métodos para ser implementados
@property (nonatomic, strong) id <ViewControllerSliderDelegate> delegate;

@end
