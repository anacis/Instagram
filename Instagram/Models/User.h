//
//  User.h
//  Instagram
//
//  Created by Ana Cismaru on 7/8/20.
//  Copyright © 2020 anacismaru. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : PFUser

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image;

@end

NS_ASSUME_NONNULL_END
