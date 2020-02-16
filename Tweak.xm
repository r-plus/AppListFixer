#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// {{{ fix initial crash
@interface SBIconModel : NSObject
@end

@interface SBIconController : NSObject
@property(retain, nonatomic) SBIconModel *model;
+ (SBIconController *)sharedInstance;
@end

%hook SBIconModel
%new
+ (SBIconModel *)sharedInstance
{
    return [%c(SBIconController) sharedInstance].model;
}
%end
// }}}

// {{{ fix next crash

// https://iphonedevwiki.net/index.php/Updating_extensions_for_iOS_13

struct SBIconImageInfo {
    CGSize size;
    CGFloat scale;
    CGFloat continuousCornerRadius;
};

@interface SBIcon
- (UIImage *)iconImageWithInfo:(SBIconImageInfo)arg1;
@end

%hook SBIcon
%new
- (UIImage *)icon
{
    CGSize imageSize = CGSizeMake(60, 60);

    struct SBIconImageInfo imageInfo;
    imageInfo.size  = imageSize;
    imageInfo.scale = [UIScreen mainScreen].scale;
    imageInfo.continuousCornerRadius = 12;

    return [self iconImageWithInfo:imageInfo];
}
%end
// }}}
