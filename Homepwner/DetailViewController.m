//
//  DetailViewController.m
//  Homepwner
//
//  Created by Ryan Gallagher on 5/4/13.
//  Copyright (c) 2013 Ryan Gallagher. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [nameField setText:[_item itemName]];
    [serialNumberField setText:[_item serialNumber]];
    [valueField setText:[NSString stringWithFormat:@"%d",[_item valueInDollars]]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateLabel setText:[dateFormatter stringFromDate:[_item dateCreated]]];
    
    NSString *imageKey = [_item imageKey];
    
    if (imageKey) {
        UIImage *imageToDisplay = [[BNRImageStore sharedStore]imageForKey:imageKey];
        [imageview setImage:imageToDisplay];
    }else{
        [imageview setImage:nil];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}


- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[self view]endEditing:YES];
    
    //save
    [_item setItemName:[nameField text]];
    [_item setSerialNumber:[serialNumberField text]];
    [_item setValueInDollars:[[valueField text] intValue]];
}


- (void)setItem:(BNRItem *)i
{
    _item = i;
    [[self navigationItem] setTitle:[_item itemName]];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [imagePicker setDelegate:self];
    
    //place image on screen
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *oldKey = [_item imageKey];
    if (oldKey){
        [[BNRImageStore sharedStore]deleteImageForKey:oldKey];
    }
    
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //create UUID
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    
    NSString *key = (__bridge NSString *)newUniqueIDString;
    [_item setImageKey:key];
    
    [[BNRImageStore sharedStore] setImage:image forKey:[_item imageKey]];
    [imageview setImage: image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
