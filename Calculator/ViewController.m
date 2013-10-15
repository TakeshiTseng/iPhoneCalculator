//
//  ViewController.m
//  Calculator
//
//  Created by Takeshi on 13/10/7.
//  Copyright (c) 2013年 Takeshi. All rights reserved.
//

#import "ViewController.h"
#include <ctype.h>

@interface ViewController (){
	NSMutableString* buf;

}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	buf = [NSMutableString stringWithString:@"0"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)numberButtonPress:(id)sender{
	NSString* numText = [sender title];
	[buf appendString:numText];
	
}
- (IBAction)allClear:(id)sende{
	
}
- (IBAction)setNeg:(id)sender{
	
}
- (IBAction)equal:(id)sender{
	
}
- (IBAction)persent:(id)sender{
	
}
- (IBAction)updateNumLabel:(id)sender{
	[numPane setText:buf];
}

@end