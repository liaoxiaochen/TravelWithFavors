//
//  HRPassengerInfoCell.m
//  TravelWithFavors
//
//  Created by cushiro on 2018/4/25.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "HRPassengerInfoCell.h"

@interface HRPassengerInfoCell()
@property (weak, nonatomic) IBOutlet UILabel *passengerNameLB;
@property (weak, nonatomic) IBOutlet UILabel *IDCardLB;
@property (weak, nonatomic) IBOutlet UILabel *petNameLB;
@property (weak, nonatomic) IBOutlet UILabel *petNoLB;

@end

@implementation HRPassengerInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setPassengerModel:(passengerModel *)passengerModel{
    _passengerModel = passengerModel;
    if ([@"1" isEqualToString:passengerModel.card_type]) {
        _passengerNameLB.text = [NSString stringWithFormat:@"姓名:%@",passengerModel.id_card_name];
    }else{
        _passengerNameLB.text = [NSString stringWithFormat:@"姓名:%@%@",passengerModel.surname,passengerModel.given_name];
    }
    _IDCardLB.text = [NSString stringWithFormat:@"身份证号:%@",passengerModel.card_no];
    if (passengerModel.pet) {
        _petNameLB.text = [NSString stringWithFormat:@"携带宠物:%@",passengerModel.pet.pet_name];
        _petNoLB.text = [NSString stringWithFormat:@"宠物编号:%@",passengerModel.pet.pet_no?:@""];
    }else{
        _petNameLB.text = @"";
        _petNoLB.text = @"";
    }
}

@end
