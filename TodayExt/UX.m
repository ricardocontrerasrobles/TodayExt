#import "UX.h"

#define SCREEN_SIZE         [[UIScreen mainScreen] bounds].size.height
#define IS_IPHONE_5         ( SCREEN_SIZE > 480.0f )

@implementation UX
@synthesize theView;
@synthesize player;
@synthesize blueStrong;
@synthesize blueLight;
@synthesize green;
@synthesize grayTranslucent;
@synthesize fontRegular, fontRegularSmall, fontLight, fontLightSmall, fontItalicSmall, fontLightBig, grayLight, grayMid;
#pragma mark General UX

// Inicializar colores y fonts
- (id)init {
    blueStrong =        [UIColor colorWithRed:  21.0/255 green:  37.0/255 blue:  87.0/255 alpha:1.00];
    blueLight =         [UIColor colorWithRed:  64.0/255 green: 112.0/255 blue: 252.0/255 alpha:1.00];
    green =             [UIColor colorWithRed: 113.0/255 green: 191.0/255 blue:  68.0/255 alpha:1.00];
    grayTranslucent =   [UIColor colorWithRed:  10.0/255 green:  10.0/255 blue:  10.0/255 alpha:0.86];
    grayLight =         [UIColor colorWithRed: 236.0/255 green: 236.0/255 blue: 236.0/255 alpha:1.00];
    grayMid =           [UIColor colorWithRed: 158.0/255 green: 158.0/255 blue: 158.0/255 alpha:1.00];
    fontRegular =       [UIFont fontWithName:@"Ubuntu" size:16];
    fontRegularSmall =  [UIFont fontWithName:@"Ubuntu" size:11];
    fontLight =         [UIFont fontWithName:@"Ubuntu-Light" size:14];
    fontLightSmall =    [UIFont fontWithName:@"Ubuntu-Light" size:11];
    fontLightBig =      [UIFont fontWithName:@"Ubuntu-Light" size:20];
    fontItalicSmall =   [UIFont fontWithName:@"Ubuntu-Italic" size:13];
    return  self;
}

// Funcion para ver si es iPhone alargado o corto
-(BOOL)iPhone5 {
    if (IS_IPHONE_5) {
        return YES;
    } else {
        return NO;
    }
}


- (void) initNav:(UIViewController*)target {
    if ([target respondsToSelector:@selector(edgesForExtendedLayout)]) {
        target.edgesForExtendedLayout = UIRectEdgeNone;
    }
    target.navigationController.navigationBar.tintColor = self.blueLight;
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title =@"";
    target.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    target.navigationController.navigationBar.translucent = NO;
    target.view.backgroundColor = [UIColor whiteColor];
    
    //target.navigationItem.rightBarButtonItem = [self makeBarButtonWithImage:@"topBtn.png" selector:nil target:target];
}

- (void) initNavLogo:(UIViewController*)target {
    if ([target respondsToSelector:@selector(edgesForExtendedLayout)]) {
        target.edgesForExtendedLayout = UIRectEdgeNone;
    }
    target.navigationController.navigationBar.tintColor = self.blueLight;
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title =@"";
    target.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    target.navigationController.navigationBar.translucent = NO;
    target.view.backgroundColor = [UIColor whiteColor];
    
    
    target.title = @"";
    UIImageView *imageNav = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"logoNav.png"]];
    imageNav.frame = CGRectMake(0, 0, 320, 44);
    imageNav.contentMode = UIViewContentModeCenter;
    [target.navigationController.navigationBar addSubview:imageNav];
    
    
}

-(UIView*)makeViewWithColor:(UIColor*)color alpha:(float)alpha x:(int)x y:(int)y width:(int)width height:(int)height {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    view.backgroundColor = color;
    view.alpha = alpha;
    return view;
}

- (UIBarButtonItem*) makeBarButtonWithImage:(NSString*)imageST selector:(SEL)selector target:(id)target {
    UIImage *image = [UIImage imageNamed:imageST];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake( 0, 0, 35, 35);
    [button setImage:image forState:UIControlStateNormal];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
  
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return barButtonItem;
}

