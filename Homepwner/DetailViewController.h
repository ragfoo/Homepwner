//
//  DetailViewController.h
//  Homepwner
//
//  Created by Ryan Gallagher on 5/4/13.
//  Copyright (c) 2013 Ryan Gallagher. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface DetailViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate,UIPopoverControllerDelegate>
{
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *serialNumberField;
    __weak IBOutlet UITextField *valueField;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UIImageView *imageview;
    
    UIPopoverController *imagePickerPopover;
}



- (IBAction)takePicture:(id)sender;
- (IBAction)backgroundTapped:(id)sender;
- (id)initForNewItem:(BOOL)isNew;

@property (nonatomic,strong) BNRItem *item;
@property (nonatomic,copy) void (^dismissBlock)(void);

@end
