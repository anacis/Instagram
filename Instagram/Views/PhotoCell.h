//
//  PhotoCell.h
//  Instagram
//
//  Created by Ana Cismaru on 7/6/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Parse;
#import "Post.h"
NS_ASSUME_NONNULL_BEGIN

@protocol PhotoCellDelegate;

@interface PhotoCell : UITableViewCell
@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *timeAgoLabel;
@property (nonatomic, weak) id<PhotoCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;


- (void)setUpCell;

@end

@protocol PhotoCellDelegate
- (void)photoCell:(PhotoCell *) photoCell didTap: (PFUser *)user;
@end




NS_ASSUME_NONNULL_END
