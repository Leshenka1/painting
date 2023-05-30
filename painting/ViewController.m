//
//  ViewController.m
//  drawing(example1.1)
//
//  Created by Алексей Зубель on 13.05.23.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *canvas;
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
@property CGPoint lastPoint;
- (IBAction)size1:(UIButton *)sender;
@property (nonatomic, assign) float myFloat;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *myMutableArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myFloat = 5.0;
    self.myMutableArray = [NSMutableArray array];
    self.myMutableArray[0] = @(1.0f);
    self.myMutableArray[1] = @(0.0f);
    self.myMutableArray[2] = @(0.0f);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    [self setLastPoint:[touch locationInView:self.view]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGRect drawRect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width,
    self.view.frame.size.height);
    [[[self canvas] image] drawInRect:drawRect];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _myFloat); //changes by buttons click and viewDidLoad
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), _myMutableArray[0].floatValue,//changes by buttons click and viewDidLoad
        _myMutableArray[1].floatValue,
        _myMutableArray[2].floatValue,
        1.0f);
    
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x,
    _lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x,
    currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    [[self canvas] setImage:UIGraphicsGetImageFromCurrentImageContext()];
    UIGraphicsEndImageContext();
    _lastPoint = currentPoint;
}

- (IBAction)size1:(UIButton *)sender {
    self.myFloat = 5.0;
    }
- (IBAction)size2:(UIButton *)sender {
    self.myFloat = 10.0;
}
- (IBAction)size3:(id)sender {
    self.myFloat = 15.0;
}
- (IBAction)size4:(id)sender {
    self.myFloat = 20.0;
}
- (IBAction)size5:(id)sender {
    self.myFloat = 25.0;
}
- (IBAction)redColor:(UIButton *)sender {
    self.myMutableArray[0] = @(1.0f);
    self.myMutableArray[1] = @(0.0f);
    self.myMutableArray[2] = @(0.0f);
}
- (IBAction)greenColor:(UIButton *)sender {
    self.myMutableArray[0] = @(0.0f);
    self.myMutableArray[1] = @(1.0f);
    self.myMutableArray[2] = @(0.0f);
}
- (IBAction)blueColor:(UIButton *)sender {
    self.myMutableArray[0] = @(0.0f);
    self.myMutableArray[1] = @(0.0f);
    self.myMutableArray[2] = @(1.0f);
}

//MARK: saving drawing picture to the iphone's library
- (IBAction)save:(UIButton *)sender {
    UIGraphicsBeginImageContext(self.canvas.bounds.size);
        [self.canvas.image drawInRect:CGRectMake(0, 0, self.canvas.bounds.size.width, self.canvas.bounds.size.height)];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Image Saved" message:@"The image has been saved to your photo library." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
}

@end
