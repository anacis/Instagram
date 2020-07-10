//
//  DetailsViewController.m
//  Instagram
//
//  Created by Ana Cismaru on 7/7/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import "DetailsViewController.h"
@import Parse;

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpPage];
}

- (void)setUpPage {
    self.captionLabel.text = self.post[@"caption"];
    self.postImageView.file = self.post[@"image"];
    [self.postImageView loadInBackground];
    
    self.likeCountLabel.text = [self.post.likeCount stringValue];
    
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
    
    //TODO: format Date nicely
    self.timestampLabel.text = self.post[@"postedAt"] ;
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
    
    self.likeCountLabel.text = [self.post.likeCount stringValue];
   
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];

    // Retrieve the object by id
    [query getObjectInBackgroundWithId:self.post.objectId
                                 block:^(PFObject *post, NSError *error) {
        NSLog(@"Updated database");
        post[@"likeCount"] = self.post.likeCount;
        post[@"likedBy"] = self.post.likedBy;
        [post saveInBackground];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
