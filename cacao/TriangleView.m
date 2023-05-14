// 5 ВАРИАНТ выровнять все фигуры по горизонтали на равне с самой верхней
#import "TriangleView.h"

const int N_MAX = 11;

@implementation TriangleView { // DECLARING VARIABLES AND CONST
    int V[N_MAX];
    int x[N_MAX];
    int y[N_MAX];
    int R[N_MAX];
    int t[N_MAX];
    int W[N_MAX];
    float a[N_MAX];
    int m;
    int n;
    int f;
    int k;
    
    double p;
    BOOL isAnimating;

}

- (instancetype)initWithFrame:(NSRect)frameRect { // INTITIALISATION VARIABLES
    self = [super initWithFrame:frameRect];
    if (self) {
        n = 0;
        m = -1;
        p = 3.141592;
        isAnimating = NO;

    }
    return self;
}

- (BOOL)acceptsFirstResponder { // Для KEYDOWN, без этого не работает
    return YES;
}

- (void)startRotationTimer { // START TIMER
    isAnimating = YES;
    rotationTimer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                     target:self
                                                   selector:@selector(rotateActiveFigure)
                                                   userInfo:nil
                                                    repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:rotationTimer forMode:NSRunLoopCommonModes];
}

- (void)stopRotationTimer { // STOP TIMER
    [rotationTimer invalidate];
    rotationTimer = nil;
    isAnimating = NO;
}

- (void)rotateActiveFigure { // ROTATE
    if (!isAnimating) {
        return;
    }
    for (int i = 0; i < n; i++) {
        if (i != m) {
            CGFloat dx = x[m] - x[i];
            CGFloat dy = y[m] - y[i];
            CGFloat distance = sqrt(dx*dx + dy*dy);
            a[i] -= p/180;
            x[i] = x[m] + cos(a[i]) * distance;
            y[i] = y[m] + sin(a[i]) * distance;
        }
        else {
            a[i] += p/180;
        }
    }
    [self setNeedsDisplay:YES];
}

- (void)keyDown:(NSEvent *)event {
    if ([event keyCode] == 22) { // 6
        if (isAnimating) {
            [self stopRotationTimer];
            NSLog(@"Анимация отключена");
            return;
        }
        else {
            NSLog(@"Анимация включена (Все остальные режимы заблокированы, чтобы разблокировать нажмите 6)");
            [self startRotationTimer];
        }
    }
    if (!isAnimating) {
        if (n < N_MAX - 1) {
            if ([event keyCode] == 18) { // 1
                n++;
                m = n - 1;
                x[m] = 100;
                y[m] = 100;
                R[m] = -50;
                V[m] = 1;
                t[m] = 1;
                for (int j = 0; j <= n; j++) {
                    if (V[j] != 0) V[j] = 0;
                }
                V[m] = 1;

                NSLog(@"Треугольник");
                [self setNeedsDisplay:YES];
            }
            if ([event keyCode] == 19) { // 2
                n++;
                m = n - 1;
                x[m] = 200;
                y[m] = 200;
                R[m] = -50;
                V[m] = 1;
                t[m] = 3;
                for (int j = 0; j <= n; j++) {
                    if (V[j] != 0) V[j] = 0;
                }
                V[m] = 1;
                NSLog(@"Квадрат");
                [self setNeedsDisplay:YES];
            }
            if ([event keyCode] == 20) { // 3
                n++;
                m = n - 1;
                x[m] = 300;
                y[m] = 300;
                R[m] = -50;
                V[m] = 1;
                t[m] = 2;
                for (int j = 0; j <= n; j++) {
                    if (V[j] != 0) V[j] = 0;
                }
                V[m] = 1;
                NSLog(@"Ромб");
                [self setNeedsDisplay:YES];
            }
        }
        if (n <= N_MAX - 1) {
            if ([event keyCode] == 123) { // LEFT
                V[m] = 0;
                if (m > 0) {
                    m--;
                }
                else {
                    m = n - 1;
                }
                V[m] = 1;
                NSLog(@"Выбор фигуры <--");
                [self setNeedsDisplay:YES];
            }
            if ([event keyCode] == 124) { // RIGHT
                V[m] = 0;
                if (m < n - 1) {
                    m++;
                }
                else {
                    m = 0;
                }
                V[m] = 1;
                NSLog(@"Выбор фигуры -->");

                [self setNeedsDisplay:YES];
            }
            if ([event keyCode] == 126) { // UP
                R[m] -= 5;
                NSLog(@"Увеличение фигуры");
                [self setNeedsDisplay:YES];
            }
            if ([event keyCode] == 125) { // DOWN
                R[m] += 5;
                NSLog(@"Уменьшение фигуры");
                [self setNeedsDisplay:YES];
            }
            if ([event keyCode] == 21) { // TURN RIGHT
                a[m] += p/12;
                NSLog(@"поворот -->");
                [self setNeedsDisplay:YES];
            }
            if ([event keyCode] == 23) { // TURN LEFT
                a[m] -= p/12;
                NSLog(@"поворот <--");
                [self setNeedsDisplay:YES];
            }
            if ([event keyCode] == 51) { // DELETE
                if (n >= 1) {
                    x[m] = y[m] = R[m] = V[m] = t[m] = a[m] = 0;
                    if (m != n){
                        for (int z = m + 1; z <= n; z++) {
                            x[z-1] = x[z];
                            y[z-1] = y[z];
                            R[z-1] = R[z];
                            V[z-1] = V[z];
                            t[z-1] = t[z];
                            a[z-1] = a[z];
                        }
                    }
                    if (m != 0) m--;
                    n--;
                    V[m] = 1;
                    [self setNeedsDisplay:YES];
                }
                NSLog(@"Удаление");
            }
            if ([event keyCode] == 49) { // SPACE
                if (f == 0) {
                    f = 1;
                    NSLog(@"Режим отражения по горизонтали");
                }
                else {
                    f = 0;
                    NSLog(@"Режим отражения по вертикали");
                }
            }
            if ([event keyCode] == 26) { // 7
                CGFloat maxY = CGFLOAT_MIN;
                for(int i = 0; i < n; i++) {
                    if (y[i] + R[i] > maxY) {
                        maxY = y[i] + R[i];
                    }
                }
                for(int i = 0; i < n; i++) {
                    y[i] = maxY - R[i];
                }
                [self setNeedsDisplay:YES];
                NSLog(@"Равнение всех фигур по горизонтали на равне с самой верхней");
            }
        }
    }
}

