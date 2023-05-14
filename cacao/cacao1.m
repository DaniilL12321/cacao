#import <Cocoa/Cocoa.h> //Импорт Cocoa-фреймворка

#include <math.h> //Импорт библиотеки math

@interface CustomView : NSView { //Класс CustomView наследуется от NSView
    int x, y, R; //Объявление переменных
    int x_1, y_1, R_1;
    int x_2, y_2, R_2;
    
    int V = 0, V_1 = 0, V_2 = 0; //Инициализация переменных
    int m = -1;
    const double_t p = 3.141592;
}

-(void)drawRect:(NSRect)dirtyRect;
-(void)keyDown:(NSEvent *)event;
@end

@implementation CustomView

-(void)drawRect:(NSRect)dirtyRect { //Метод для рисования фигур
    [super drawRect:dirtyRect];
    
    NSBezierPath* path = [NSBezierPath bezierPath]; //Создание кривой Безье
    [path setLineWidth:1.0]; //Установка толщины линии
    [[NSColor blackColor] setStroke]; //Установка цвета обводки
    
    NSWindow *window = [NSApplication sharedApplication].mainWindow;
    
    if (V == 1) { //Если выбран круг
        if (m == 1) { //Если нажата клавиша F1
            [path setLineWidth:5.0]; //Увеличить толщину линии
        }
        else {
            [path setLineWidth:1.0];
        }
        NSLog(@"drawing figure");
        [path moveToPoint:NSMakePoint(x, y - R)]; //Переместить к начальной точке
        [path lineToPoint:NSMakePoint(x - R * cos(p / 6), y + R * sin(p / 6))]; //Нарисовать линию к следующей точке
        [path lineToPoint:NSMakePoint(x + R * cos(p / 6), y + R * sin(p / 6))]; //Нарисовать линию к следующей точке
        [path lineToPoint:NSMakePoint(x, y - R)]; //Нарисовать линию к конечной точке
        [[NSColor redColor] setFill]; //Установить цвет заливки
        [path fill]; //Залить фигуру
        [path stroke]; //Нарисовать обводку
    }
    
    if (V_1 == 1) { //Если выбран прямоугольник
        if (m == 2) { //Если нажата клавиша F2
            [path setLineWidth:5.0]; //Увеличить толщину линии
        }
        else {
            [path setLineWidth:1.0];
        }
        [path moveToPoint:NSMakePoint(x_1 - R_1 * cos(p / 4), y_1 - R_1 * sin(p / 4))]; //Переместить к начальной точке
        [path lineToPoint:NSMakePoint(x_1 - R_1 * cos(p / 4), y_1 + R_1 * sin(p / 4))]; //Нарисовать линию к следующей точке
        [path lineToPoint:NSMakePoint(x_1 + R_1 * cos(p / 4), y_1 + R_1 * sin(p / 4))]; //Нарисовать линию к следующей точке
        [path lineToPoint:NSMakePoint(x_1 + R_1 * cos(p / 4), y_1 - R_1 * sin(p / 4))]; //Нарисовать линию к следующей точке
        [path lineToPoint:NSMakePoint(x_1 - R_1 * cos(p / 4), y_1 - R_1 * sin(p / 4))]; //Нарисовать линию к конечной точке
        [[NSColor blackColor] setFill]; //Установить цвет заливки
        [path fill]; //Залить фигуру
        [path stroke]; //Нарисовать обводку
    }
    
    if (V_2 == 1) { //Если выбран треугольник
        if (m == 3) { //Если нажата клавиша F3
            [path setLineWidth:5.0]; //Увеличить толщину линии
        }
        else {
            [path setLineWidth:1.0];
        }
        [path moveToPoint:NSMakePoint(x_2 - R_2, y_2)]; //Переместить к начальной точке
        [path lineToPoint:NSMakePoint(x_2, y_2 - R_2)]; //Нарисовать линию к следующей точке
        [path lineToPoint:NSMakePoint(x_2 + R_2, y_2)]; //Нарисовать линию к следующей точке
        [path lineToPoint:NSMakePoint(x_2, y_2 + R_2)]; //Нарисовать линию к следующей точке
        [path lineToPoint:NSMakePoint(x_2 - R_2, y_2)]; //Нарисовать линию к конечной точке
        [[NSColor blackColor] setFill]; //Установить цвет заливки
        [path fill]; //Залить фигуру
        [path stroke]; //Нарисовать обводку
    }
}

- (void)keyDown:(NSEvent *)event { //Метод для обнаружения нажатия клавиши
    if ([event modifierFlags] & NSEventModifierFlagFunction) { //Если нажата функциональная клавиша
        switch ([event keyCode]) { //Переключение по коду клавиши
                NSWindow *window = [NSApplication sharedApplication].mainWindow;
            case 122: //Нажата клавиша F1
                V = 1; //Выбрать круг
                m = 1; //Нажата клавиша F1
                x = 100; //Установить x-координату круга
                y = 100; //Установить y-координату круга
                R = 50; //Установить радиус круга
                [[_window contentView] setNeedsDisplay:YES];
                break;
            case 120: //Нажата клавиша F2
                V_1 = 1; //Выбрать прямоугольник
                m = 2; //Нажата клавиша F2
                x_1 = 200; //Установить x-координату прямоугольника
                y_1 = 200; //Установить y-координату прямоугольника
                R_1 = 50; //Установить размер прямоугольника
                [[_window contentView] setNeedsDisplay:YES];
                break;
            case 99: //Нажата клавиша F3
                V_2 = 1; //Выбрать треугольник
                m = 3; //Нажата клавиша F3
                x_2 = 300; //Установить x-координату треугольника
                y_2 = 300; //Установить y-координату треугольника
                R_2 = 50; //Установить размер треугольника
                [[_window contentView] setNeedsDisplay:YES];
                break;
            default:
                break;
        }
    }
}

@end

@interface AppDelegate : NSObject <NSApplicationDelegate> //Класс AppDelegate наследуется от NSObject и NSApplicationDelegate
-(void)applicationDidFinishLaunching:(NSNotification *)aNotification;
@end

@implementation AppDelegate

-(void)applicationDidFinishLaunching:(NSNotification *)aNotification { //Метод для запуска приложения
    NSWindow *window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0, 0, 640, 480) //Создать окно
                                                   styleMask:NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable //Установить стиль окна
                                                     backing:NSBackingStoreBuffered //Установить буфер хранения
                                                       defer:NO]; //Не откладывать создание
    
    [window setTitle:@"Рисование фигур"]; //Установить заголовок окна
    [window center]; //Центрировать окно
    
    CustomView *customView = [[CustomView alloc] initWithFrame:NSMakeRect(0, 0, 640, 480)]; //Создать экземпляр CustomView
    [window setContentView:customView]; //Установить вид содержимого окна
    [window makeKeyAndOrderFront:NSApp]; //Сделать окно ключевым и передним планом
}

@end

int main(int argc, const char * argv[]) { //Основной метод
    @autoreleasepool {
        NSApplication *application = [NSApplication sharedApplication]; //Создать экземпляр NSApplication
        AppDelegate *appDelegate = [[AppDelegate alloc] init]; //Создать экземпляр AppDelegate
        [application setDelegate:appDelegate]; //Установить делегата приложения
        [application run]; //Запустить приложение
    }
    return NSApplicationMain(argc, argv);
}

//gcc -framework cocoa /Users/mak/Downloads/cocoa.m -o /Users/mak/Downloads/cocoa //Команда для компиляции
