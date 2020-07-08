//
//  PhotoCell.m
//  Instagram
//
//  Created by Ana Cismaru on 7/6/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //self.profilePic.layer.masksToBounds = true;
    //self.profilePic.layer.cornerRadius = self.profilePic.frame.height/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpCell {
    self.captionLabel.text = self.post[@"caption"];
    self.postImageView.file = self.post[@"image"];
    [self.postImageView loadInBackground];
    
    PFUser *user = self.post[@"author"];
    if (user != nil) {
        // User found! update username label with username
        self.usernameLabel.text = user.username;
        self.profilePic.file = user[@"profilePic"];
        [self.profilePic loadInBackground];
    } else {
        // No user found, set default username
        self.usernameLabel.text = @"🤖";
    }
}

@end
