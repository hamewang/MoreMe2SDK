//
//  MMViewController.h
//  MoreMe2SDK
//
//  Created by 304635659@qq.com on 08/23/2019.
//  Copyright (c) 2019 304635659@qq.com. All rights reserved.
//

@import UIKit;

@interface MMViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
    @property (nonatomic,strong)UICollectionView *collectionView;
    //存放数据数组
    @property (nonatomic,strong)NSMutableArray *layout;
    
@end
