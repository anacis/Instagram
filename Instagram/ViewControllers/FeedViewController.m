//
//  FeedViewController.m
//  Instagram
//
//  Created by Ana Cismaru on 7/6/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import "FeedViewController.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "PhotoCell.h"
#import "DetailsViewController.h"
#import "ProfileViewController.h"


@interface FeedViewController () <UITableViewDelegate, UITableViewDataSource, PhotoCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self getPosts];
    //[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(getPosts) userInfo:nil repeats:true];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
}

- (IBAction)logout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"User is logged out");
            SceneDelegate *myDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
            myDelegate.window.rootViewController = loginViewController;
        }
        else {
            NSLog(@"Error logging out: %@", error.localizedDescription);
        }
    }];
    
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCell"];
    cell.post = self.posts[indexPath.row];
    cell.delegate = self;
    [cell setUpCell];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (void)getPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = posts;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self getPosts];
    [refreshControl endRefreshing];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"detailsSegue"]) {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post *post = self.posts[indexPath.row];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.post = post;
    }
    else if ([[segue identifier] isEqualToString:@"profileSegue"]) {
        NSLog(@"Going to Profile Page");
         ProfileViewController *profileController = [segue destinationViewController];
        profileController.user = sender;
    }
    
}


- (void)photoCell:(nonnull PhotoCell *)photoCell didTap:(nonnull PFUser *)user {
    [self performSegueWithIdentifier:@"profileSegue" sender:user];
}

@end
