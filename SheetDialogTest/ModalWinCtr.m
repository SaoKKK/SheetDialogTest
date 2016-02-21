//
//  ModalWinCtr.m
//  SheetDialogTest
//
//  Created by 河野 さおり on 2016/02/21.
//  Copyright © 2016年 Saori Kohno. All rights reserved.
//

#import "ModalWinCtr.h"

@interface ModalWinCtr ()

@end

@implementation ModalWinCtr

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (IBAction)pshOK:(id)sender {
    [NSApp endSheet:self.window returnCode:NSModalResponseOK];
}

- (IBAction)pshCancel:(id)sender {
    [NSApp endSheet:self.window returnCode:NSModalResponseCancel];
}

@end
