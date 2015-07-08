//
//  Relogio.m
//  AppCoreGraphics
//
//  Created by Claudio Shinohara on 17/09/14.
//  Copyright (c) 2014 Shinohara. All rights reserved.
//

#import "Relogio.h"

@interface Relogio()

@property (nonatomic, assign) CGFloat anguloSegundo, anguloMinuto, anguloHora;

@end

@implementation Relogio

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSDate *agora = [NSDate date];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"HH:mm:ss"];
        NSString *horario = [format stringFromDate:agora];
        NSArray *arr = [horario componentsSeparatedByString:@":"];
        float hora = [arr[0] floatValue];
        float minuto = [arr[1] floatValue];
        float segundo = [arr[2] floatValue];
        self.anguloSegundo = -(2*M_PI)*(segundo/60);
        self.anguloMinuto = -(2*M_PI)*(minuto/60) + self.anguloSegundo/60;
        self.anguloHora = -(2*M_PI)*(hora/12) + self.anguloMinuto/60;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //Pega o contexto da própriva view para referência do desenho
    CGContextRef contexto = UIGraphicsGetCurrentContext();
    
    //Escolhe a cor de preenchimento
    //CGContextSetRGBFillColor(contexto, 0, 0, 0, 1);
    //Desenha círculo
    //CGContextFillEllipseInRect(contexto, CGRectMake(10, 10, rect.size.width - 20, rect.size.height - 20));
    //CGContextSetRGBFillColor(contexto, 1, 1, 1, 1);
    //CGContextFillEllipseInRect(contexto, CGRectMake(15, 15, rect.size.width - 30, rect.size.height - 30));
    
    CGContextSetRGBStrokeColor(contexto, 0, 0, 0, 1);
    CGContextSetLineWidth(contexto, 5);
    CGContextStrokeEllipseInRect(contexto, CGRectMake(15, 15, rect.size.width - 30, rect.size.height - 30));
    
    //Desenha reta - SEGUNDOS
    CGContextBeginPath(contexto);
    //Inicia ponto da reta
    CGContextMoveToPoint(contexto, rect.size.width/2, rect.size.height/2);
    //Define ponto final da reta
    CGContextAddLineToPoint(contexto, rect.size.width/2 - sin(self.anguloSegundo)*70, rect.size.height/2 - cos(self.anguloSegundo)*70);
    //Cor e grossura da linha
    CGContextSetRGBStrokeColor(contexto, 1, 0, 0, 1);
    CGContextSetLineWidth(contexto, 2);
    //Desenha linha
    CGContextStrokePath(contexto);
    //Calcula valor do angulo que se deve andar
    self.anguloSegundo = self.anguloSegundo - 2*M_PI/60;
    
    //Desenha reta - MINUTO
    CGContextBeginPath(contexto);
    //Inicia ponto da reta
    CGContextMoveToPoint(contexto, rect.size.width/2, rect.size.height/2);
    //Define ponto final da reta
    CGContextAddLineToPoint(contexto, rect.size.width/2 - sin(self.anguloMinuto)*50, rect.size.height/2 - cos(self.anguloMinuto)*50);
    //Cor e grossura da linha
    CGContextSetRGBStrokeColor(contexto, 0, 0, 0, 1);
    CGContextSetLineWidth(contexto, 2);
    //Desenha linha
    CGContextStrokePath(contexto);
    //Calcula valor do angulo que se deve andar
    self.anguloMinuto = self.anguloMinuto - 2*M_PI/(60*60);
    
    //Desenha reta - HORA
    CGContextBeginPath(contexto);
    //Inicia ponto da reta
    CGContextMoveToPoint(contexto, rect.size.width/2, rect.size.height/2);
    //Define ponto final da reta
    CGContextAddLineToPoint(contexto, rect.size.width/2 - sin(self.anguloHora)*30, rect.size.height/2 - cos(self.anguloHora)*30);
    //Cor e grossura da linha
    CGContextSetRGBStrokeColor(contexto, 0.5, 0.5, 0.5, 1);
    CGContextSetLineWidth(contexto, 4);
    //Desenha linha
    CGContextStrokePath(contexto);
    //Calcula valor do angulo que se deve andar
    self.anguloHora = self.anguloHora - 2*M_PI/(60*60*60);
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:NO];
}

@end
