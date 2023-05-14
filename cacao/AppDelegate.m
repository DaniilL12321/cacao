#import "AppDelegate.h"
#import "TriangleView.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Создание окна
    NSRect windowRect = NSMakeRect(0, 0, 640, 480);
    self.window = [[NSWindow alloc] initWithContentRect:windowRect
                                              styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable
                                                backing:NSBackingStoreBuffered
                                                  defer:NO];
    [self.window setTitle:@"Рисование фигур"];
    [self.window center];
    
    // Добавление представления треугольника на окно
    TriangleView *triangleView = [[TriangleView alloc] initWithFrame:windowRect];
    [self.window setContentView:triangleView];
    
    [self.window makeKeyAndOrderFront:nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}


@end
