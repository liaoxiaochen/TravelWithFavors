//
//  OrderCardCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderCardCell.h"

@interface OrderCardCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *cardTypeLB;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLB;
@property (weak, nonatomic) IBOutlet UILabel *petTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *petNameLB;
@property (weak, nonatomic) IBOutlet UILabel *petNoTitleLB;
@property (weak, nonatomic) IBOutlet UILabel *petNoLB;

@end

@implementation OrderCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)removeBtnClick:(UIButton *)sender {
    if ([self.orderCardCellDelegate respondsToSelector:@selector(orderCardRemoveCellWithCell:)]) {
        [self.orderCardCellDelegate orderCardRemoveCellWithCell:self];
    }
}

-(void)setPassengerModel:(passengerModel *)passengerModel{
    _passengerModel = passengerModel;
    if ([@"1" isEqualToString:_passengerModel.card_type]) {
        _nameLB.text = _passengerModel.id_card_name;
    }else{
        _nameLB.text = [NSString stringWithFormat:@"%@%@",_passengerModel.surname,_passengerModel.given_name];
    }
    switch ([_passengerModel.card_type integerValue]) {
        case 2:
            _cardTypeLB.text = @"护照";
            break;
        case 3:
            _cardTypeLB.text = @"港澳";
            break;
        case 4:
            _cardTypeLB.text = @"台胞证";
            break;
        default:
            _cardTypeLB.text = @"身份证";
            break;
    }
    _cardNumberLB.text = _passengerModel.card_no;
    if (self.isPet) {//_passengerModel.isHavePet
        _petTitleLB.text = @"携带宠物";
        _petNameLB.text = _passengerModel.pet.pet_name?:@"无";
        _petNoTitleLB.text = @"宠物编号";
        _petNoLB.text = _passengerModel.pet.pet_no?:@"无";
    }else{
        _petTitleLB.text = @"";
        _petNameLB.text = @"";
        _petNoTitleLB.text = @"";
        _petNoLB.text = @"";
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
