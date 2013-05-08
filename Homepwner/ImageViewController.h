//
//  ImageViewController.h
//  Homepwner
//
//  Created by Ryan Gallagher on 5/8/13.
//  Copyright (c) 2013 Ryan Gallagher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController
{
    
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UIScrollView *scrollView;

}
@property (nonatomic, strong) UIImage *image;
@end
