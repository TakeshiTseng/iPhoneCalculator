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
	BOOL resetFlag;
	BOOL addFlag;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnPress:(id)sender {
	UIButton* btn = (UIButton*) sender;
	NSLog(@"%@", [btn currentTitle]);
	NSString* text = [btn currentTitle];
	
	if([MathUtil isNum:text] && [buf length] < 10){
		if(resetFlag){
			[buf getCString:cbuf maxLength:10 encoding:NSUTF8StringEncoding];
			prevNumber = atof(cbuf);
			
			[buf setString:text];
			resetFlag = NO;
		} else {
			[buf appendString:text];
			
		}
	} else if([text isEqualToString:@"."] && ![MathUtil isRealNum:buf] && [buf length] < 10){
		[buf appendString:@"."];
		resetFlag = NO;
		
	} else if([text isEqualToString:@"±"]){
		if([MathUtil isNagtive:buf]){
			buf = [NSMutableString stringWithString:[buf substringFromIndex:1]];
		} else if(![[numPane text]isEqualToString:@"0"]){
			[buf insertString:@"-" atIndex:0];
		}
	}
	
	[numPane setText:buf];
}


-(IBAction)add:(id)sender{
	
	[buf getCString:cbuf maxLength:10 encoding:NSUTF8StringEncoding];
	currentNumber = atof(cbuf);
	if(addFlag){
		currentNumber += prevNumber;
		[buf setString:[NSString stringWithFormat:@"%f", currentNumber]];
	} else {
		addFlag = YES;
		
	}
	resetFlag = YES;
	[numPane setText:buf];
	
}
-(IBAction)allClear:(id)sender{
	[buf setString:@"0"];
	[numPane setText:buf];
	resetFlag = YES;
	addFlag = NO;
	currentNumber = 0;
	prevNumber = 0;
}

- (IBAction)persent:(id)sender{
	[buf getCString:cbuf maxLength:10 encoding:NSUTF8StringEncoding];
	currentNumber = atof(cbuf);
	currentNumber /= 100;
	buf = [NSMutableString stringWithFormat:@"%f", currentNumber];
	[numPane setText:buf];
}
- (IBAction)equal:(id)sender{
	if(addFlag){
		addFlag = NO;
		[buf getCString:cbuf maxLength:10 encoding:NSUTF8StringEncoding];
		currentNumber = atof(cbuf);
		currentNumber += prevNumber;
		[buf setString:[NSString stringWithFormat:@"%f", currentNumber]];
		resetFlag = YES;
		[numPane setText:buf];
	}
}
@end
