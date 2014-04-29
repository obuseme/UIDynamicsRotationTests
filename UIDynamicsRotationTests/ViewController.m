//
//  ViewController.m
//  UIDynamicsRotationTests
//
//  Created by Andy Obusek on 4/29/14.
//  Copyright (c) 2014 Andy Obusek. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIView *animatedView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;

@end

@implementation ViewController

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.collisionBehavior removeAllBoundaries];
//    [self.collisionBehavior addBoundaryWithIdentifier:@"top"
//                                            fromPoint:CGPointMake(0, 0)
//                                              toPoint:CGPointMake(self.view.bounds.size.width, 0)];
//    [self.collisionBehavior addBoundaryWithIdentifier:@"bottom"
//                                            fromPoint:CGPointMake(0, self.view.bounds.size.height)
//                                              toPoint:CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height)];
    NSLog(@"x=%f y=%f", self.animatedView.frame.origin.x, self.animatedView.frame.origin.y);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Create our animator, we retain this ourselves
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    // Gravity
    self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[ ]];
    self.gravityBehavior.magnitude = 1;
    [self.animator addBehavior:self.gravityBehavior];

    // Collision - make a fake platform
    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[ ]];
    [self.collisionBehavior addBoundaryWithIdentifier:@"bottom"
                                            fromPoint:CGPointMake(0, self.view.bounds.size.height)
                                              toPoint:CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.animator addBehavior:self.collisionBehavior];

    self.animatedView.frame = CGRectMake(0, -1*self.animatedView.frame.size.height, self.animatedView.frame.size.width, self.animatedView.frame.size.height);
    self.animatedView.backgroundColor = [UIColor redColor];
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
}

- (IBAction)buttonTapped:(id)sender
{
    [self.gravityBehavior removeItem:self.animatedView];
    [self.collisionBehavior removeItem:self.animatedView];

    [self.collisionBehavior removeAllBoundaries];
    NSLog(@"bounds height = %f  frame height=%f", self.view.bounds.size.height, self.view.frame.size.height);
    [self.collisionBehavior addBoundaryWithIdentifier:@"bottom"
                                            fromPoint:CGPointMake(0, self.view.bounds.size.height)
                                              toPoint:CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height)];

    self.animatedView.frame = CGRectMake(0, -1*self.animatedView.bounds.size.height, self.animatedView.bounds.size.width, self.animatedView.bounds.size.height);
    self.animatedView.backgroundColor = [UIColor redColor];
//    self.animatedView.translatesAutoresizingMaskIntoConstraints = NO;

//    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_animatedView);
//    NSArray *widthConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_animatedView]|"
//                                                                        options:0
//                                                                        metrics:nil
//                                                                          views:viewsDictionary];
//    [self.animatedView addConstraints:widthConstraints];
//    NSArray *heightConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_animatedView]|"
//                                                                         options:0
//                                                                         metrics:nil
//                                                                           views:viewsDictionary];
//    [self.animatedView addConstraints:heightConstraints];

    NSLayoutConstraint *width =[NSLayoutConstraint
                                constraintWithItem:self.animatedView
                                attribute:NSLayoutAttributeWidth
                                relatedBy:0
                                toItem:self.view
                                attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                constant:0];
    NSLayoutConstraint *height =[NSLayoutConstraint
                                 constraintWithItem:self.animatedView
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:0
                                 toItem:self.view
                                 attribute:NSLayoutAttributeHeight
                                 multiplier:1.0
                                 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint
                               constraintWithItem:self.animatedView
                               attribute:NSLayoutAttributeTop
                               relatedBy:NSLayoutRelationEqual
                               toItem:self.view
                               attribute:NSLayoutAttributeTop
                               multiplier:1.0f
                               constant:0.f];
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:self.animatedView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.view
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:0.f];
//    [self.view addConstraint:width];
//    [self.view addConstraint:height];
//    [self.view addConstraint:top];
//    [self.view addConstraint:leading];

    // Add some gravity
    [self.gravityBehavior addItem:self.animatedView];

    // Add the collision
    [self.collisionBehavior addItem:self.animatedView];
}

@end
