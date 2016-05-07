//
//  EZSegmentCollectionView.h
//  EZSegmentCollectionViewDemo
//
//  Created by macbook pro on 16/5/6.
//  Copyright © 2016年 ElonZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EZSegmentDirectionType) {
    EZSegmentDirectionTypeHorizontal,
    EZSegmentDirectionTypeVertical,
};

@protocol EZSegmentCollectionViewDataSource <NSObject>

-(NSUInteger)numberOfAllItemsInSegementCollectionView:(UIView*)view ;

-(NSString *)segmentCollectionView:(UIView *)view titleForPerItemInIndex:(NSUInteger)index;

@optional
/**
 *  默认值每页有5个label
 */
- (NSUInteger)numberOfCollectionItemPerPage:(UIView *)view;

//横向的 高度了；纵向的宽度
- (CGFloat)heightOrWidthOfCollectionItem:(UIView *)view;

- (CGSize)itemSizeOfItem:(UIView *)view;

- (UIColor *)colorOfSegmentViewBackground:(UIView *)view;

- (UIColor *)colorOfSegmentViewTitleFont:(UIView *)view;

- (UIColor *)colorOfSegmentViewTitleFontHighLight:(UIView *)view;


@end

@protocol EZSegmentCollectionViewDelegate <NSObject>

@optional
- (void)segmentCollectionView:(UIView *)view DidSelectedIndex:(NSUInteger)index ;


@end


@interface EZSegmentCollectionView : UIView

@property(weak,nonatomic)id<EZSegmentCollectionViewDelegate> delegate;
@property(weak,nonatomic)id<EZSegmentCollectionViewDataSource> dataSource;

- (instancetype)initWithFrame:(CGRect)frame withDirectionType:(EZSegmentDirectionType)type;

- (void)segmentScrollToItemAtIndex:(NSUInteger)index;

@end
