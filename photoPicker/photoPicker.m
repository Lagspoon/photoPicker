//
//  photoPicker.m
//  photoPicker
//
//  Created by Olivier Delecueillerie on 07/11/2013.
//  Copyright (c) 2013 Olivier Delecueillerie. All rights reserved.
//

#import "photoPicker.h"

@interface photoPicker ()

@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@end

@implementation photoPicker

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//LAZY INSTANCIATION
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

- (BOOL) camera {
    if (!_camera) _camera = YES;
    return _camera;
}

- (UIImagePickerController *) imagePickerController {
    if (!_imagePickerController) {

        UIImagePickerController *IPController = [[UIImagePickerController alloc] init];
        IPController.modalPresentationStyle = UIModalPresentationCurrentContext;
        IPController.delegate = (id)self;

        if (self.camera) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                IPController.sourceType = UIImagePickerControllerSourceTypeCamera;
            } else {
#warning check the Localization file
                UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                                      message:NSLocalizedString(@"Device has no camera",nil)
                                                                     delegate:nil
                                                            cancelButtonTitle:@"OK"
                                                            otherButtonTitles: nil];
                [myAlertView show];

            }

        } else {
            IPController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

        }
        //The user wants to use the camera interface.
        IPController.showsCameraControls = YES;
        
        _imagePickerController = IPController;
    }
    return _imagePickerController;
}

- (id) delegateViewController {
    //in case no delegate is defined, for example to test this app on device, it is useful to define self as is own delegate
    if (!_delegateViewController) _delegateViewController = (id) self;
    return _delegateViewController;
}

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//OVERRIDEN METHOD
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

- (id) initWithCamera:(BOOL) camera {
    self = [super init];
    if (self) self.camera = camera;
    return self;
}

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//TRIGGERED ACTION
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

- (void) takePicture {
    [self.delegateViewController presentViewController:self.imagePickerController animated:YES completion:nil];
}

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//IMAGE PICKER DELEGATE
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////


// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.delegateViewController.dataImageCaptured = [[NSData alloc] initWithData:UIImagePNGRepresentation(image)];
    [self.delegateViewController didFinishPickingMedia];
    [self.delegateViewController dismissViewControllerAnimated:YES completion:NULL];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.delegateViewController dismissViewControllerAnimated:YES completion:NULL];
}

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//PHOTOPICKER DELEGATE
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
    


@end
