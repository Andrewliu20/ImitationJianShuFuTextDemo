//
//  FontStyleSelectView.m
//  Pods
//
//  Created by andrewliu on 16/7/28.
//
//

#import "FontStyleSelectView.h"
#define  HEIGHT 15
#define  SPACE 5


@interface FontStyleSelectView()



@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong)  UIImageView *iconVIew;

@property (nonatomic,strong)  NSArray *dataHImageNameArr;
@end


@implementation FontStyleSelectView
{
    BOOL boldBool;
    BOOL italicBool;
    BOOL strikeThroughBool;
    BOOL quoteBool;
    BOOL h1Bool;
    BOOL h2Bool;
    BOOL h3Bool;
    BOOL h4Bool;
    
    UIImageView *h1ImageView ;
    UIImageView *h2ImageView ;
    UIImageView *h3ImageView ;
    UIImageView *h4ImageView ;
    UIImageView *blockquoteImageView;
    UIImageView *boldImageView;
    UIImageView *italImageView;
    UIImageView *strikeThrougImageView;
    
    
}
- (instancetype)init
{
    if (self = [super init]) {
        
        
        _dataArray = @[@"icon_format_bold.png",@"icon_format_italic.png",@"icon_format_strikethrough.png",@"icon_format_quote.png",@"ZSSh1.png",@"ZSSh2.png",@"ZSSh3.png",@"ZSSh4.png"];
        
        
//        _dataArray = @[@"icon_format_bold.png",@"icon_format_italic.png",@"icon_format_strikethrough.png",@"ZSSh1.png",@"ZSSh2.png",@"ZSSh3.png",@"ZSSh4.png"];

        
        _dataHImageNameArr = @[@"icon_format_boldH.png",@"icon_format_italicH.png",@"icon_format_strikethroughH.png",@"icon_format_quoteH.png",@"ZSSh1H.png",@"ZSSh2H.png",@"ZSSh3H.png",@"ZSSh4H.png"];
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backStyleNoti) name:@"undoBackNoti" object:nil];
}

- (void)viewDidLoad{

     [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor blackColor];
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 300, 45) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    //注册Cell，必须要有
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    [self.view addSubview:self.collectionView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backStyleNoti) name:@"selectSplitLineNoti" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backStyleNoti) name:@"undoBackNoti" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backKeyBorderNoti:) name:@"ChangStylekeyBorderNotis" object:nil];
}


- (void)backKeyBorderNoti:(NSNotification *)noti{
    
    NSString *style = [noti.userInfo objectForKey:@"style"];
    
    
    if ([style containsString:@"bold"]) {
        
        boldBool = true;
       
        boldImageView.image = [UIImage imageNamed:@"icon_format_boldH.png"];
    }else{
        boldBool = false;
         boldImageView.image = [UIImage imageNamed:@"icon_format_bold.png"];
    }
    
    if([style containsString:@"italic"]){

        
        italicBool = true;
        
        italImageView.image = [UIImage imageNamed:@"icon_format_italicH.png"];

    }else{
        
        italicBool = false;
        italImageView.image = [UIImage imageNamed:@"icon_format_italic.png"];
    }
    
    if([style containsString:@"strikeThrough"]){
  
        
        
        strikeThroughBool = true;
         strikeThrougImageView.image = [UIImage imageNamed:@"icon_format_strikethroughH.png"];
    }else{
        
        strikeThroughBool = false;
        strikeThrougImageView.image = [UIImage imageNamed:@"icon_format_strikethrough.png"];
    }
    
    
    if ([style containsString:@"blockquote"]) {
        quoteBool = true;
        blockquoteImageView.image = [UIImage imageNamed:@"icon_format_quoteH.png"];
    }else{
    
        quoteBool = false;
        blockquoteImageView.image = [UIImage imageNamed:@"icon_format_quote.png"];
    }
    
    if([style containsString:@"p"]){
        
        h1Bool = false;
        h2Bool = false;
        h3Bool = false;
        h4Bool = false;
        
        h1ImageView.image = [UIImage imageNamed:@"ZSSh1.png"];
        
        
        h2ImageView.image = [UIImage imageNamed:@"ZSSh2.png"];
        
        
        h3ImageView.image = [UIImage imageNamed:@"ZSSh3.png"];
        
        
        h4ImageView.image = [UIImage imageNamed:@"ZSSh4.png"];
    }else{
        
        
        if([style containsString:@"h1"]){
            
            h1Bool = true;
             h1ImageView.image = [UIImage imageNamed:@"ZSSh1H.png"];
            
            
        }else{
            
            h1Bool = false;
            h1ImageView.image = [UIImage imageNamed:@"ZSSh1.png"];
        }
        if([style containsString:@"h2"]){
            
            h2Bool = true;
            h2ImageView.image = [UIImage imageNamed:@"ZSSh2H.png"];
            
            
        }else{
            
            h2Bool = false;
            h2ImageView.image = [UIImage imageNamed:@"ZSSh2.png"];
        }
        if([style containsString:@"h3"]){
            
            h3Bool = true;
            h3ImageView.image = [UIImage imageNamed:@"ZSSh3H.png"];
            
            
        }else{
            
            h3Bool = false;
            h3ImageView.image = [UIImage imageNamed:@"ZSSh3.png"];
        }
        if([style containsString:@"h4"]){
            
            h4Bool = true;
            h4ImageView.image = [UIImage imageNamed:@"ZSSh4H.png"];
            
            
        }else{
            
            h4Bool = false;
            h4ImageView.image = [UIImage imageNamed:@"ZSSh4.png"];
        }

        
    }
    
    
}

