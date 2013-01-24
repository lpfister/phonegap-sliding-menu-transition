//
//  NestViewController.m
//  ViewDeckExample
//

#import "NestViewController.h"
#import "IIViewDeckController.h"
#import <Cordova/CDVViewController.h>


@implementation NestViewController

@synthesize level;
@synthesize levelLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.level = 0;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.levelLabel.text = [NSString stringWithFormat:@"Level %d", self.level];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
  }

- (void)hideOrShow {
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)pressedGoDeeper:(id)sender {
    
    CDVViewController *viewController = [[[CDVViewController alloc] init] autorelease];
    viewController.useSplashScreen = YES;
    viewController.wwwFolderName = @"www";
    viewController.startPage = @"page1.html";
    
    
   /* NestViewController* nestController = [[NestViewController alloc] initWithNibName:@"NestViewController" bundle:nil];
    nestController.level = self.level + 1;
    nestController.view = self.view;*/
    /*
    [self.navigationController pushViewController:viewController animated:YES];*/
}

@end
