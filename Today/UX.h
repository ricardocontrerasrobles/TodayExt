#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface UX : NSObject

@property (nonatomic, strong) UIView *theView;
@property (strong, nonatomic)  AVAudioPlayer *player;
// General UX
- (void) initNav:(UIViewController*)theSelf;
- (void) initNavLogo:(UIViewController*)target;
- (UIBarButtonItem*) makeBarButtonWithImage:(NSString*)imageST selector:(SEL)selector target:(id)target;
- (UIScrollView*) makeScrollHorizontalWithImgs:(NSArray*)imgsArr target:(UIViewController*)target contetnMode:(UIViewContentMode)contentMode;
-(UIButton*) makeButtonWithText:(NSString*)textST target:(id)target selector:(SEL)selector font:(UIFont*)font textColor:(UIColor*)textColor image:(NSString*)imageST background:(NSString*)backgroundST backgroundColor:(UIColor*)backgroundColor x:(int)x y:(int)y width:(int)width height:(int)height tag:(int)tag;
-(UIImageView*) makeImageViewWithImgae:(NSString*)imageST x:(int)x y:(int)y width:(int)width height:(int)height;
-(UITextField*) makeTextFieldWithPlaceholder:(NSString*)placeholderST tag:(int)tag font:(UIFont*)font backgroundImage:(NSString*)backgroundImage textColor:(UIColor*)textColor backgroundColor:(UIColor*)backgroundColor x:(int)x y:(int)y width:(int)width height:(int)height keyboard:(UIKeyboardType)keyboard capitalization:(UITextAutocapitalizationType)capitalization secure:(BOOL)secure;
-(UIAlertView*)makeAlertWithTitle:(NSString*)titleST message:(NSString*) messageST cancelTitle:(NSString*)cancelST target:(id)target;
-(void)addSingleTapToView:(UIView*)tapView tag:(int)tag target:(id)target selector:(SEL)selector;
-(BOOL)checkEmail:(NSString*)email;
-(UITableView*)makeTableViewWithTarget:(id)target tag:(int)tag backgroundColor:(UIColor*)backgroundColor separatorColor:(UIColor*)separatorColor x:(int)x y:(int)y width:(int)width height:(int)height;
- (UILabel*)makeLabelWithText:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor backgroundColor:(UIColor*)backgroundColor alignment:(NSTextAlignment)alingment x:(int)x y:(int)y width:(int)width height:(int)height;

- (void) playSound:(NSString*)soundST volume:(float)volume loops:(float)loops;

- (NSString*)codeToAmount:(NSString*)codeST offsetInt:(int)offsetInt length:(int)lengthInt;
- (NSString*)codeToAmountNoFormat:(NSString*)codeST offsetInt:(int)offsetInt length:(int)lengthInt;
- (UIActivityIndicatorView*)makeActivityIndicatorAnimating:(BOOL)animating x:(int)x y:(int)y;
- (UIView*) blockView:(UIViewController*)viewController targer:(id)target selector:(SEL)selector cancelBot:(BOOL)cancelBotBOOL;
- (void)fadeIn:(UIView*)view duration:(float)duration;
- (void)fadeOutAndDestroy:(UIView*)view duration:(float)duration;

// MoviePlayer UX
-(UIView*)setViewForMovieFullscreen;
-(MPMoviePlayerController*)setMoviePlayer:(NSString*)movieST viewForMovie:(UIView*)viewForMovie;
-(UIView*)makeViewWithColor:(UIColor*)color alpha:(float)alpha x:(int)x y:(int)y width:(int)width height:(int)height;

-(BOOL)iPhone5;
// Colors
@property (nonatomic, strong) UIColor *blueStrong;
@property (nonatomic, strong) UIColor *blueLight;
@property (nonatomic, strong) UIColor *green;
@property (nonatomic, strong) UIColor *grayLight;
@property (nonatomic, strong) UIColor *grayMid;
@property (nonatomic, strong) UIColor *grayTranslucent;
@property (nonatomic, strong) UIFont *fontRegular;
@property (nonatomic, strong) UIFont *fontRegularSmall;
@property (nonatomic, strong) UIFont *fontLight;
@property (nonatomic, strong) UIFont *fontLightSmall;
@property (nonatomic, strong) UIFont *fontItalicSmall;
@property (nonatomic, strong) UIFont *fontLightBig;


@end