- (UILabel*)makeLabelWithText:(NSString*)text font:(UIFont*)font textColor:(UIColor*)textColor backgroundColor:(UIColor*)backgroundColor alignment:(NSTextAlignment)alingment x:(int)x y:(int)y width:(int)width height:(int)height {
    UILabel *lb = [[UILabel alloc] init];
    lb.frame = CGRectMake(x, y, width, height);
    lb.backgroundColor = backgroundColor;
    lb.textColor = textColor;
    lb.font = font;
    lb.textAlignment = alingment;
    lb.text = text;
    return lb;
}

- (UIScrollView*) makeScrollHorizontalWithImgs:(NSArray*)imgsArr target:(UIViewController*)target contetnMode:(UIViewContentMode)contentMode {
    
    //int realHeight = target.view.frame.size.height - target.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height;
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, target.view.frame.size.width, target.view.frame.size.height)];
    scroll.backgroundColor = [UIColor clearColor];
    scroll.contentSize = CGSizeMake(target.view.frame.size.width * imgsArr.count, target.view.frame.size.height);
    scroll.pagingEnabled = YES;
    
    for (int i = 0; i < imgsArr.count; i++) {
        //UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, realHeight * i, target.view.frame.size.width, realHeight)];
        //iv.image = [UIImage imageNamed:imgsArr[i]];
        //iv.contentMode = contentMode;
        UIButton *iv = [[UIButton alloc]initWithFrame:CGRectMake(target.view.frame.size.width * i, 0, target.view.frame.size.width, target.view.frame.size.height)];
        [iv setImage:[UIImage imageNamed:imgsArr[i]] forState:UIControlStateNormal];
        iv.imageView.contentMode = contentMode;
        [scroll addSubview:iv];
    }
    return scroll;
}

-(UIButton*) makeButtonWithText:(NSString*)textST target:(id)target selector:(SEL)selector font:(UIFont*)font textColor:(UIColor*)textColor image:(NSString*)imageST background:(NSString*)backgroundST backgroundColor:(UIColor*)backgroundColor x:(int)x y:(int)y width:(int)width height:(int)height tag:(int)tag {
    
    // Create button and add set frame
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(x, y, width, height);
    
    // Add other atributes if they where added.
    if (textST) {
        [button setTitle:textST forState:UIControlStateNormal];
    }
    if (font) {
        button.titleLabel.font = font;
    }
    if (textColor) {
        [button setTitleColor:textColor forState:UIControlStateNormal];
    }
    if (imageST) {
        UIImage *image = [UIImage imageNamed:imageST];
        [button setImage:image forState:UIControlStateNormal];
    }
    if (backgroundST) {
        UIImage *image = [UIImage imageNamed:backgroundST];
        [button setBackgroundImage:image forState:UIControlStateNormal];
    }
    if (backgroundColor) {
        button.backgroundColor = backgroundColor;
    }
    if (tag) {
        button.tag = tag;
    }
    
    // Add target and selector
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    // Return created button
    return button;
}

-(UIImageView*) makeImageViewWithImgae:(NSString*)imageST x:(int)x y:(int)y width:(int)width height:(int)height {
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    iv.image = [UIImage imageNamed:imageST];
    return iv;
}

-(UITextField*) makeTextFieldWithPlaceholder:(NSString*)placeholderST tag:(int)tag font:(UIFont*)font backgroundImage:(NSString*)backgroundImage textColor:(UIColor*)textColor backgroundColor:(UIColor*)backgroundColor x:(int)x y:(int)y width:(int)width height:(int)height keyboard:(UIKeyboardType)keyboard capitalization:(UITextAutocapitalizationType)capitalization secure:(BOOL)secure {
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(x,y,width,height)];
    if (backgroundImage) {
        tf.background = [UIImage imageNamed:backgroundImage];
    }
    [tf setKeyboardType:keyboard];
    tf.autocapitalizationType = capitalization;
    [tf setSecureTextEntry:secure];
    tf.font = font;
    tf.tag = tag;
    tf.textColor = textColor;
    tf.backgroundColor = backgroundColor;
    tf.placeholder = placeholderST;
    [tf setValue:textColor forKeyPath:@"_placeholderLabel.textColor"];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, height)];
    tf.leftView = paddingView;
    tf.leftViewMode = UITextFieldViewModeAlways;
    return tf;
}



