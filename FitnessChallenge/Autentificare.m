//
//  Autentificare.m
//  FitnessChallenge
//
//  Created by Cristian on 10/24/13.
//  Copyright (c) 2013 C.A.D. All rights reserved.
//

#import "Autentificare.h"
#import "ECSlidingViewController.h"

@interface Autentificare ()

@end

@implementation Autentificare

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"authBG.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //hides keyboard when another part of layout was touched
    [self.view endEditing:YES];
    
    [super touchesBegan:touches withEvent:event];
}

- (IBAction)butonApasat {
    
    UIViewController *newTopViewController;
    
    newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Inregistrare"];
    
    CGRect frame = self.slidingViewController.topViewController.view.frame;
    self.slidingViewController.topViewController = newTopViewController;
    self.slidingViewController.topViewController.view.frame = frame;
    [self.slidingViewController resetTopView];
    
}

- (IBAction)autentificare {
    
    if (([email.text isEqualToString:@"demo"])&&([pass.text isEqualToString:@"fitnesschallenge"])) {
        
        UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Test"];
        
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
        
    }
    
    else if (([email.text isEqualToString:@""])||([pass.text isEqualToString:@""])) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                        message:[NSString stringWithFormat:@"Nu ai completat adresa de mail si/sau parola!"]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        
    }
    
    else if (!(([email.text isEqualToString:@"demo"])&&([pass.text isEqualToString:@"fitnesschallenge"]))) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Eroare"
                                                        message:[NSString stringWithFormat:@"Ai gresit adresa de mail si/sau parola!"]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

