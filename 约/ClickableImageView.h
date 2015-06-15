//
//  ClickableImageView.h
//  
//
//  Created by BooleanMac on 15/6/15.
//
//

#import <UIKit/UIKit.h>

@interface ClickableImageView : UIImageView<UIGestureRecognizerDelegate>
@property (strong, nonatomic) NSString *url;

- (instancetype)initWithUrl:(NSString *)url;
@end