-(void)addSingleTapToView:(UIView*)tapView tag:(int)tag target:(id)target selector:(SEL)selector {
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    tapView.tag = tag;
    [singleTapGestureRecognizer setNumberOfTapsRequired:1];
    [tapView addGestureRecognizer:singleTapGestureRecognizer];
}

-(BOOL)checkEmail:(NSString*)email {
	
	if( (0 != [email rangeOfString:@"@"].length) &&  (0 != [email rangeOfString:@"."].length) )
	{
		NSMutableCharacterSet *invalidCharSet = [[[NSCharacterSet alphanumericCharacterSet] invertedSet]mutableCopy];
		[invalidCharSet removeCharactersInString:@"_-"];
		
		NSRange range1 = [email rangeOfString:@"@" options:NSCaseInsensitiveSearch];
		
		
		NSString *usernamePart = [email substringToIndex:range1.location];
		NSArray *stringsArray1 = [usernamePart componentsSeparatedByString:@"."];
		for (NSString *string in stringsArray1) {
			NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet: invalidCharSet];
			if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
				return NO;
		}
		
		NSString *domainPart = [email substringFromIndex:range1.location+1];
		NSArray *stringsArray2 = [domainPart componentsSeparatedByString:@"."];
		
		for (NSString *string in stringsArray2) {
			NSRange rangeOfInavlidChars=[string rangeOfCharacterFromSet:invalidCharSet];
			if(rangeOfInavlidChars.length !=0 || [string isEqualToString:@""])
				return NO;
		}
		
		return YES;
	}
	else
		return NO;
}

- (void) playSound:(NSString*)soundST volume:(float)volume loops:(float)loops {
    // Make sound
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], soundST]];
    
    NSError *error;
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    player.numberOfLoops = loops;
    player.volume = volume;
    [player prepareToPlay];
    
    if (player) {
        [player play];
    }
}

