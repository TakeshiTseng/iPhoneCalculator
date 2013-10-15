//
//  ViewController.h
//  Calculator
//
//  Created by Takeshi on 13/10/7.
//  Copyright (c) 2013年 Takeshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MathUtil.h"

@interface ViewController : UIViewController{
	IBOutlet UILabel *numPane;
}

- (IBAction)numberButtonPress:(id)sender;
- (IBAction)equal:(id)sender;
- (IBAction)setNeg:(id)sender;
- (IBAction)allClear:(id)sender;
- (IBAction)persent:(id)sender;
- (IBAction)updateNumLabel:(id)sender;
@end
