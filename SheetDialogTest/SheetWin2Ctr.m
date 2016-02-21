//
//  SheetWin2Ctr.m
//  SheetDialogTest
//
//  Created by 河野 さおり on 2016/02/21.
//  Copyright © 2016年 Saori Kohno. All rights reserved.
//

#import "SheetWin2Ctr.h"

@interface SheetWin2Ctr ()

@end

@implementation SheetWin2Ctr

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (IBAction)sheet2OK:(id)sender {
    [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseOK];
}

- (IBAction)sheet2Cancel:(id)sender {
    [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseCancel];
}

@end
