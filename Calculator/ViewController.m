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
	BOOL minusFlag;
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
-(void)setCurrentNumber{
	[buf getCString:cbuf maxLength:10 encoding:NSUTF8StringEncoding];
	currentNumber = atof(cbuf);
}
-(void)setPreviousNumber{
	[buf getCString:cbuf maxLength:10 encoding:NSUTF8StringEncoding];
	prevNumber = atof(cbuf);
}
- (IBAction)numberButonPress:(id)sender {
	UIButton* btn = (UIButton*) sender;
	NSLog(@"%@", [btn currentTitle]);
	NSString* text = [btn currentTitle];
	
	if([buf length] < 10){
		if(resetFlag){
			[self setPreviousNumber];
			[buf setString:text];
			resetFlag = NO;
		} else {
			[buf appendString:text];
		}
	}
	[self setCurrentNumber];
	[self setBuf];
}


-(IBAction)add:(id)sender{
	[self calculate];

	addFlag = YES;
	[self setBuf];
}

-(IBAction)allClear:(id)sender{

	resetFlag = YES;
	addFlag = NO;
	minusFlag = NO;
	currentNumber = 0;
	prevNumber = 0;
	
	[self setBuf];
}

- (IBAction)persent:(id)sender{
	currentNumber /= 100;
	[self clearFlags];
	[self setBuf];
}
- (IBAction)equal:(id)sender{
	[self calculate];

	prevNumber = 0;
	[self setBuf];
}
- (IBAction)dot:(id)sender{
	if(![MathUtil isRealNum:buf] && [buf length] < 10){
		[buf appendString:@"."];
		resetFlag = NO;
		
	}
}
- (IBAction)setNeg:(id)sender{
	currentNumber *= -1;
	[self setBuf];
}

- (IBAction)minus:(id)sender{
	[self calculate];

	minusFlag = YES;
	
	[self setBuf];

}
- (void)setBuf{
	[buf setString:[NSString stringWithFormat:@"%g", currentNumber]];
	[numPane setText:buf];
}
- (void)calculate {
	if(minusFlag){
		currentNumber = prevNumber - currentNumber;
	} else if(addFlag){
		currentNumber = prevNumber + currentNumber;
	}
	[self clearFlags];
}

-(void)clearFlags{
	addFlag = NO;
	minusFlag = NO;
	resetFlag = YES;
}
@end
