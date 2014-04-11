//
//  PHCameraVC.h
//  photoPicker
//
//  Created by Olivier Delecueillerie on 07/11/2013.
//  Copyright (c) 2013 Olivier Delecueillerie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHCameraVC : UIViewController <UIImagePickerControllerDelegate>
//display the camera or the photo picker 
@property (nonatomic) BOOL camera;

//the picture captured.
@property (nonatomic) NSData *capturedImage;

@end
