//
//  AppDelegate.m
//  Turing Simulation
//
//  Created by Luke Zimmerman.
//  Copyright © 2017 Luke Zimmerman. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    [NSApp terminate:self];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    // closes the application when the red dot is clicked
    return true;
}


@end
