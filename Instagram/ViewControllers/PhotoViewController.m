//
//  PhotoViewController.m
//  Instagram
//
//  Created by Ana Cismaru on 7/6/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import "PhotoViewController.h"
#import "Post.h"
#import "MBProgressHUD.h"

@interface PhotoViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textField;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.delegate = self;
    
}

- (IBAction)cancel:(id)sender {
    [self.tabBarController setSelectedIndex:0];
    [self.textField endEditing:YES];
    self.textField.text = @"Write your caption here!";
    self.textField.textColor = UIColor.opaqueSeparatorColor;
    
}

- (IBAction)share:(id)sender {
    // Display HUD right before the request is made
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Post postUserImage:self.imageView.image withCaption:self.textField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (succeeded) {
            NSLog(@"Posted image successfully!");
            [self.textField endEditing:YES];
            self.textField.text = @"Write your caption here!";
            self.textField.textColor = UIColor.opaqueSeparatorColor;
            self.imageView.image = [UIImage imageNamed: @"image_placeholder.png"];
        }
        else {
           NSLog(@"Error: %@", error.localizedDescription);
        }
        [self.tabBarController setSelectedIndex:0];
    }];
    
    
}

- (IBAction)onTapImage:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    //UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    UIImage *resizedImage = [self resizeImage:originalImage withSize:CGSizeMake(300, 300)];
    self.imageView.image = resizedImage;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.text = @"";
    textView.textColor = UIColor.blackColor;
}

- (IBAction)dismissKeyboard:(id)sender {
    [self.textField endEditing:YES];
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
