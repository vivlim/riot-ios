//
//  KeyboardGrowingTextView.m
//  Riot
//
//  Created by Vivian Lim on 9/17/17.
//  Copyright © 2017 matrix.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HPGrowingTextView.h>
#import "RoomInputToolbarView.h"

@interface KeyboardGrowingTextView: HPGrowingTextView
- (NSArray<UIKeyCommand *> *)keyCommands;
@end

@implementation KeyboardGrowingTextView

- (NSArray<UIKeyCommand *> *)keyCommands {
    return @[
             [UIKeyCommand keyCommandWithInput:@"\r" modifierFlags:0 action:@selector(keyCommandSelector:)]
            ];
}

- (void)keyCommandSelector:(UIKeyCommand *)sender {
    if ([sender.input isEqualToString:@"\r"]){
        // traverse the view hierarchy to get the RoomInputToolbarView
        UIView *sv = [self superview];
        int remainingDepth = 3; // give up after going up 3 levels.
    
        while((sv = [sv superview]) && remainingDepth > 0) {
            if ([sv class] == [RoomInputToolbarView class]){
                RoomInputToolbarView *ritv = (RoomInputToolbarView *)sv;
                [ritv onTouchUpInside:ritv.rightInputToolbarButton]; // touch the Send button.
                return;
            }
            remainingDepth--;
        }
    }
}

@end