- (void)backStyleNoti{
    

    
    
    if (boldBool && !italicBool && !strikeThroughBool && !quoteBool) {
        
        boldBool = !boldBool;
        
    }else if (!boldBool && italicBool && !strikeThroughBool && !quoteBool){
        italicBool = !italicBool;
    }else if (!boldBool && !italicBool && strikeThroughBool && !quoteBool){
        strikeThroughBool = !strikeThroughBool;
    }else if(!boldBool && !italicBool && !strikeThroughBool && quoteBool){
        quoteBool = !quoteBool;
    }
    else if (boldBool && italicBool && !strikeThroughBool &&!quoteBool){
        boldBool = !boldBool;
        italicBool = !italicBool;
    }else if (boldBool && !italicBool && strikeThroughBool && !quoteBool){
        boldBool = !boldBool;
        strikeThroughBool = !strikeThroughBool;
    }else if(boldBool && !italicBool && !strikeThroughBool && quoteBool){
        boldBool = !boldBool;
        quoteBool = !quoteBool;
    }
    else if (!boldBool && italicBool && strikeThroughBool && !quoteBool){
        italicBool = !italicBool;
        strikeThroughBool = !strikeThroughBool;
    }else if (!boldBool && italicBool && !strikeThroughBool && quoteBool){
        italicBool = !italicBool;
        quoteBool = !quoteBool;
    }
    else if(boldBool && !italicBool && strikeThroughBool && quoteBool){
    
        strikeThroughBool = !strikeThroughBool;
        quoteBool = !quoteBool;
    }
    
    else if (boldBool && italicBool && strikeThroughBool && quoteBool){
         boldBool = !boldBool;
        italicBool = !italicBool;
        strikeThroughBool = !strikeThroughBool;
        quoteBool = !quoteBool;
    }
    
    
    
    
        boldImageView.image = [UIImage imageNamed:@"icon_format_bold.png"];
    
    
        italImageView.image = [UIImage imageNamed:@"icon_format_italic.png"];
    
    
    
        strikeThrougImageView.image = [UIImage imageNamed:@"icon_format_strikethrough.png"];
    
    
        blockquoteImageView.image = [UIImage imageNamed:@"icon_format_quote.png"];
    
        h1ImageView.image = [UIImage imageNamed:@"ZSSh1.png"];
    
    
        h2ImageView.image = [UIImage imageNamed:@"ZSSh2.png"];
    
    
        h3ImageView.image = [UIImage imageNamed:@"ZSSh3.png"];
    
    
        h4ImageView.image = [UIImage imageNamed:@"ZSSh4.png"];
    
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
 
    
    if (indexPath.row == 5) {
        
        _iconVIew = [[UIImageView alloc] initWithFrame:CGRectMake(SPACE - 3, SPACE*2 + 2, HEIGHT, 13)];
       
    }else if(indexPath.row == 6){
         _iconVIew = [[UIImageView alloc] initWithFrame:CGRectMake(SPACE - 3, SPACE*2 + 4, HEIGHT, 11)];
    }else if(indexPath.row == 7){
        _iconVIew = [[UIImageView alloc] initWithFrame:CGRectMake(SPACE - 3, SPACE*2+6, HEIGHT, 9)];

    }else{
        _iconVIew = [[UIImageView alloc] initWithFrame:CGRectMake(SPACE-1, SPACE*2 , HEIGHT, HEIGHT)];
    }
 _iconVIew.contentMode = UIViewContentModeCenter;
    _iconVIew.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
    
    _iconVIew.tag = 1000 + indexPath.row;
    
    
    _iconVIew.userInteractionEnabled = YES;
    
   
    
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    label.textColor = [UIColor redColor];
//    label.text = [NSString stringWithFormat:@"%d",indexPath.row];
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.contentView addSubview:_iconVIew];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(25, 30);

}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(4,3, 0, 0);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //通过通知实现按钮的交互
    
    
    
    
    
    blockquoteImageView = [self .view viewWithTag:1003];
    h1ImageView = [self.view viewWithTag:1004];
    h2ImageView = [self.view viewWithTag:1005];
    h3ImageView = [self.view viewWithTag:1006];
    h4ImageView = [self.view viewWithTag:1007];
    
    if (indexPath.row == 0) {
       
        boldBool = !boldBool;
        boldImageView = [self.view viewWithTag:1000];
        if (boldBool) {
            boldImageView.image = [UIImage imageNamed:self.dataHImageNameArr[indexPath.row]];
        }else{
            boldImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
            
        }
    }
    
    else if (indexPath.row == 1) {
        
        italicBool = !italicBool;
       italImageView = [self.view viewWithTag:1001];
    
        NSLog(@"italic==%d",italicBool);
        
        if (italicBool) {
            italImageView.image = [UIImage imageNamed:self.dataHImageNameArr[indexPath.row]];
        }else{
            italImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
            
        }
    }
    
    else if (indexPath.row == 2) {
        
        strikeThrougImageView = [self.view viewWithTag:1002];
        
        strikeThroughBool = !strikeThroughBool;
        
        
        
        if (strikeThroughBool) {
            
            
            strikeThrougImageView.image = [UIImage imageNamed:self.dataHImageNameArr[indexPath.row]];
            
        }else{
            NSLog(@"--=====%d",strikeThroughBool);
            strikeThrougImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
            
        }
    }
    
    if (indexPath.row == 3) {
        
        quoteBool = !quoteBool;
        
        if (quoteBool) {
            blockquoteImageView.image = [UIImage imageNamed:self.dataHImageNameArr[indexPath.row]];
        }else{
            
            blockquoteImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
        }
    }
        
        else if(indexPath.row == 4){
            h1Bool = !h1Bool;
            
            if (h1Bool) {
                h2Bool = NO;
                h3Bool = NO;
                h4Bool = NO;
                h1ImageView.image = [UIImage imageNamed:self.dataHImageNameArr[indexPath.row]];
                h2ImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row + 1] ];
                h3ImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row + 2]];
                h4ImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row +  3]];
