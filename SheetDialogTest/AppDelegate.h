//
//  AppDelegate.h
//  SheetDialogTest
//
//  Created by 河野 さおり on 2014/07/30.
//  Copyright (c) 2014年 Saori Kohno. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SheetWin2Ctr.h"
#import "ModalWinCtr.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    IBOutlet NSWindow *mainWindow;
    IBOutlet NSWindow *sheetWin;
    IBOutlet NSTextField *txtField;
}

@property (weak) IBOutlet NSWindow *statusWin;
@property (strong)SheetWin2Ctr *mySheetWinCtr;
@property (strong)ModalWinCtr *myModalWinCtr;

@end
