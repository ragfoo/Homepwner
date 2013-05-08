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
#import "BNRItemStore.h"

@implementation DetailViewController
@synthesize dismissBlock;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"use initForNewItem" userInfo:nil];
    return nil;
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
    UIColor *clr = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom]== UIUserInterfaceIdiomPad){
        clr=[UIColor colorWithRed:.875 green:.88 blue:.91 alpha:1];
    }else {
        clr =[UIColor groupTableViewBackgroundColor];
    }
    [[self view]setBackgroundColor:clr];
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
    if ([imagePickerPopover isPopoverVisible]) {
        [imagePickerPopover dismissPopoverAnimated:YES];
        imagePickerPopover = nil;
        return;
    }
    
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [imagePicker setDelegate:self];
    
    //place image on screen
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad){
        imagePickerPopover = [[UIPopoverController alloc]initWithContentViewController:imagePicker];
        
        [imagePickerPopover setDelegate:self];
        
        [imagePickerPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }else{
        [self presentViewController:imagePicker animated:YES completion:nil];
    
    }
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
    
    [_item setThumbnailDataFromImage:image];
    
    //create UUID
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    
    NSString *key = (__bridge NSString *)newUniqueIDString;
    [_item setImageKey:key];
    
    [[BNRImageStore sharedStore] setImage:image forKey:[_item imageKey]];
    [imageview setImage: image];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [imagePickerPopover dismissPopoverAnimated:YES];
        imagePickerPopover = nil;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)io
{
    if ([[UIDevice currentDevice]userInterfaceIdiom]== UIUserInterfaceIdiomPad){
        return YES;
    }else {
        return (io == UIInterfaceOrientationPortrait);
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    NSLog(@"user dismissed popover");
    imagePickerPopover  = nil;
}

- (id) initForNewItem:(BOOL)isNew{
    self = [super initWithNibName:@"DetailViewController" bundle:nil];
    
    if(self){
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            [[self navigationItem] setRightBarButtonItem:doneItem];
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            [[self navigationItem] setLeftBarButtonItem:cancelItem];
        }
    }
    return self;
}

- (void)save:(id)sender{
    [[self presentingViewController]dismissViewControllerAnimated:YES completion:dismissBlock];
}

- (void)cancel:(id)sender{
    [[BNRItemStore sharedStore]removeItem:_item];
    
    [[self presentingViewController]dismissViewControllerAnimated:YES completion:dismissBlock];
}
@end
