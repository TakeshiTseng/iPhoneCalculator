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

@end