- (void)mouseDown:(NSEvent *)event { // LEFT CLICK MOUSE
    if (!isAnimating) {
        NSPoint point = [self convertPoint:[event locationInWindow] fromView:nil];
        x[m] = point.x;
        y[m] = point.y;
        NSLog(@"Перемещение фигуры в точку клика");

        [self setNeedsDisplay:YES];
    }
}

- (void)rightMouseDown:(NSEvent *)event { // RIGHT CLICK MOUSE
    if (!isAnimating) {
        NSPoint point = [self convertPoint:[event locationInWindow] fromView:nil];
        if (t[m]) {
            if (f == 1) {
                x[m] = x[m] + 2 * (point.x - x[m]);
                y[m] = y[m];
                NSLog(@"Отражение фигуры по горизонтали");
            }
            else {
                R[m] = -R[m];
                x[m] = x[m];
                y[m] = y[m] + 2 * (point.y - y[m]);
                NSLog(@"Отражение фигуры по вертикали");
            }
        }
        [self setNeedsDisplay:YES];
    }
}

- (void)drawRect:(NSRect)dirtyRect { // DRAWING FIGURE
    [super drawRect:dirtyRect];
    for (int i = 0; i < n + 1; i++) {
        NSBezierPath *path = [NSBezierPath bezierPath];
        [[NSColor redColor] setFill];
        if (V[i] == 1) {
            if (t[i] == 1) {
                [path moveToPoint:NSMakePoint(x[i] - R[i] * sin(a[i]), y[i] - R[i] * cos(a[i]))];
                [path lineToPoint:NSMakePoint(x[i] - R[i] * cos(p / 6 + a[i]), y[i] + R[i] * sin(p / 6 + a[i]))];
                [path lineToPoint:NSMakePoint(x[i] + R[i] * cos(p / 6 - a[i]), y[i] - R[i] * sin(a[i] - p / 6))];
                [path lineToPoint:NSMakePoint(x[i] - R[i] * sin(a[i]), y[i] - R[i] * cos(a[i]))];
                [path closePath];
                [path stroke];
                [path fill];
            }
            if (t[i] == 2) {
                [path moveToPoint:NSMakePoint(x[i] - R[i] * cos(p / 4 - a[i]), y[i] - R[i] * cos(p / 4 + a[i]))];
                [path lineToPoint:NSMakePoint(x[i] - R[i] * cos(p / 4 + a[i]), y[i] + R[i] * sin(p / 4 + a[i]))];
                [path lineToPoint:NSMakePoint(x[i] + R[i] * cos(p / 4 - a[i]), y[i] - R[i] * sin(a[i] - p / 4))];
                [path lineToPoint:NSMakePoint(x[i] + R[i] * cos(p / 4 + a[i]), y[i] - R[i] * sin(p / 4 + a[i]))];
                [path lineToPoint:NSMakePoint(x[i] - R[i] * cos(p / 4 - a[i]), y[i] - R[i] * cos(p / 4 + a[i]))];
                [path closePath];
                [path stroke];
                [path fill];
            }
            if (t[i] == 3) {
                [path moveToPoint:NSMakePoint(x[i] - R[i] * sin(a[i]), y[i] - R[i] * cos(a[i]))];
                [path lineToPoint:NSMakePoint(x[i] - R[i] * cos(a[i]), y[i] + R[i] * sin(a[i]))];
                [path lineToPoint:NSMakePoint(x[i] + R[i] * sin(a[i]), y[i] + R[i] * cos(a[i]))];
                [path lineToPoint:NSMakePoint(x[i] + R[i] * cos(a[i]), y[i] - R[i] * sin(a[i]))];
                [path lineToPoint:NSMakePoint(x[i] - R[i] * sin(a[i]), y[i] - R[i] * cos(a[i]))];
                [path closePath];
                [path stroke];
                [path fill];
            }
        }
        else {
            if (t[i] == 1) {
                [path moveToPoint:NSMakePoint(x[i] - R[i] * sin(a[i]), y[i] - R[i] * cos(a[i]))];
                [path lineToPoint:NSMakePoint(x[i] - R[i] * cos(p / 6 + a[i]), y[i] + R[i] * sin(p / 6 + a[i]))];
                [path lineToPoint:NSMakePoint(x[i] + R[i] * cos(p / 6 - a[i]), y[i] - R[i] * sin(a[i] - p / 6))];
                [path lineToPoint:NSMakePoint(x[i] - R[i] * sin(a[i]), y[i] - R[i] * cos(a[i]))];
                [path closePath];
                [path stroke];
            }
            if (t[i] == 2) {
                [path moveToPoint:NSMakePoint(x[i] - R[i] * cos(p / 4 - a[i]), y[i] - R[i] * cos(p / 4 + a[i]))];
                [path lineToPoint:NSMakePoint(x[i] - R[i] * cos(p / 4 + a[i]), y[i] + R[i] * sin(p / 4 + a[i]))];
                [path lineToPoint:NSMakePoint(x[i] + R[i] * cos(p / 4 - a[i]), y[i] - R[i] * sin(a[i] - p / 4))];
                [path lineToPoint:NSMakePoint(x[i] + R[i] * cos(p / 4 + a[i]), y[i] - R[i] * sin(p / 4 + a[i]))];
                [path lineToPoint:NSMakePoint(x[i] - R[i] * cos(p / 4 - a[i]), y[i] - R[i] * cos(p / 4 + a[i]))];
                [path closePath];
                [path stroke];
            }
            if (t[i] == 3) {
                [path moveToPoint:NSMakePoint(x[i] - R[i] * sin(a[i]), y[i] - R[i] * cos(a[i]))];
                [path lineToPoint:NSMakePoint(x[i] - R[i] * cos(a[i]), y[i] + R[i] * sin(a[i]))];
                [path lineToPoint:NSMakePoint(x[i] + R[i] * sin(a[i]), y[i] + R[i] * cos(a[i]))];
                [path lineToPoint:NSMakePoint(x[i] + R[i] * cos(a[i]), y[i] - R[i] * sin(a[i]))];
                [path lineToPoint:NSMakePoint(x[i] - R[i] * sin(a[i]), y[i] - R[i] * cos(a[i]))];
                [path closePath];
                [path stroke];
            }
        }
    }
}
@end
