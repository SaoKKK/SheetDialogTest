//
//  CCBackGroundView.m
//  SheetDialogTest
//
//  Created by 河野 さおり on 2014/07/30.
//  Copyright (c) 2014年 Saori Kohno. All rights reserved.
//

#import "CCBackGroundView.h"

@implementation CCBackGroundView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    //描画色の設定
    NSColor *color = [NSColor colorWithCalibratedRed:0.1 green:0.1 blue:0.1 alpha:0.5];
    [color set];
    //図形の設定
	NSRect frame = NSInsetRect(dirtyRect, 0, 0);
	NSBezierPath* path = [NSBezierPath bezierPathWithRoundedRect:frame xRadius:10 yRadius:10];
    //塗りつぶし
	[path fill];
    //ただの四角でいいならこっち。図形の設定は必要ない
    //[NSBezierPath fillRect:dirtyRect];
}

@end
