//
//  ViewController.h
//  Turing Simulation
//
//  Created by Luke Zimmerman.
//  Copyright © 2017 Luke Zimmerman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (weak) IBOutlet NSTextFieldCell *filePathLabel;

@property (weak) IBOutlet NSTextField *transLabel;

@property (weak) IBOutlet NSTextField *testString;

@property (weak) IBOutlet NSTextField *transitionText;

@property (weak) IBOutlet NSTextField *acceptText;

@property (weak) IBOutlet NSTextField *acceptLabel;

@property (weak) IBOutlet NSTextField *resultLabel;

@end
