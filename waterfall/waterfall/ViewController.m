//
//  ViewController.m
//  waterfall
//
//  Created by 林赟越 on 16/10/14.
//  Copyright © 2016年 林赟越. All rights reserved.
//

#import "ViewController.h"
#import "LYYPoolView.h"
#import "LYYPoolModel.h"
#import "LYYPoolViewSubCel.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()<LYYPoolViewDelegate,LYYPoolViewDataSource>


/** poolView*/
@property(nonatomic,weak) LYYPoolView * poolView;


/** 数据数组*/
@property(nonatomic,strong) NSArray * dataArray;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数据
    [self loadData];
    
    //加载视图
    [self setSubviews];
    
    
    
}

#pragma mark - 加载数据
- (void) loadData{
    
    NSString * path=  [[NSBundle mainBundle] pathForResource:@"pool.plist" ofType:nil];
    NSArray * array=[NSArray arrayWithContentsOfFile:path];
    
    self.dataArray=[LYYPoolModel getArrayByDics:array];
    
    
}

#pragma mark - 加载视图
- (void) setSubviews{
    LYYPoolView * pool=[[LYYPoolView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    pool.LYYDelegate=self;
    pool.LYYDataSource=self;
    [pool show];
    
    
    
    
    [self.view addSubview:pool];
}




#pragma mark ----- 代理方法
/** 返回总列数*/
- (NSInteger) numberOfColumsInPoolView:(LYYPoolView *) poolView{
    
    return 4;
}

/** 返回总cell数*/
- (NSInteger) totoalNumbersInPoolView:(LYYPoolView *) poolView{
    return self.dataArray.count;
    
}

/** 返回cell*/
- (LYYPoolViewCell *) poolView:(LYYPoolView *) poolView cellForPoolViewAtIndex:(NSInteger) index{
    
    
    static NSString * identy=@"cell";
    
    LYYPoolViewSubCel * cell = [poolView dequeueReusableCellWithIdentifier:identy];
    
    if (cell==nil) {
        cell=[[LYYPoolViewSubCel alloc] initWithIdenty:identy];
        
    }
    
    //获取模型
    
    LYYPoolModel * model=self.dataArray[index];
    [cell.imageView setImageWithURL:[NSURL URLWithString:model.img]];
    
    return cell;
    
}


/**返回各个边距*/
- (CGFloat) poolView:(LYYPoolView *) poolView  marginForDirection:(LYYDirection) direction{
    
    switch (direction) {
        case LYYLeftMargin:
            return 10;
            break;
        case LYYRightMargin:
            return 10;
            break;
        case LYYColumMargin:
            return 10;
            break;
        case LYYRowMargin:
            return 10;
            break;
        default:
            break;
    }
    
}

/**返回每个cell的尺寸*/
- (CGSize) poolView:(LYYPoolView *) poolView sizeOfCellAtIndex:(NSInteger) index{
    LYYPoolModel  * model=self.dataArray[index];
    return CGSizeMake(model.w, model.h);
}






@end
