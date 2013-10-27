//
//  ViewController.m
//  Calculator
//
//  Created by Takeshi on 13/10/7.
//  Copyright (c) 2013年 Takeshi. All rights reserved.
//

#import "ViewController.h"
#include <ctype.h>
#include "DDMathParser.h"
#include "DDMathStringTokenizer.h"

@interface ViewController (){
	NSMutableString* buf;
	char cbuf[100];
	DDMathEvaluator *evaluator;
	BOOL resetFlag;
	double memoryNumber;
	double currentNumber;
	
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	buf = [NSMutableString stringWithString:@"0"];
	evaluator = [[DDMathEvaluator alloc] init];
	resetFlag = YES;
	memoryNumber = 0;
	currentNumber = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)numberButtonPress:(id)sender{
	UIButton* button = (UIButton*)sender;
	NSString* numText = [button currentTitle];
	if(resetFlag){
		[buf setString:numText];
		resetFlag = NO;
	} else {
		[buf appendString:numText];
	}

	
}
- (IBAction)allClear:(id)sende{
	[buf setString:@"0"];
	resetFlag = YES;
}
- (IBAction)setNeg:(id)sender{
	if([MathUtil isNagtive:buf]){
		[buf setString:[buf substringFromIndex:1]];
	} else{
		[buf insertString:@"-" atIndex:0];
	}
}
- (IBAction)equal:(id)sender{
	[self calculate];
	resetFlag = YES;
}
- (IBAction)persent:(id)sender{
	// must calculate first!
	[buf getCString:cbuf maxLength:100 encoding:NSUTF8StringEncoding];
	double dbuf = atof(cbuf);
	dbuf = dbuf / 100;
	[buf setString:[NSString stringWithFormat:@"%f", dbuf]];
}
- (IBAction)updateNumLabel:(id)sender{
	[numPane setText:buf];
}
- (IBAction)dot:(id)sender{
	if(![MathUtil isRealNum:buf]){
		[buf appendString:@"."];
	}
}

- (void)calculate{
	NSString* expressionString = buf;
	NSLog(@"Exp : %@", expressionString);
	NSError *error = nil;
	DDMathStringTokenizer *tokenizer = [[DDMathStringTokenizer alloc] initWithString:expressionString error:&error];
	DDParser *parser = [DDParser parserWithTokenizer:tokenizer error:&error];
	
	DDExpression *expression = [parser parsedExpressionWithError:&error];
	DDExpression *rewritten = [evaluator expressionByRewritingExpression:expression];
	
	NSNumber *value = [rewritten evaluateWithSubstitutions:nil evaluator:evaluator error:&error];

	currentNumber = [value doubleValue];
	DD_RELEASE(tokenizer);
	NSString* valueString = [value description];
	
	
	if(value == nil){
		[buf setString:@"Error!"];
		NSLog(@"Error : %@", [error description]);
	} else if([valueString isEqualToString:@"inf"]){
		[buf setString:@"無限大"];
	} else if([valueString isEqualToString:@"-inf"]){
		[buf setString:@"負無限大"];
	} else {
		[buf setString:valueString];
	}
}



- (IBAction)normalCalculateSymbolButtonPress:(id)sender{
	UIButton* button = (UIButton*)sender;
	NSString* text = [button currentTitle];
	if([text isEqualToString:@"÷"]){
		text = @"/";
	}
	if([text isEqualToString:@"x"]){
		text = @"*";
	}
	if([text isEqualToString:@"–"]){
		text = @"-";
	}
	if([text isEqualToString:@"("] && resetFlag){
		text = @"";
		[buf setString:@"("];
	}
	[buf appendString:text];
	resetFlag = NO;
}

- (IBAction)memoryButtonPress:(id)sender{
	UIButton* button = (UIButton*)sender;
	NSString* title = [button currentTitle];
	
	if([title isEqualToString:@"mc"]){
		memoryNumber = 0;
	} else if([title isEqualToString:@"mr"]){
		[buf setString:[NSString stringWithFormat:@"%f", memoryNumber]];
	} else if([title isEqualToString:@"m+"]){
		[self calculate];
		memoryNumber += currentNumber;
	} else {
		[self calculate];
		memoryNumber -= currentNumber;
	}
}

- (IBAction)specialButtonPress:(id)sender{
	UIButton* btn = (UIButton*)sender;
	NSString* text = [btn currentTitle];
	if([text isEqualToString:@"x^2"] && !resetFlag){
		[buf insertString:@"(" atIndex:0];
		[buf appendString:@")**2"];
	} else if([text isEqualToString:@"e"]){
		if(resetFlag){
			[buf setString:@"e"];
		} else {
			[buf appendString:@"e"];
		}
	} else if([text isEqualToString:@"e^x"]){
		[buf insertString:@"e**(" atIndex:0];
		[buf appendString:@")"];
	} else if([text isEqualToString:@"10^x"]){
		[buf insertString:@"10**(" atIndex:0];
		[buf appendString:@")"];
	} else if([text isEqualToString:@"3√x"]){
		[buf insertString:@"(" atIndex:0];
		[buf appendString:@")**(1/3)"];
	} else if([text isEqualToString:@"√x"]){
		[buf insertString:@"(" atIndex:0];
		[buf appendString:@")**(1/2)"];
	} else if([text isEqualToString:@"x^y"]){
		[buf insertString:@"(" atIndex:0];
		[buf appendString:@")**"];
	} else if([text isEqualToString:@"2^x"]){
		[buf insertString:@"2**(" atIndex:0];
		[buf appendString:@")"];
	} else if([text isEqualToString:@"tan"]){
		[self calculate];
		currentNumber = tan(currentNumber);
		[buf setString:[NSString stringWithFormat:@"%f", currentNumber]];
	} else if([text isEqualToString:@"cos"]){
		[self calculate];
		currentNumber = cos(currentNumber);
		[buf setString:[NSString stringWithFormat:@"%f", currentNumber]];
	} else if([text isEqualToString:@"sin"]){
		[self calculate];
		currentNumber = sin(currentNumber);
		[buf setString:[NSString stringWithFormat:@"%f", currentNumber]];
		
	} else if([text isEqualToString:@"π"]){
		if(resetFlag){
			[buf setString:@"π"];
		} else {
			[buf appendString:@"π"];
		}
	} else if([text isEqualToString:@"ln"]){
		[buf insertString:@"ln(" atIndex:0];
		[buf appendString:@")"];
	}
	resetFlag = NO;
}

- (IBAction)backSpace:(id)sender{
	NSString* tmpString = [buf substringToIndex:[buf length]-1];
	[buf setString:tmpString];
}

@end