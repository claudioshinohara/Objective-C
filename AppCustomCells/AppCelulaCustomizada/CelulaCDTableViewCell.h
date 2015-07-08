//
//  CelulaCDTableViewCell.h
//  AppCelulaCustomizada
//
//  Created by Aluno on 9/1/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CelulaCDTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgCapa;
@property (weak, nonatomic) IBOutlet UILabel *lblArtista;
@property (weak, nonatomic) IBOutlet UILabel *lblTitulo;
@property (weak, nonatomic) IBOutlet UILabel *lblAno;
@property (weak, nonatomic) IBOutlet UILabel *lblPreco;


@end
