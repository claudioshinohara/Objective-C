//
//  CelulaCDTableViewCell.m
//  AppCelulaCustomizada
//
//  Created by Aluno on 9/1/14.
//  Copyright (c) 2014 Claudio. All rights reserved.
//

#import "CelulaCDTableViewCell.h"

@implementation CelulaCDTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//Método já implementado pela Apple
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //Aciona o método já presente na classe superior
    [super touchesBegan:touches withEvent:event];
}

@end
