//
//  AppDelegate.m
//  SheetDialogTest
//
//  Created by 河野 さおり on 2014/07/30.
//  Copyright (c) 2014年 Saori Kohno. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize sheetWin2,contentViewCtr;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (void)sheetDidEnd:(NSWindow*)sheet returnCode:(int)returnCode contextInfo:(void*)contextInfo{
    [sheet orderOut:self];
    if(returnCode == SHEET1_OK) {
        //Sheet1でOKボタンが押された
        NSLog(@"Sheet1ok");
        return;
    } else if (returnCode == SHEET1_CANCEL) {
        //Sheet1でキャンセルボタンが押された
        NSLog(@"Sheet1cancel");
    } else if (returnCode == SHEET2_OK) {
        //Sheet2でOKボタンが押された
        NSLog(@"Sheet2OK");
    } else {
        //Sheet3でOKボタンが押された
        NSLog(@"Sheet3OK");
    }
}

- (IBAction)pshOpenPanel:(id)sender {
    NSOpenPanel *openpanel = [NSOpenPanel openPanel];
    //openPanelのパラメータを設定
    NSArray *fileTypes = [NSArray arrayWithObjects:@"pdf", nil];
    [openpanel setAllowedFileTypes:fileTypes]; //選択できるファイルの種類
    //[openpanel setCanChooseFiles:NO]; //ファイルの選択の可否
    [openpanel setCanChooseDirectories:NO]; //ディレクトリの選択の可否
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
    [savepanel setDirectoryURL:NO]; //初期表示でディレクトリの内容表示の可否
    [savepanel setTreatsFilePackagesAsDirectories:YES]; //パッケージをディレクトして扱うかの可否
    [savepanel setTagNames:[NSArray arrayWithObjects:@"User'sFile", nil]]; //タグフィールドのデフォルト値
    [savepanel setCanSelectHiddenExtension:YES]; //拡張子を隠すチェックボックスの有無
    [savepanel setExtensionHidden:NO]; //拡張子を隠すチェックボックスの初期ステータス
    [savepanel beginSheetModalForWindow:mainWindow completionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            NSURL *url = [savepanel URL];
            [txtField setStringValue:[url path]];
        }
    }];
}

- (IBAction)pshShowDialog:(id)sender {
    [[NSApplication sharedApplication] beginSheet:sheetWin modalForWindow:mainWindow modalDelegate:self didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:nil];
}
- (IBAction)sheetOk:(id)sender {
    [[NSApplication sharedApplication] endSheet:sheetWin returnCode:SHEET1_OK];
}

- (IBAction)sheetCancel:(id)sender {
    [[NSApplication sharedApplication] endSheet:sheetWin returnCode:SHEET1_CANCEL];
}
- (IBAction)pshShowSheet2:(id)sender {
    [sheetWin2 setFrame:NSMakeRect(0,0,300, 100) display:NO];
    [self loadView:@"SheetWinView"];
    [[NSApplication sharedApplication] beginSheet:sheetWin2 modalForWindow:mainWindow modalDelegate:self didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

- (IBAction)pshShowSheet3:(id)sender {
    [sheetWin2 setFrame:NSMakeRect(0,0,400, 200) display:NO];
    [self loadView:@"SheetWinView2"];
    [[NSApplication sharedApplication] beginSheet:sheetWin2 modalForWindow:mainWindow modalDelegate:self didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

- (void)loadView:(NSString *)viewName{
    if(contentViewCtr){
        [[contentViewCtr view] removeFromSuperview];
    }
    contentViewCtr = [[NSViewController alloc]initWithNibName:viewName bundle:nil];
    NSView *view = [contentViewCtr view];
    [contentView addSubview:view];
}

@end
