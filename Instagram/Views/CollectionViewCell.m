//
//  CollectionViewCell.m
//  Instagram
//
//  Created by Ana Cismaru on 7/7/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import "CollectionViewCell.h"
@import Parse;

@implementation CollectionViewCell

- (void)setUpCell {
    self.postImageView.file = self.post[@"image"];
    [self.postImageView loadInBackground];
}

@end
