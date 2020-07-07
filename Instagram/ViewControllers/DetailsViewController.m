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
    
    //TODO: format Date nicely
    self.timestampLabel.text = self.post[@"postedAt"] ;
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
