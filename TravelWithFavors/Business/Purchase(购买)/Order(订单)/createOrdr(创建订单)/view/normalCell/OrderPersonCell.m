//
//  OrderPersonCell.m
//  TravelWithFavors
//
//  Created by 江雅芹 on 2018/3/6.
//  Copyright © 2018年 江雅芹. All rights reserved.
//

#import "OrderPersonCell.h"
#import "OrderPersonAddCell.h"

static NSString *const cellID = @"OrderPersonAddCell";
@interface OrderPersonCell ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@end
@implementation OrderPersonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.addBtn.layer.cornerRadius = 3;
    self.addBtn.layer.borderColor = [UIColor colorWithHexString:@"#FF980D"].CGColor;
    self.addBtn.layer.borderWidth = 1;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(66, 30);
//    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellWithReuseIdentifier:cellID];
    //self.collectionView.scrollEnabled = NO;
}
- (void)setDataLists:(NSArray *)dataLists{
    _dataLists = dataLists;
    [self.collectionView reloadData];
}
#pragma mark --UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataLists.count > 0 ? self.dataLists.count : 0;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    OrderPersonAddCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    passengerModel *model = self.dataLists[indexPath.row];
    if (model.isSelected) {
        cell.layer.cornerRadius = 0;
        cell.layer.borderColor = [UIColor clearColor].CGColor;
        cell.layer.borderWidth = 0;
        cell.bgImageView.image = [UIImage imageNamed:@"txdd_xzk"];
    }else{
        cell.layer.cornerRadius = 3;
        cell.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
        cell.layer.borderWidth = 1;
        cell.bgImageView.image = nil;
    }
    if ([@"1" isEqualToString:model.card_type]) {
        cell.nameLabel.text = model.id_card_name;
    }else{
        cell.nameLabel.text = [NSString stringWithFormat:@"%@%@",model.surname,model.given_name];
    }

    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0, 10, 0, 10);
//}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSMutableArray *lists = [NSMutableArray arrayWithArray:self.seletedLists];
    passengerModel *model = self.dataLists[indexPath.row];
//    if (model.isSelected) {
//        model.isSelected = false;
//    }else{
//        model.isSelected = true;
//    }
    //[lists replaceObjectAtIndex:indexPath.row withObject:type];
//    self.seletedLists = lists;
//    [self.collectionView reloadData];
    if (self.selectedBlock) {
        self.selectedBlock(model);
    }
}
- (IBAction)addBtnClick:(id)sender {
    if (self.addBlock) {
        self.addBlock();
    }
}
- (IBAction)helpBtnClick:(id)sender {
    if (self.helpBlock) {
        self.helpBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
