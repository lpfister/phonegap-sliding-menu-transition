#import <objc/runtime.h>
#import "SlidingMenu.h"
#import <UIKit/UINavigationBar.h>
#import <QuartzCore/QuartzCore.h>
#import "IIViewDeckController.h"
#import "NestViewController.h"
#import "LeftViewController.h"
#import <Cordova/CDVViewController.h>
#import "BlackViewController.h"
#import "SMItem.h"

// For older versions of Cordova, you may have to use: #import "CDVDebug.h"
#import <Cordova/CDVDebug.h>

@interface SlidingMenu ()

@property (strong,nonatomic) IIViewDeckController* deckController;
@property (strong, nonatomic) LeftViewController *leftController;
@property (strong,nonatomic) NSMutableArray * leftMenuItems;
@property (strong,nonatomic) NSMutableArray * leftMenuSections;
@property (strong, nonatomic) CDVViewController *viewDetailsController;
@property (strong, nonatomic) UINavigationController* navController;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong,nonatomic) BlackViewController *blackView;
@end

@implementation SlidingMenu
#ifndef __IPHONE_3_0
@synthesize webView;

#endif

-(CDVPlugin*) initWithWebView:(UIWebView*)theWebView
{
    self = (SlidingMenu*)[super initWithWebView:theWebView];
    if(self)
    {
        self.leftMenuItems = [[NSMutableArray alloc] initWithCapacity:10];
        self.leftMenuSections = [[NSMutableArray alloc] initWithCapacity:5];
        
        // -----------------------------------------------------------------------
        // This code block is the same for both the navigation and tab bar plugin!
        // -----------------------------------------------------------------------
        
        // The original web view frame must be retrieved here. On iPhone, it would be 0,0,320,460 for example. Since
        // Cordova seems to initialize plugins on the first call, there is a plugin method init() that has to be called
        // in order to make Cordova call *this* method. If someone forgets the init() call and uses the navigation bar
        // and tab bar plugins together, these values won't be the original web view frame and layout will be wrong.
        originalWebViewFrame = theWebView.frame;
        UIApplication *app = [UIApplication sharedApplication];
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        switch (orientation)
        {
            case UIInterfaceOrientationPortrait:
            case UIInterfaceOrientationPortraitUpsideDown:
                break;
            case UIInterfaceOrientationLandscapeLeft:
            case UIInterfaceOrientationLandscapeRight:
            {
                float statusBarHeight = 0;
                if(!app.statusBarHidden)
                    statusBarHeight = MIN(app.statusBarFrame.size.width, app.statusBarFrame.size.height);
                
                originalWebViewFrame = CGRectMake(originalWebViewFrame.origin.y,
                                                  originalWebViewFrame.origin.x,
                                                  originalWebViewFrame.size.height + statusBarHeight,
                                                  originalWebViewFrame.size.width - statusBarHeight);
                break;
            }
            default:
                NSLog(@"Unknown orientation: %d", orientation);
                break;
        }
        
        navBarHeight = 44.0f;
        
    }
    return self;
}

- (void)dealloc
{
    // --- TODO dealloc staff here
    
    [super dealloc];
}

- (UIColor*)colorStringToColor:(NSString*)colorStr
{
    NSArray *rgba = [colorStr componentsSeparatedByString:@","];
    return [UIColor colorWithRed:[[rgba objectAtIndex:0] intValue]/255.0f
                           green:[[rgba objectAtIndex:1] intValue]/255.0f
                            blue:[[rgba objectAtIndex:2] intValue]/255.0f
                           alpha:[[rgba objectAtIndex:3] intValue]/255.0f];
}


