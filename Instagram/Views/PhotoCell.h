//
//  PhotoCell.h
//  Instagram
//
//  Created by Ana Cismaru on 7/6/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Parse;
NS_ASSUME_NONNULL_BEGIN

@interface PhotoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet PFImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@end

NS_ASSUME_NONNULL_END