//                blockquoteImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row-1]];
                
            }else{
                h1ImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
                
            }
            
        }
        
        
      else  if (indexPath.row == 5) {
            
            h2Bool = !h2Bool;
            
            if (h2Bool) {
                h1Bool = NO;
                h3Bool = NO;
                h4Bool = NO;
                h2ImageView.image = [UIImage imageNamed:self.dataHImageNameArr[indexPath.row]];
                h1ImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row - 1] ];
                h3ImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row + 1]];
                h4ImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row +  2]];
//                blockquoteImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row-2]];
                
                
            }else{
                h2ImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
                
            }
        }
        
      else  if (indexPath.row == 6) {
            
            h3Bool = !h3Bool;
            
            if (h3Bool) {
                h1Bool = NO;
                h2Bool = NO;
                h4Bool = NO;
                
                h3ImageView.image = [UIImage imageNamed:self.dataHImageNameArr[indexPath.row]];
                h1ImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row - 2] ];
                h2ImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row - 1]];
                h4ImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row +  1]];
//                blockquoteImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row-3]];
            }else{
                h3ImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
                
            }
        }
        
       else if (indexPath.row == 7) {
            
            h4Bool = !h4Bool;
            if (h4Bool) {
                h1Bool = NO;
                h2Bool = NO;
                h3Bool = NO;
                h4ImageView.image = [UIImage imageNamed:self.dataHImageNameArr[indexPath.row]];
                h1ImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row - 3] ];
                h2ImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row - 2]];
                h3ImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row - 1]];
//                blockquoteImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row-4]];
            }else{
                h4ImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
                
            }
        }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeFontStyleNoti" object:nil userInfo:@{@"item":[NSString stringWithFormat:@"%d",indexPath.row]}];
        
}
    




- (void)backStyle:(NSInteger) index{
    
    if (index == 0) {
        
        boldImageView.image = [UIImage imageNamed:self.dataArray[index]];
    }
    if (index == 1) {
        italImageView.image = [UIImage imageNamed:self.dataArray[index]];
    }
    
    if (index == 2) {
        strikeThrougImageView.image = [UIImage imageNamed:self.dataArray[index]];
    }
    if (index == 3) {
        h1ImageView.image = [UIImage imageNamed:self.dataArray[index]];
    }
    if (index == 4) {
        h2ImageView.image = [UIImage imageNamed:self.dataArray[index]];
    }
    if (index == 5) {
        h3ImageView.image = [UIImage imageNamed:self.dataArray[index]];
    }
    if (index == 6) {
        h4ImageView.image = [UIImage imageNamed:self.dataArray[index]];
    }
   
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;

}


@end
