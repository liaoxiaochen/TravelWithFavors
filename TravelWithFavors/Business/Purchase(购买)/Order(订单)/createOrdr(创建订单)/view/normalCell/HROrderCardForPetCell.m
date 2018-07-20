//
//  HROrderCardForPetCell.m
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/24.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HROrderCardForPetCell.h"

@interface HROrderCardForPetCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *cardTypeLB;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLB;

@end

@implementation HROrderCardForPetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)removeBtnClick:(UIButton *)sender {
    if ([self.orderCardForPetCellDelegate respondsToSelector:@selector(orderCardForPetRemoveCellWithCell:)]) {
        [self.orderCardForPetCellDelegate orderCardForPetRemoveCellWithCell:self];
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
}
@end
