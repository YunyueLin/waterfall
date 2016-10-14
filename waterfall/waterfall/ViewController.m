//
//  ViewController.m
//  waterfall
//
//  Created by 林赟越 on 16/10/14.
//  Copyright © 2016年 林赟越. All rights reserved.
//

#import "ViewController.h"
#import "JRPoolView.h"
#import "JRPoolModel.h"
#import "JRPoolViewSubCel.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()<JRPoolViewDelegate,JRPoolViewDataSource>


/** poolView*/
@property(nonatomic,weak) JRPoolView * poolView;


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
    
    self.dataArray=[JRPoolModel getArrayByDics:array];
    
    
}

#pragma mark - 加载视图
- (void) setSubviews{
    JRPoolView * pool=[[JRPoolView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    pool.jrDelegate=self;
    pool.jrDataSource=self;
    [pool show];
    
    
    
    
    [self.view addSubview:pool];
}




#pragma mark ----- 代理方法
/** 返回总列数*/
- (NSInteger) numberOfColumsInPoolView:(JRPoolView *) poolView{
    
    return 4;
}

/** 返回总cell数*/
- (NSInteger) totoalNumbersInPoolView:(JRPoolView *) poolView{
    return self.dataArray.count;
    
}

/** 返回cell数*/
- (JRPoolViewCell *) poolView:(JRPoolView *) poolView cellForPoolViewAtIndex:(NSInteger) index{
    
    
    static NSString * identy=@"cell";
    
    JRPoolViewSubCel * cell = [poolView dequeueReusableCellWithIdentifier:identy];
    
    if (cell==nil) {
        cell=[[JRPoolViewSubCel alloc] initWithIdenty:identy];
        
    }
    
    //获取模型
    
    JRPoolModel * model=self.dataArray[index];
    [cell.imageView setImageWithURL:[NSURL URLWithString:model.img]];
    
    return cell;
    
}


/**返回各个边距*/
- (CGFloat) poolView:(JRPoolView *) poolView  marginForDirection:(JRDirection) direction{
    
    switch (direction) {
        case JRLeftMargin:
            return 10;
            break;
        case JRRightMargin:
            return 10;
            break;
        case JRColumMargin:
            return 10;
            break;
        case JRRowMargin:
            return 10;
            break;
        default:
            break;
    }
    
}

/**返回每个cell的尺寸*/
- (CGSize) poolView:(JRPoolView *) poolView sizeOfCellAtIndex:(NSInteger) index{
    JRPoolModel  * model=self.dataArray[index];
    return CGSizeMake(model.w, model.h);
}


/*
 https://api.weibo.com/oauth2/authorize?client_id=3500736070&&redirect_uri=https://www.baidu.com
 
 https://www.baidu.com/?code=ef939e742d2c9c4f53cabb331d6beabd
 
 {"access_token":"2.00XQKVcFA4juoDbc95debf4awzD2_C","remind_in":"157679999","expires_in":157679999,"uid":"5149592561"}
 https://api.weibo.com/2/statuses/home_timeline.json?access_token=2.00XQKVcFA4juoDbc95debf4awzD2_C
 
 
 
 */



@end
