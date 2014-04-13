//
//  photoPicker.h
//  photoPicker
//
//  Created by Olivier Delecueillerie on 07/11/2013.
//  Copyright (c) 2013 Olivier Delecueillerie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol photoPickerDelegate <NSObject>
@optional
//the picture captured.
@property (strong, nonatomic) NSData *dataImageCaptured;
- (void) didFinishPickingMedia;
@end

@interface photoPicker : NSObject <UIImagePickerControllerDelegate, photoPickerDelegate>
//display the camera or the photo picker 
@property (nonatomic) BOOL camera;
@property (weak, nonatomic) UIViewController <photoPickerDelegate> *delegateViewController;

- (id) initWithCamera:(BOOL) camera;
- (void) takePicture;

@end
