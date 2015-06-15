//
//  ClickableImageView.m
//  
//
//  Created by BooleanMac on 15/6/15.
//
//

#import "ClickableImageView.h"

@implementation ClickableImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithUrl:(NSString *)url{
    self = [super init];
    if (self) {
        self.url = url;
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewOnClick:)]];
    }
    return self;
}

-(void)imageViewOnClick:(UIGestureRecognizer *)obj{
    ClickableImageView *img = (ClickableImageView *)obj.view;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:img.url]];
}


@end