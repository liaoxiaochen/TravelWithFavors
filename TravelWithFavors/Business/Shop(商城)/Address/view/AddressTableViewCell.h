//
//  AddressTableViewCell.h
//  TravelWithFavors
//
//  Created by MacBook on 2018/8/21.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressInfoModel.h"

@protocol AddressEditDelegate<NSObject>

- (void)addressEditWithAddressId:(NSString *)addressId;

@end

@interface AddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectImg;

@property (nonatomic, strong) AddressInfoModel *addressModel;

@property (nonatomic, assign) id<AddressEditDelegate>delegate;

@end
