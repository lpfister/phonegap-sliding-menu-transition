
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UITabBar.h>

// For older versions of Cordova, you may have to use: #import "CDVPlugin.h"
#import <Cordova/CDVPlugin.h>

@interface SlidingMenu : CDVPlugin <UITableViewDataSource, UITableViewDelegate,UINavigationControllerDelegate,UIWebViewDelegate> {
	// Represents frame of web view as if started in portrait mode. Coordinates are relative to the superview. With
    // Cordova 2.1.0, frame.origin.y=0 means directly under the status bar, while in older versions it would have been
    // frame.origin.y=20.
	CGRect	originalWebViewFrame;
    
   CGFloat navBarHeight;
    UITableViewController *leftTable;
    NSMutableArray* leftMenuItems;
    NSMutableArray* leftMenuSections;
    
}

- (void)create:(CDVInvokedUrlCommand*)command;
- (void)show:(CDVInvokedUrlCommand*)command;
- (void)resize:(CDVInvokedUrlCommand*)command;
- (void)hide:(CDVInvokedUrlCommand*)command;
- (void)init:(CDVInvokedUrlCommand*)command;
- (void)showItems:(CDVInvokedUrlCommand*)command;
- (void)showLeftMenu:(CDVInvokedUrlCommand*)command;
- (void)pushView:(CDVInvokedUrlCommand*)command;
- (void)startTrans:(CDVInvokedUrlCommand*)command;


- (void)createItem:(CDVInvokedUrlCommand*)command;
- (void)updateItem:(CDVInvokedUrlCommand*)command;
- (void)selectItem:(CDVInvokedUrlCommand*)command;


@end

