//
//  CollectionViewCell.h
//  Instagram
//
//  Created by Ana Cismaru on 7/7/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;


- (void)setUpCell;

@end

NS_ASSUME_NONNULL_END
