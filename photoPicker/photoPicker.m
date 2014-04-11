//
//  photoPicker.m
//  photoPicker
//
//  Created by Olivier Delecueillerie on 07/11/2013.
//  Copyright (c) 2013 Olivier Delecueillerie. All rights reserved.
//

#import "photoPicker.h"

@interface photoPicker ()
@property (weak, nonatomic) IBOutlet UIButton *buttonCamera;

@property (nonatomic) UIImagePickerController *imagePickerController;

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

        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
        imagePickerController.delegate = (id)self;

        if (self.camera) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
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
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

        }
        //The user wants to use the camera interface.
        imagePickerController.showsCameraControls = YES;
        
        _imagePickerController = imagePickerController;
    }
    return _imagePickerController;
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
//VIEW LIFECYCLE
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.camera) {
        [self.buttonCamera setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    }
    else {
        [self.buttonCamera setImage:[UIImage imageNamed:@"directory"] forState:UIControlStateNormal];
    }

}

////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////
//TRIGGERED ACTION
////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

- (IBAction)takePicture:(id)sender {
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
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
    self.delegate.dataImageCaptured = UIImagePNGRepresentation(image);
    [self.delegate didFinishPickingMedia];
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
    
    

@end
