//
//  YLTransparentView.m
//  ShameOnMe
//
//  Created by hypor on 12/3/08.
//  Copyright 2008 Bigs Hypo. All rights reserved.
//

#import "YLTransparentView.h"


@implementation YLTransparentView

- (id) initWithFrame: (NSRect)frame 
{
    self = [super initWithFrame: frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void) drawRect: (NSRect)rect 
{
//    [[self window] setOpaque: NO];
//    [[self window] _setContentHasShadow: NO];

    [[NSColor clearColor] set];
    NSRectFill(rect);
}

- (BOOL) isOpaque
{
    return YES;
}

@end
