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
	double currentNumber;
	double prevNumber;
	double holdNumber;
	BOOL resetFlag;
	BOOL addFlag;
	BOOL minusFlag;
	BOOL holdFlag;
	char cbuf[10];
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	buf = [NSMutableString stringWithString:@"0"];
	currentNumber = 0;
	prevNumber = 0;
	resetFlag = YES;
	addFlag = NO;
	minusFlag = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)numberButtonPress:(id)sender{
	
}




@end