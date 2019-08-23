//
//  MMViewController.m
//  MoreMe2SDK
//
//  Created by 304635659@qq.com on 08/23/2019.
//  Copyright (c) 2019 304635659@qq.com. All rights reserved.
//

#import "MMViewController.h"


#import <MoremeSDK/MoremeSDK.h>
#import <SVProgressHUD.h>


@interface MMViewController ()
    @property (nonatomic,strong)NSDictionary *info;
    @end




@implementation MMViewController
-(NSMutableArray *)layout{
    if (!_layout) {
        _layout =[[NSMutableArray alloc]initWithCapacity:1];
    }
    return _layout;
}
    
    /**
     使用MoremeSDK  需要加载第三方库
     
     pod 'SocketRocket'
     pod 'AFNetworking'
     
     pod 'MBProgressHUD'
     pod 'SVProgressHUD'
     pod 'MJExtension'
     pod 'MJRefresh'
     pod 'SDWebImage', '~> 4.0' //暂时只能支持4.0  更新不行
     pod 'GPUImage'
     pod 'CocoaSecurity'
     #pod 'LKDBHelper'
     
     pod 'AliyunOSSiOS'
     pod 'BabyBluetooth'
     */
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化SDK   这些参数从平台获取，测试阶段可以不传。里面有默认参数
    [MoreMeCammer startWithAppId:@"NSnv13luxnm7x28z89fu59j0m460nnc7" skey:@"88xOm3gdIBKdaaIY" cipher:@"A329C5F88ADB623C41CD4E62BC280A70C1386ECFD9E8491041F974C19D00CD42"];
    // Do any additional setup after loading the view.
    
    //有时上传图片网速太慢，可以使用这个通知名称全局监听 上传进度
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showUploadProgress:) name:@"kNoticeUploadImageProgress"  object:nil];
    
    [self initUI];
    
    //    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //    appDelegate.allowRotation = 0;
}
    //- (void)viewWillAppear:(BOOL)animated{
    //    [super viewWillAppear:animated];
    //    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //    appDelegate.allowRotation = 0;
    //}
    //- (void)viewDidDisappear:(BOOL)animated{
    //    [super viewDidAppear:animated];
    //    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //    appDelegate.allowRotation = 1;
    //}
    //- (void)viewWillDisappear:(BOOL)animated{
    //    [super viewWillDisappear:animated];
    //    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //    appDelegate.allowRotation = 1;
    //}
- (void)showUploadProgress:(NSNotification *)sender{
    
    __weak typeof(&*self) ws = self;
    
    // 获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 获取主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSDictionary *dic =sender.userInfo;
        NSInteger itype =[[dic valueForKey:@"itype"] integerValue];
        NSString *progress =[dic valueForKey:@"progress"];
        // 回到主线程
        dispatch_async(mainQueue, ^{
            UICollectionViewCell * cell =(UICollectionViewCell *)[ws.collectionView  cellForItemAtIndexPath:[NSIndexPath indexPathForItem:itype inSection:0]];
            //            NSLog(@"%@",[cell subviews]);
            UILabel *label =(UILabel *)[cell viewWithTag:itype+100];
            label.text =progress;
        });
    });
}
    
