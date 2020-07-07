//
//  DetailsViewController.h
//  Instagram
//
//  Created by Ana Cismaru on 7/7/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import "ViewController.h"
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : ViewController
@property (strong, nonatomic) Post *post;
@end

NS_ASSUME_NONNULL_END
