//
//  MJDetailViewController.m
//  MJPopupViewControllerDemo
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import "MJDetailViewController.h"
#import "UIImage+animatedGIF.h"

@implementation MJDetailViewController

@synthesize dataImageView;
@synthesize urlImageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"bodyweightsquat" withExtension:@"gif"];
    self.dataImageView.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    
}

@end
