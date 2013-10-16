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
	
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	buf = [NSMutableString stringWithString:@"0"];
	evaluator = [[DDMathEvaluator alloc] init];
	resetFlag = YES;
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
	NSString* expressionString = [numPane text];
	NSLog(@"Exp : %@", expressionString);
	NSError *error = nil;
	DDMathStringTokenizer *tokenizer = [[DDMathStringTokenizer alloc] initWithString:expressionString error:&error];
	DDParser *parser = [DDParser parserWithTokenizer:tokenizer error:&error];
	
	DDExpression *expression = [parser parsedExpressionWithError:&error];
	DDExpression *rewritten = [evaluator expressionByRewritingExpression:expression];
	
	NSNumber *value = [rewritten evaluateWithSubstitutions:nil evaluator:evaluator error:&error];
	DD_RELEASE(tokenizer);
	if(value == nil){
		[buf setString:@"Error!"];
		NSLog(@"Error : %@", [error description]);
	} else {
		[buf setString:[value description]];
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
@end