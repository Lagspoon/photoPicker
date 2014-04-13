//
//  photoPickerViewController.m
//  photoPicker
//
//  Created by Olivier Delecueillerie on 12/04/2014.
//  Copyright (c) 2014 Olivier Delecueillerie. All rights reserved.
//

#import "photoPickerViewController.h"

@interface photoPickerViewController ()

@property (weak, nonatomic) IBOutlet UIButton *buttonCamera;
@property (strong, nonatomic) photoPicker *photoPicker;
@end

@implementation photoPickerViewController

- (photoPicker *) photoPicker {
    if (!_photoPicker) {
        _photoPicker = [[photoPicker alloc] initWithCamera:YES];
        _photoPicker.delegateViewController=self;
    }
    return _photoPicker;
}

- (NSData *) dataImageCaptured {
    if (!_dataImageCaptured) _dataImageCaptured = [[NSData alloc] init];
    return _dataImageCaptured;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.photoPicker.camera) {
        [self.buttonCamera setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    }
    else {
        [self.buttonCamera setImage:[UIImage imageNamed:@"directory"] forState:UIControlStateNormal];
    }}


- (IBAction)buttonAction:(id)sender {
    [self.photoPicker takePicture];
}

- (void) didFinishPickingMedia {

}
@end