- (NSString*)codeToAmount:(NSString*)codeST offsetInt:(int)offsetInt length:(int)lengthInt {
    
    NSString *amountST = [codeST substringFromIndex:MAX((int)[codeST length]-(lengthInt+offsetInt), 0)];
    amountST = [amountST substringToIndex:lengthInt];
    
    NSNumberFormatter *currencyStyle = [[NSNumberFormatter alloc] init];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_MX"];
    [currencyStyle setLocale:locale];

    // set options.
    [currencyStyle setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [currencyStyle setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    NSNumber *amount = [NSNumber numberWithInteger:[amountST intValue]];
    
    // get formatted string
    NSString* formatedST = [currencyStyle stringFromNumber:amount];
    return formatedST;
}



- (NSString*)codeToAmountNoFormat:(NSString*)codeST offsetInt:(int)offsetInt length:(int)lengthInt {
    NSString *amountST = [codeST substringFromIndex:MAX((int)[codeST length]-(lengthInt+offsetInt), 0)];
    amountST = [amountST substringToIndex:lengthInt];
    
    int amountInt = [amountST intValue];
    amountST = [NSString stringWithFormat:@"%i", amountInt];

    //NSNumberFormatter *currencyStyle = [[NSNumberFormatter alloc] init];
    
    // set options.
    //[currencyStyle setFormatterBehavior:NSNumberFormatterBehavior10_4];
    //[currencyStyle setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    //NSNumber *amount = [NSNumber numberWithInteger:[amountST intValue]];
    
    // get formatted string
    //NSString* formatedST = [currencyStyle stringFromNumber:amount];
    return amountST;
}

- (UIActivityIndicatorView*)makeActivityIndicatorAnimating:(BOOL)animating x:(int)x y:(int)y {
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = CGPointMake(x, y);
    
    if (animating) {
        [activityIndicator startAnimating];
    }
    return activityIndicator;
}

-(UIView*) blockView:(UIViewController*)viewController targer:(id)target selector:(SEL)selector cancelBot:(BOOL)cancelBotBOOL {
    
    UIView *blockView = [self makeViewWithColor:self.grayTranslucent alpha:0.0 x:0 y:0 width:viewController.view.frame.size.width height:viewController.view.frame.size.height];
    
    [blockView addSubview:[self makeActivityIndicatorAnimating:YES x:viewController.view.frame.size.width / 2 y:170]];

    
    UILabel *lb = [self makeLabelWithText:@"Cargando..." font:[UIFont systemFontOfSize:15] textColor:[UIColor whiteColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter x:55 y:110 width:210 height:40];
    [blockView addSubview:lb];
    
    if (cancelBotBOOL) {
        UIButton *cancelBTN = [self makeButtonWithText:@"Cancelar" target:target selector:selector font:[UIFont systemFontOfSize:15] textColor:[UIColor grayColor] image:nil background:nil backgroundColor:[UIColor colorWithRed: 50.0/255 green: 50.0/255 blue: 50.0/255 alpha:1.0] x:55 y:200 width:viewController.view.frame.size.width-110 height:40 tag:1];
        [blockView addSubview:cancelBTN];
    }
    
    blockView.alpha = 0;
    [viewController.view addSubview:blockView];
    
    return blockView;

}

- (void)fadeIn:(UIView*)view duration:(float)duration {
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         view.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                         //
                     }];
}

- (void)fadeOutAndDestroy:(UIView*)view duration:(float)duration {
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^ {
                         view.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         [view removeFromSuperview];
                     }];
    
}




#pragma mark MoviePlayer UX



-(MPMoviePlayerController*)setMoviePlayer:(NSString*)movieST viewForMovie:(UIView*)viewForMovie {
    theView = viewForMovie;
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:movieST ofType:@"mp4"];
    NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
	MPMoviePlayerController *moviePlayer = [[MPMoviePlayerController alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
    if (moviePlayer) {
        moviePlayer.contentURL = movieURL;
        [viewForMovie addSubview: moviePlayer.view];
        moviePlayer.view.frame = viewForMovie.bounds;
		moviePlayer.view.autoresizingMask =
		UIViewAutoresizingFlexibleWidth |
		UIViewAutoresizingFlexibleHeight;
		moviePlayer.controlStyle = MPMovieControlStyleNone;
		moviePlayer.repeatMode = MPMovieRepeatModeNone;
    }
    return moviePlayer;
}

- (void)movieFinishedCallback:(NSNotification*)notification {
    NSNumber *finishReason = [[notification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];
    if ([finishReason intValue] == MPMovieFinishReasonPlaybackEnded) {
        MPMoviePlayerController *moviePlayer = [notification object];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
        UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction;
        [UIView animateWithDuration:1 delay:0 options:options animations:^{
            theView.alpha = 0;
        } completion:nil];
    }
}

-(UITableView*)makeTableViewWithTarget:(id)target tag:(int)tag backgroundColor:(UIColor*)backgroundColor separatorColor:(UIColor*)separatorColor x:(int)x y:(int)y width:(int)width height:(int)height {
    
    // Make frame
    CGRect tableFrame = CGRectMake( x, y, width, height);
    // Create table and register cell
    UITableView* tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    // Add other atributes if they where added.
    if (backgroundColor) {
        tableView.backgroundColor = backgroundColor;
    }
    if (separatorColor) {
        tableView.separatorColor = separatorColor;
    }
    tableView.tag = tag;
    [tableView setShowsHorizontalScrollIndicator:NO];
    [tableView setShowsVerticalScrollIndicator:NO];
    
    // Add target and data source
    tableView.delegate = target;
    tableView.dataSource = target;
    
    // Return created table view
    return tableView;
}

@end