- (void)btnClick:(UIButton *)sender{
    __weak typeof(&*self) ws = self;
    
    //顾客 ID  门店ID  必填，要和图片 、仪器绑定   顾客名字可以不填
    MoreCameraVC *vc =[[MoreCameraVC alloc]initWithCustomerID:@"8" shopID:@"12345" customerName:@"sfd"];
    
    vc.saveBlock = ^(NSArray * _Nonnull images, NSDictionary * _Nonnull info) {
        NSLog(@"%@",info);
        NSLog(@"%@",images);
        
        ws.info =info;
        
        @synchronized (ws.layout) {
            [ws.layout removeAllObjects];
            [ws.layout addObjectsFromArray:images];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [ws.collectionView reloadData];
        });
        
    };
    
    [self presentViewController:vc  animated:YES completion:nil];
}
- (void)btn1Click:(UIButton *)sender{
    
    [MoreOpenImage queryImageInfoByPaht:self.info process:^(NSDictionary * _Nonnull info) {
        NSLog(@"%@",info);
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
    //    [MoreOpenImage  queryAISkinDescriptionWithLanguage:@"tw"  info:^(NSDictionary * _Nonnull info) {
    //
    //    NSLog(@"%@",info);
    //    } failure:^(NSError * _Nonnull error) {
    //
    //    }];
    
}
    
- (void)initUI{
    [self.collectionView setFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-200)];
    /**
     注册item和区头视图、区尾视图
     */
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(100, self.view.frame.size.height-400, 100, 50)];
    [btn setTitle:@"Cammer" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btn1 =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake(250, self.view.frame.size.height-400, 100, 50)];
    [btn1 setTitle:@"report" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor grayColor]];
    [btn1 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}
    
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [SVProgressHUD dismissWithDelay:0.3];
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        /**
         创建layout
         */
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        /**
         创建collectionView
         */
        UICollectionView* collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:collectionView];
        _collectionView =collectionView;
        
        //        __weak typeof(&*self) weakself = self;
        //
        //        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //            // 这个地方是网络请求的处理
        //            //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ////
        ////            [weakself.collectionView reloadData];
        ////            [SVProgressHUD show];
        //            [weakself.collectionView.mj_header endRefreshing];
        //
        //            //            });
        //        }];
        //        _collectionView.mj_header =header;
        //        //自动更改透明度
        //        _collectionView.mj_header.automaticallyChangeAlpha = YES;
        
        //        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //            //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //            // 这个地方是网络请求的处理
        //
        //            [weakself.collectionView.mj_footer endRefreshing];
        //            [SVProgressHUD show];
        //            //            });
        //        }];
        //        _collectionView.mj_footer =footer;
        //        footer.automaticallyChangeAlpha =YES;
    }
    return _collectionView;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}
#pragma mark delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.layout.count;//[self.layout objectAtIndex:section].items.count;
}
    /**
     创建cell
     */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    label.textAlignment =NSTextAlignmentCenter;
    label.textColor =[UIColor grayColor];
    label.backgroundColor =[UIColor clearColor];
    label.font =[UIFont systemFontOfSize:16];
    label.tag =indexPath.item +100;
    NSDictionary *dic =[self.layout objectAtIndex:indexPath.item];
    NSString *imageType =[dic valueForKey:@"imageType"];
    if ([imageType isEqualToString:@"ai"]) {
        NSString *name =[dic valueForKey:@"name"];
        //必须使用这个方法才能下载ai生成的照片
        [MoreOpenImage downloadImageByPath:name process:^(CGFloat progress, UIImage * _Nonnull image) {
            NSLog(@"%0.2f",progress);
            if (progress == 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [imageView setImage:image];
                    label.text =@"";
                });
                
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    label.text =[NSString stringWithFormat:@"%0.2f",progress];
                });
                
            }
        }];
        
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image =[dic valueForKey:@"image"];
            [imageView setImage:image];
        });
        
    }
    [imageView addSubview:label];
    [cell.contentView addSubview:imageView];
    return cell;
}
    
    ///**
    // 创建区头视图和区尾视图
    // */
    //- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    //    if (kind == UICollectionElementKindSectionHeader){
    //        LKBaseCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LKBaseCollectionReusableView_header" forIndexPath:indexPath];
    //        headerView.backgroundColor = [UIColor yellowColor];
    //
    //        return headerView;
    //    }else if(kind == UICollectionElementKindSectionFooter){
    //        LKBaseCollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LKBaseCollectionReusableView_footer" forIndexPath:indexPath];
    //        footerView.backgroundColor = [UIColor blueColor];
    //        return footerView;
    //    }
    //    return nil;
    //
    //}
    
    /**
     点击某个cell
     */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //    YYLog(@"点击了第%ld分item",(long)indexPath.item);
}
    /**
     cell的大小
     */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 100);//[[self.layout objectAtIndex:indexPath.section].items objectAtIndex:indexPath.item].itemSize;
}
    /**
     每个分区的内边距（上左下右）
     */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}
    /**
     分区内cell之间的最小行间距
     */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
    /**
     分区内cell之间的最小列间距
     */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
    ///**
    // 区头大小
    // */
    //- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    //    return [self.layout objectAtIndex:section].headerLayout.headerSize;
    //}
    ///**
    // 区尾大小
    // */
    //- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    //    return [self.layout objectAtIndex:section].footerLayout.footerSize;
    //}
    @end

