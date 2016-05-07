//
//  EZSegmentCollectionView.m
//  EZSegmentCollectionViewDemo
//
//  Created by macbook pro on 16/5/6.
//  Copyright © 2016年 ElonZhang. All rights reserved.
//

#import "EZSegmentCollectionView.h"


#define BACKCOLOR [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1]
#define LINECOLOR [UIColor colorWithRed:227/255.0f green:227/255.0f blue:227/255.0f alpha:1]
#define FONTCOLOR [UIColor colorWithRed:228/255.0f green:87/255.0f blue:71/255.0f alpha:1]


/**
 
 布局类
 
 */
@interface EZCollectionViewLayoyt : UICollectionViewFlowLayout

- (instancetype)initWithSizeOfItem:(CGSize)itemSize withDirectionType:(EZSegmentDirectionType) type ;

@end
@implementation EZCollectionViewLayoyt

-(instancetype)init{
    
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(70, 40);
        self.minimumLineSpacing = 0;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}


- (instancetype)initWithSizeOfItem:(CGSize)itemSize withDirectionType:(EZSegmentDirectionType) type {
    self = [super init];
    if (self) {
        self.itemSize = itemSize;
        self.minimumLineSpacing = 1;
        if (type == EZSegmentDirectionTypeHorizontal) {
            self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        }else{
            self.scrollDirection = UICollectionViewScrollDirectionVertical;
        }
        
    }
    return self;
}


@end


#pragma mark - 自定义cell类
/**
 *  自定义cell类
 *
 */
@interface EZCollectionCell : UICollectionViewCell

@property(strong,nonatomic)UILabel * titleLabel;

- (void)configureCellWithTitle:(NSString *)title defaultColor:(UIColor*)defaultColor;
- (void)setHighlitCorlorForLabelWithColor:(UIColor *)color;

@end

@implementation EZCollectionCell

-(UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.hidden = NO;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.titleLabel.hidden = NO;
    }
    return self;
    
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.titleLabel.hidden = NO;
    }
    return self;
}


- (void)configureCellWithTitle:(NSString *)title defaultColor:(UIColor*)defaultColor{
    
    self.titleLabel.text = title;
    self.titleLabel.textColor = defaultColor;
}

- (void)setHighlitCorlorForLabelWithColor:(UIColor *)color{
    
    self.titleLabel.textColor = color;
    
}

@end



@interface EZSegmentCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(strong,nonatomic) UICollectionView *scrollCollectView;

@property(assign,nonatomic)EZSegmentDirectionType type;
@property(assign,nonatomic)CGFloat heightOrWidth;

@property(assign,nonatomic)NSUInteger titleNumPerPage;

@property(assign,nonatomic)NSUInteger highlightFlag;

/**
 *  title 高亮颜色
 */
@property(strong,nonatomic)UIColor *highlitColor;
/**
 *  title 普通颜色
 */
@property(strong,nonatomic)UIColor *defaultColor;

@end

@implementation EZSegmentCollectionView

- (instancetype)init{
    
    self = [super initWithFrame:self.window.bounds];
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame withDirectionType:(EZSegmentDirectionType)type{
    self.type = type;
    self = [super initWithFrame:frame];
    if (self) {
        //self.scrollCollectView.hidden = NO;
        [self addSubview:self.scrollCollectView];
    }
    return self;
}

- (CGFloat)heightOrWidth{
    if (_heightOrWidth!=0) {
        return _heightOrWidth;
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(heightOrWidthOfCollectionItem:)]) {
        _heightOrWidth = [self.dataSource heightOrWidthOfCollectionItem:self];
    }else{
        if (self.type == 0) {
            _heightOrWidth = 40;
        }else{
        
            _heightOrWidth = 17;
        }
        
    }
    return _heightOrWidth;
}

- (UIColor *)defaultColor{
    if (!_defaultColor) {
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(colorOfSegmentViewTitleFont:)]) {
            _defaultColor = [self.dataSource colorOfSegmentViewTitleFont:self];
        }else{
            _defaultColor = [UIColor blackColor];
        }
    }
    return _defaultColor;
}
- (UIColor *)highlitColor{
    if (!_highlitColor) {
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(colorOfSegmentViewTitleFontHighLight:)]) {
            _highlitColor = [self.dataSource colorOfSegmentViewTitleFontHighLight:self];
        }else{
            _highlitColor = FONTCOLOR;
        }
    }
    return _highlitColor;
}

- (NSUInteger)titleNumPerPage{
    if (!_titleNumPerPage) {
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfCollectionItemPerPage:)]) {
            _titleNumPerPage = [self.dataSource numberOfCollectionItemPerPage:self];
        }else{
            _titleNumPerPage = 5;
        }
    }
    return _titleNumPerPage;
}


-(UICollectionView *)scrollCollectView
{
    if (!_scrollCollectView) {
        
        CGFloat perWidth ;
        CGFloat perHeight;
        CGSize size;
        perHeight = self.heightOrWidth;
        if (self.type == 0) {
           perWidth  = self.bounds.size.width/self.titleNumPerPage;
            size =  CGSizeMake(perWidth, perHeight);
        }else{
            perWidth  = self.bounds.size.height/self.titleNumPerPage;
            size = CGSizeMake(perHeight, perWidth);
        }
        
        EZCollectionViewLayoyt *titleFlowLayout = [[EZCollectionViewLayoyt alloc] initWithSizeOfItem:size withDirectionType:self.type];
        
        _scrollCollectView= [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:titleFlowLayout];
        _scrollCollectView.backgroundColor = BACKCOLOR;
        _scrollCollectView.showsHorizontalScrollIndicator = NO;
        _scrollCollectView.showsVerticalScrollIndicator = NO;
        
        _scrollCollectView.dataSource = self;
        _scrollCollectView.delegate = self;

        [_scrollCollectView registerClass:[EZCollectionCell class] forCellWithReuseIdentifier:@"titleCell"];
    }
    return _scrollCollectView;
}


#pragma mark - CollectionViewDelegate


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfAllItemsInSegementCollectionView: )]) {
        return [self.dataSource numberOfAllItemsInSegementCollectionView:self];
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        EZCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCell" forIndexPath:indexPath];
        
        NSString *title;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(segmentCollectionView:titleForPerItemInIndex:)]) {
            title = [self.dataSource segmentCollectionView:self titleForPerItemInIndex:indexPath.item];
        }else{
            title =@( indexPath.item).stringValue;
        }
        
        [cell configureCellWithTitle:title defaultColor:self.defaultColor];
        
        if (indexPath.item == self.highlightFlag) {
            [cell setHighlitCorlorForLabelWithColor:self.highlitColor];
        }
        
        return cell;
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        if (self.delegate &&[self.delegate respondsToSelector:@selector(segmentCollectionView:DidSelectedIndex:)] ) {
            [self.delegate segmentCollectionView:collectionView DidSelectedIndex:indexPath.item];
        }
        self.highlightFlag = indexPath.item;
        
        [self.scrollCollectView reloadData];
        
        //titleLabel滚动到中间位置
        if (self.type == 0) {
            [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }else{
             [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
        }
    
    
}

- (void)segmentScrollToItemAtIndex:(NSUInteger)index{

    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:index];
    //横向 移动到指定item
    [self.scrollCollectView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

}



@end