- (UIImage*)screenshot
{
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
   /*
    // Iterate over every window from back to front
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        {
            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
            CGContextSaveGState(context);
            // Center the context around the window's anchor point
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            // Apply the window's transform about the anchor point
            CGContextConcatCTM(context, [window transform]);
            // Offset by the portion of the bounds left of and above the anchor point
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            // Render the layer hierarchy to the current context
            [[window layer] renderInContext:context];
            
            // Restore the context
            CGContextRestoreGState(context);
        }
    }
    */
    
    
    
    
  	[self.deckController.centerController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
	//UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	//UIGraphicsEndImageContext();
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    
    UIGraphicsEndImageContext();
    
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(
                                                       [image CGImage], CGRectMake(0, 88, 640, 872));
    UIImage* crop = [UIImage imageWithCGImage:imageRef];
    
    crop = [UIImage imageWithCGImage:[crop CGImage] scale:2 orientation:UIImageOrientationUp];
    CGImageRelease(imageRef);

    
    
    
    return crop;
}



-(void) startTrans:(CDVInvokedUrlCommand *)command
{
    //show mockuo
    UIImage *screenImage = [self screenshot];
    UIViewController *myViewC = [[UIViewController alloc] init];
   
    self.imageView = [[UIImageView alloc] initWithImage:screenImage];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
     [myViewC setView:self.imageView];
    [self.navController popViewControllerAnimated:NO];
  
    
    [self.blackView.view addSubview:self.imageView];
   
    // [self.navController pushViewController:myViewC animated:NO];
    
   // self.blackView.view = self.imageView;
   //  mockupView.view = 
    //UIViewController * mockupView = 
    
    //[self.navController.view addSubview:self.imageView];
    
}
- (void)pushView:(CDVInvokedUrlCommand *)command
{
    
    //[self.imageView removeFromSuperview];
   /* if(self.viewDetailsController == nil){
        self.viewDetailsController = [[[CDVViewController alloc] init] autorelease];
    }
    NSLog(@"push view");
    self.viewDetailsController.useSplashScreen = YES;
    self.viewDetailsController.wwwFolderName = @"www";
    self.viewDetailsController.startPage = @"page1.html";
    
    // load the view
    [self.viewDetailsController view];
    self.viewDetailsController.webView.delegate = self;
    
    //[NSThread sleepForTimeInterval:];
    NSLog(@"Pushview control before");
    
    NSLog(@"Pushview control after");
    */
    //[self.navController popViewControllerAnimated:NO];
    [self.navController pushViewController:self.viewController animated:YES];
    
    
    
    
    
}

- (void)webViewDidFinishLoad:(UIWebView*)theWebView
{
    
    NSLog(@"call back loic");
    [self.deckController.centerController pushViewController:self.viewDetailsController animated:YES];
}

/**
 * Create a native tab bar at either the top or the bottom of the display.
 */
- (void)create:(CDVInvokedUrlCommand*)command
{
    
    UIApplication *app = [UIApplication sharedApplication];
    
    [[app delegate] window].rootViewController = nil;
    
    leftTable = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    leftTable.tableView.dataSource = self;
    leftTable.tableView.delegate = self;
    
    
    NestViewController* nestController = [[NestViewController alloc] initWithNibName:@"NestViewController" bundle:nil];
    nestController.level = 1;
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:nestController];
    self.deckController.centerController = self.navController;
    
    
    
    self.blackView = [[[BlackViewController alloc] init] autorelease];
    [self.navController pushViewController:self.blackView animated:NO];
    [self.navController pushViewController:self.viewController animated:YES];
    
    //    app.delegate.wi = nil;
    self.leftController = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
    self.deckController =  [[IIViewDeckController alloc] initWithCenterViewController:self.navController leftViewController:leftTable rightViewController:nil];
    
    // [[[self webView] superview] addSubview:[deckController view]];
    
    // prepare view controllers
    /*
     
     if(navBar)
     return;
     
     navBarController = [[CDVNavigationBarController alloc] init];
     navBar = (UINavigationBar*)[navBarController view];
     
     const NSDictionary *options = command ? [command.arguments objectAtIndex:0] : nil;
     
     
     [navBarController setDelegate:self];
     
     [[navBarController view] setFrame:CGRectMake(0, 0, originalWebViewFrame.size.width, navBarHeight)];
     [[[self webView] superview] addSubview:[navBarController view]];
     [navBar setHidden:YES];}
     */
    [[[UIApplication sharedApplication] delegate] window].rootViewController = self.deckController;
    
}


- (void)createItem:(CDVInvokedUrlCommand*)command
{
    
    SMItem *item = [[SMItem alloc] init];
    
    item.title     = [command.arguments objectAtIndex:0];
    item.imageName = [command.arguments objectAtIndex:1];
    item.section = [command.arguments objectAtIndex:2];
    
    
    if (item.section != nil) {
        if(![self.leftMenuSections containsObject:item.section]){
            [self.leftMenuSections addObject:item.section];
        }
    }
    
    [self.leftMenuItems addObject:item];
    [self.leftController.tableView reloadData];
}

-(void)showLeftMenu:(CDVInvokedUrlCommand *)command
{
    [self.deckController toggleLeftView];
}

// --- Handle left navigation
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.leftMenuSections count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.leftMenuSections objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    int nbrInSect = 0;
    
    SMItem *item;
    for (int i=0; i<[self.leftMenuItems count]; i++) {
        
        item = (SMItem*)[self.leftMenuItems objectAtIndex:i];
        
        
        
        if([item.section isEqualToString:[self.leftMenuSections objectAtIndex:section]]){
            nbrInSect++;
        }
    }
    return nbrInSect;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
    }
    
    cell.textLabel.text = [(SMItem*)([self.leftMenuItems objectAtIndex:indexPath.row]) title];
  
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /* if (indexPath.section == 0) {
     [self.viewDeckController toggleOpenView];
     return;
     }
     
     [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
     if ([controller.centerController isKindOfClass:[UINavigationController class]]) {
     UITableViewController* cc = (UITableViewController*)((UINavigationController*)controller.centerController).topViewController;
     cc.navigationItem.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
     if ([cc respondsToSelector:@selector(tableView)]) {
     [cc.tableView deselectRowAtIndexPath:[cc.tableView indexPathForSelectedRow] animated:NO];
     }
     }
     [NSThread sleepForTimeInterval:(300+arc4random()%700)/1000000.0]; // mimic delay... not really necessary
     }];
     */
    
    [self.deckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
        if ([controller.centerController isKindOfClass:[UINavigationController class]]) {
            UITableViewController* cc = (UITableViewController*)((UINavigationController*)controller.centerController).topViewController;
            cc.navigationItem.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
            
            
            if ([cc respondsToSelector:@selector(tableView)]) {
                [cc.tableView deselectRowAtIndexPath:[cc.tableView indexPathForSelectedRow] animated:NO];
            }
        }
        
        
        NSString * jsCallBack = [NSString stringWithFormat:@"window.plugins.SlidingMenu.onItemSelected(%d);", [indexPath row]];
        [self writeJavascript:jsCallBack];
        
        
        //[NSThread sleepForTimeInterval:(300+arc4random()%700)/1000000.0]; // mimic delay... not really necessary
    }];
    
}



-(void) init:(CDVInvokedUrlCommand*)command
{
    // Dummy function, see initWithWebView
}


@end
