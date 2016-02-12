//
//  AppDelegate.h
//  SheetDialogTest
//
//  Created by 河野 さおり on 2014/07/30.
//  Copyright (c) 2014年 Saori Kohno. All rights reserved.
//

#import <Cocoa/Cocoa.h>

static const int SHEET1_OK		= 128;
static const int SHEET1_CANCEL	= 129;
static const int SHEET2_OK      = 130;
static const int SHEET3_OK      = 131;

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    IBOutlet NSWindow *mainWindow;
    IBOutlet NSWindow *sheetWin;
    IBOutlet NSTextField *txtField;
    IBOutlet NSView *contentView;
}

@property (weak) IBOutlet NSWindow *sheetWin2;
@property (readonly,nonatomic) NSViewController *contentViewCtr;

- (void)sheetDidEnd:(NSWindow*)sheet returnCode:(int)returnCode contextInfo:(void*)contextInfo;

@end
