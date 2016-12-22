//
//  IDMTutorialOverlayView.m
//  PhotoBrowserDemo
//
//  Created by Lukas Zielinski on 22/12/2016.
//
//

#import "IDMTutorialOverlayView.h"

@interface IDMTutorialOverlayView () {
    UIImageView *_imageView;
    BOOL _appearedOnce;
}
@end

@implementation IDMTutorialOverlayView

- (void)layoutSubviews {
    [super layoutSubviews];
    [NSTimer scheduledTimerWithTimeInterval:0.15f target:self selector:@selector(showImageView) userInfo:nil repeats:NO];
}

- (void)showImageView
{
    if (_appearedOnce) {
        return;
    }
    
    if (_imageView != nil) {
        [_imageView removeFromSuperview];
        _imageView = nil;
    }
    
    _appearedOnce = YES;
    
    CGPoint center = CGPointMake(self.frame.size.width  / 2, self.frame.size.height / 2);
    CGRect frame = CGRectMake(0, 0, 100, 100);
    UIImage *image = [UIImage imageNamed:@"IDMPhotoBrowser.bundle/images/pinch_gesture.png"];
    
    _imageView = [[UIImageView alloc] initWithFrame:frame];
    _imageView.image = image;
    _imageView.center = center;
    _imageView.backgroundColor = [UIColor whiteColor];
    _imageView.layer.cornerRadius = 5;
    _imageView.layer.borderColor = [[UIColor blackColor] CGColor];
    _imageView.layer.borderWidth = 1.0f;
    _imageView.alpha = 0;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:_imageView];
    
    [UIView animateWithDuration:0.3f animations:^{
        _imageView.alpha = 0.75;
    }];

    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(discard) userInfo:nil repeats:NO];
}

- (void)discard
{
    [UIView animateWithDuration:0.3f animations:^{
        _imageView.alpha = 0;
    } completion:^(BOOL finished) {
        [_imageView removeFromSuperview];
        _imageView = nil;
        [self removeFromSuperview];
    }];
}


@end
