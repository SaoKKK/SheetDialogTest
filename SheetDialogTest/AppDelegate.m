//
//  AppDelegate.m
//  SheetDialogTest
//
//  Created by 河野 さおり on 2014/07/30.
//  Copyright (c) 2014年 Saori Kohno. All rights reserved.
//

#import "AppDelegate.h"

static const NSInteger SHEET1_OK		= 128;
static const NSInteger SHEET1_CANCEL	= 129;

@implementation AppDelegate

@synthesize statusWin,mySheetWinCtr,myModalWinCtr;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)pshOpenPanel:(id)sender {
    NSOpenPanel *openpanel = [NSOpenPanel openPanel];
    //openPanelのパラメータを設定
    NSArray *fileTypes = [NSArray arrayWithObjects:@"pdf", nil];
    [openpanel setAllowedFileTypes:fileTypes]; //選択できるファイルの種類
    //[openpanel setCanChooseFiles:NO]; //ファイルの選択の可否
    //[openpanel setCanChooseDirectories:NO]; //ディレクトリの選択の可否
    //[openpanel setResolvesAliases:NO]; //エイリアス解析の可否
    [openpanel setShowsHiddenFiles:YES]; //隠しファイル表示の可否
    [openpanel setAllowsMultipleSelection:YES]; //複数ファイル選択の可否
    [openpanel setPrompt:@"Add"]; //ボタンのタイトル
    [openpanel setMessage:@"Choose files."]; //表示するメッセージテキスト
    [openpanel beginSheetModalForWindow:mainWindow completionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            NSArray *urls = [openpanel URLs];
            [txtField setStringValue:[[urls objectAtIndex:0]path]];
        }
    }];
}

- (IBAction)pshSavePanel:(id)sender {
    NSSavePanel *savepanel = [NSSavePanel savePanel];
    //savePanelのパラメータを設定
    NSArray *fileTypes = [NSArray arrayWithObjects:@"pdf", nil];
    [savepanel setAllowedFileTypes:fileTypes]; //保存するファイルの種類
    [savepanel setNameFieldStringValue:@"YourFileName"]; //初期ファイル名
    [savepanel setNameFieldLabel:@"Save As:"]; //ファイル名テキストフィールドのラベル
    [savepanel setMessage:@"Save your file."]; //表示するメッセージテキスト
    [savepanel setCanCreateDirectories:NO]; //フォルダ作成ボタンの有無
    [savepanel setShowsHiddenFiles:YES]; //隠しファイル表示の可否
    //[savepanel setShowsTagField:NO]; //タグフィールドの有無
    [savepanel setTreatsFilePackagesAsDirectories:YES]; //パッケージをディレクトして扱うかの可否
    [savepanel setTagNames:[NSArray arrayWithObjects:@"User'sFile", nil]]; //タグフィールドのデフォルト値
    //[savepanel setCanSelectHiddenExtension:YES]; //拡張子を隠すチェックボックスの有無
    //[savepanel setExtensionHidden:NO]; //拡張子を隠すチェックボックスの初期ステータス
    [savepanel beginSheetModalForWindow:mainWindow completionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            NSURL *url = [savepanel URL];
            [txtField setStringValue:[url path]];
        }
    }];
}

#pragma mark - custom sheet panel of the same xib file

- (IBAction)pshShowDialog:(id)sender {
    [mainWindow beginSheet:sheetWin completionHandler:^(NSInteger returnCode){
        if (returnCode == SHEET1_OK) {
            NSLog(@"Sheet1ok");
        } else {
            NSLog(@"Sheet1Cancel");
        }
    }];
}
     
- (IBAction)sheetOk:(id)sender {
    [mainWindow endSheet:sheetWin returnCode:SHEET1_OK];
}

- (IBAction)sheetCancel:(id)sender {
    [mainWindow endSheet:sheetWin returnCode:SHEET1_CANCEL];
}

#pragma mark - custom sheet panel of another xib file

- (IBAction)pshShowSheet2:(id)sender {
    self.mySheetWinCtr = [[SheetWin2Ctr alloc]initWithWindowNibName:@"SheetWin2Ctr"];
    [mainWindow beginSheet:self.mySheetWinCtr.window completionHandler:^(NSModalResponse returnCode){
        if (returnCode == NSModalResponseOK) {
            NSLog(@"Sheet2ok");
        } else {
            NSLog(@"sheet2cancel");
        }
        self.mySheetWinCtr = nil;
    }];
}

#pragma mark - custom modal dialog

- (IBAction)pshMyModalWin:(id)sender {
    self.myModalWinCtr = [[ModalWinCtr alloc]initWithWindowNibName:@"ModalWinCtr"];
    NSModalResponse returnCode = [NSApp runModalForWindow:self.myModalWinCtr.window];
    if (returnCode == NSModalResponseOK) {
        NSLog(@"CustomModalDialogOK");
    } else {
        NSLog(@"CustomModalDialogCancel");
    }
    [NSApp endSheet:myModalWinCtr.window];
    [myModalWinCtr.window orderOut:self];
}

#pragma mark - alert sheet & modal dialog

- (IBAction)pshShowSheet3:(id)sender {
    NSAlert *alert = [self setAlert];
    [alert beginSheetModalForWindow:mainWindow completionHandler:^(NSModalResponse returnCode){
        if (returnCode == NSAlertFirstButtonReturn) {
            NSLog(@"alertOK");
        } else {
            NSLog(@"alertCancel");
        }
    }];
}

- (IBAction)pshAlertModalDialog:(id)sender {
    NSAlert *alert = [self setAlert];
    NSModalResponse returnCode = [alert runModal];
    if (returnCode == NSAlertFirstButtonReturn) {
        NSLog(@"alertModalOK");
    } else {
        NSLog(@"alertModalCancel");
    }
}

- (NSAlert*)setAlert{
    NSAlert *alert = [[NSAlert alloc]init];
    alert.messageText = @"Alert";
    [alert addButtonWithTitle:@"OK"];
    [alert addButtonWithTitle:@"Cancel"];
    [alert setInformativeText:@"NSWarningAlertStyle \rDo you want to continue with delete of selected records?"];
    [alert setAlertStyle:NSCriticalAlertStyle];
    return alert;
}

#pragma mark - status panel

- (IBAction)pshShowStatus:(id)sender {
    [statusWin setFrame:NSMakeRect(mainWindow.frame.origin.x + mainWindow.frame.size.width*0.5 - statusWin.frame.size.width*0.5, mainWindow.frame.origin.y + ((mainWindow.frame.size.height - statusWin.frame.size.height)*0.5), statusWin.frame.size.width, statusWin.frame.size.height) display:NO];
    [statusWin setLevel:NSFloatingWindowLevel];
    [statusWin orderFront:self];
    [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(closeStatusWin) userInfo:nil repeats:NO];
}

- (void)closeStatusWin{
    [statusWin orderOut:self];
}

@end
