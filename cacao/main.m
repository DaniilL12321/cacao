//
//  main.m
//  cacao
//
//  Created by Мак on 18.03.2023.
//  Copyright © 2023 Мак. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSApplication *application = [NSApplication sharedApplication];
        AppDelegate *appDelegate = [[AppDelegate alloc] init];
        [application setDelegate:appDelegate];
        [application run];
    }
    return EXIT_SUCCESS;
}
