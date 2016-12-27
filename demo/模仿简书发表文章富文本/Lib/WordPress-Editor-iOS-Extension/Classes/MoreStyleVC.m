//
//  MoreStyleVC.m
//  Pods
//
//  Created by andrewliu on 16/7/29.
//
//

#import "MoreStyleVC.h"

@interface MoreStyleVC ()
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation MoreStyleVC
{
    BOOL strikeThroughBool;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
      _dataArray = @[@"con_format_media@2x",@"icon_format_link.png",@"icon_format_more.png"];
//    _dataArray = @[@"con_format_media@2x",@"icon_format_link.png"];
    
    
    self.view.backgroundColor = [UIColor blackColor];
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 185, 45) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:[UIColor blackColor]];
    
    //注册Cell，必须要有
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [self.view addSubview:self.collectionView];
}


#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
//    cell.backgroundColor = [UIColor redColor];
    UIImageView *iconVIew =  [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 40, 25)];
    
    
    if (indexPath.row == 2) {
        iconVIew = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 45, 25)];
    }
    
    iconVIew.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
    
    iconVIew.contentMode = UIViewContentModeCenter;
    iconVIew.userInteractionEnabled = YES;
   
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.contentView addSubview:iconVIew];
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return CGSizeMake(45, 40);
    }

    return CGSizeMake(40, 40);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    
    return UIEdgeInsetsMake(5, 15, 0,0);
    
    
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    
    //通过通知实现按钮的交互
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"MoreStyleSetingNoti" object:nil userInfo:@{@"item":[NSString stringWithFormat:@"%d",indexPath.row]}];
    
    if (indexPath.row == 2) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectSplitLineNoti" object:nil];
    }
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
    
}



@end
