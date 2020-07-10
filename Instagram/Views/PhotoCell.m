//
//  PhotoCell.m
//  Instagram
//
//  Created by Ana Cismaru on 7/6/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import "PhotoCell.h"
#import "DateTools.h"

@implementation PhotoCell


- (void)awakeFromNib {
    [super awakeFromNib];
     UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profilePic addGestureRecognizer:profileTapGestureRecognizer];
    [self.usernameLabel addGestureRecognizer:profileTapGestureRecognizer];
    [self.usernameLabel setUserInteractionEnabled:YES];
    [self.profilePic setUserInteractionEnabled:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpCell {
    NSLog(@"Setting up cell");
    self.captionLabel.text = self.post[@"caption"];
    self.postImageView.file = self.post[@"image"];
    [self.postImageView loadInBackground];
    
    PFUser *user = self.post[@"author"];
    if (user != nil) {
        // User found! update username label with username
        self.usernameLabel.text = user.username;
        self.profilePic.layer.cornerRadius = self.profilePic.frame.size.height / 2;
        self.profilePic.file = user[@"profilePic"];
        [self.profilePic loadInBackground];
    } else {
        // No user found, set default username
        self.usernameLabel.text = @"🤖";
    }
    
    if ([self.post.likedBy containsObject: [PFUser currentUser].objectId]) {
        UIImage *img = [UIImage systemImageNamed:@"heart.fill"];
        [self.likeButton setImage:img forState:UIControlStateNormal];
         NSLog(@"Object is liked: %@", self.post.likedBy);
    }
    else {
        UIImage *img = [UIImage systemImageNamed:@"heart"];
        [self.likeButton setImage:img forState:UIControlStateNormal];
         NSLog(@"object is unliked: %@", self.post.likedBy);
    }
    
    // Convert Date to String
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"M/dd/yy, h:mm a";
    NSDate *date = [formatter dateFromString:self.post.postedAt];
    self.timeAgoLabel.text = [date shortTimeAgoSinceNow];
}

- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    [self.delegate photoCell:self didTap:self.post.author];
}

- (IBAction)didTapLike:(id)sender {
    if (![self.post.likedBy containsObject: [PFUser currentUser].objectId]) {
        UIImage *img = [UIImage systemImageNamed:@"heart.fill"];
        [self.likeButton setImage:img forState:UIControlStateNormal];
        int value = [self.post.likeCount intValue];
        self.post.likeCount = [NSNumber numberWithInt:value + 1];
        [self.post.likedBy addObject:[PFUser currentUser].objectId];
         NSLog(@"Liked object: %@", self.post.likedBy);
    }
    else {
        UIImage *img = [UIImage systemImageNamed:@"heart"];
        [self.likeButton setImage:img forState:UIControlStateNormal];
        int value = [self.post.likeCount intValue];
        if (value > 0) {
            self.post.likeCount = [NSNumber numberWithInt:value - 1];
        }
        [self.post.likedBy removeObject:[PFUser currentUser].objectId];
         NSLog(@"Unliked object: %@", self.post.likedBy);
    }
    
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query getObjectInBackgroundWithId:self.post.objectId
                                 block:^(PFObject *post, NSError *error) {
        NSLog(@"Updated database");
        post[@"likeCount"] = self.post.likeCount;
        post[@"likedBy"] = self.post.likedBy;
        [post saveInBackground];
    }];
}

@end
