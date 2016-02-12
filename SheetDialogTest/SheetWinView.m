//
//  SheetWinView.m
//  SheetDialogTest
//
//  Created by 河野 さおり on 2016/02/12.
//  Copyright © 2016年 Saori Kohno. All rights reserved.
//

#import "SheetWinView.h"
#import "AppDelegate.h"

@interface SheetWinView ()

@end

@implementation SheetWinView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)btnOK:(id)sender {
    AppDelegate *appD = [[NSApplication sharedApplication]delegate];
    [[NSApplication sharedApplication] endSheet:appD.sheetWin2 returnCode:SHEET2_OK];
}

@end
