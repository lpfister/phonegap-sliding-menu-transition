//
//  BlackViewController.m
//  teardowntheroof
//
//  Created by Loic Pfister on 14/1/13.
//
//

#import "BlackViewController.h"

@interface BlackViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation BlackViewController

@synthesize imageView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setImageView1:(UIImage *)image{
    //[self.imageView setImage:image];

    self.imageView = [[UIImageView alloc] initWithImage:image];
    NSLog(@"set image");
  //  [self.view reloadInputViews];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    //[UIImageView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setImageView:nil];
    [super viewDidUnload];
}
@end
