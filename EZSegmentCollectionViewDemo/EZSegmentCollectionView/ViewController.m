//
//  ViewController.m
//  EZSegmentCollectionView
//
//  Created by macbook pro on 16/5/7.
//  Copyright © 2016年 ElonZhang. All rights reserved.
//

#import "ViewController.h"
#import "EZSegmentCollectionView.h"

@interface ViewController ()<EZSegmentCollectionViewDelegate,EZSegmentCollectionViewDataSource>

@property(nonatomic,strong)NSArray *titlesArray;
@property(nonatomic,strong)NSArray *contentViewArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        [self addsegmentCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSArray *)titlesArray{
    
    if (!_titlesArray) {
        _titlesArray = @[@"张晓雄",@"中心小学",@"朝夕相处",@"sam4",@"sam5",@"sam6",@"sam7",@"sam8",@"sam9",@"sam10"] ;
    }
    return _titlesArray;
    
}

- (void)addsegmentCollectionView{
    
    EZSegmentCollectionView *ezcv = [[EZSegmentCollectionView alloc] initWithFrame:CGRectMake(10, 20, 40, self.view.bounds.size.height-40) withDirectionType:EZSegmentDirectionTypeVertical];
    ezcv.dataSource = self;
    ezcv.delegate = self;
    [self.view addSubview:ezcv];
    
}

-(NSUInteger)numberOfAllItemsInSegementCollectionView:(UIView*)view {
    return self.titlesArray.count;
    
}

-(NSString *)segmentCollectionView:(UIView *)view titleForPerItemInIndex:(NSUInteger)index{
    return self.titlesArray[index];
}


@end
