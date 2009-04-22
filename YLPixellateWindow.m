//
//  YLPixellateWindow.m
//  ShameOnMe
//
//  Created by hypor on 12/3/08.
//  Copyright 2008 Bigs Hypo. All rights reserved.
//

#import "YLPixellateWindow.h"
#import <QuartzCore/QuartzCore.h>
#import <ApplicationServices/ApplicationServices.h>

typedef void * CGSConnectionID;
extern OSStatus CGSNewConnection(const void **attr, CGSConnectionID *id);
extern OSStatus CGSNewCIFilterByName(CGSConnectionID, CFStringRef, uint32_t *);
extern OSStatus CGSSetCIFilterValuesFromDictionary(CGSConnectionID, uint32_t, CFDictionaryRef);
extern OSStatus CGSAddWindowFilter(CGSConnectionID, NSInteger, uint32_t, int);

@implementation YLPixellateWindow
- (id) initWithContentRect: (NSRect)contentRect styleMask: (unsigned int)aStyle backing: (NSBackingStoreType)bufferingType defer: (BOOL)flag 
{
    NSWindow *result = [super initWithContentRect: contentRect styleMask: /*NSBorderlessWindowMask*/aStyle backing: NSBackingStoreBuffered defer: NO];
    [result setBackgroundColor: [NSColor whiteColor]];
    [result setLevel: kCGNumberOfWindowLevelKeys - 1];
    [result setAlphaValue: 0.1];
    [result setOpaque: NO];
    [result setHasShadow: YES];
//    [result _setContentHasShadow: NO];
    
    //*
    CGSConnectionID _myConnection;
    uint32_t __compositingFilter;
    
    int __compositingType = 1;
    CGSNewConnection(NULL , &_myConnection);

    NSDictionary *optionsDict;
//*
    CGSNewCIFilterByName(_myConnection, (CFStringRef)@"CIPixellate", &__compositingFilter);
    optionsDict = [NSDictionary dictionaryWithObject: [NSNumber numberWithFloat: 10.0] forKey: @"inputScale"];
/*/
    CGSNewCIFilterByName(_myConnection, (CFStringRef)@"CIGaussianBlur", &__compositingFilter);
    optionsDict = [NSDictionary dictionaryWithObject: [NSNumber numberWithFloat: 5.0] forKey: @"inputRadius"];
/**/    
    CGSSetCIFilterValuesFromDictionary(_myConnection, __compositingFilter, (CFDictionaryRef)optionsDict);
    CGSAddWindowFilter(_myConnection, [result windowNumber], __compositingFilter, __compositingType);

    return result;
    
}    

- (BOOL) canBecomeKeyWindow
{
    return YES;
}
/*
- (void) mouseDragged: (NSEvent *)theEvent
{
    NSPoint currentLocation;
    NSPoint newOrigin;
    NSRect  screenFrame = [[NSScreen mainScreen] frame];
    NSRect  windowFrame = [self frame];
    
    //grab the current global mouse location; we could just as easily get the mouse location 
    //in the same way as we do in -mouseDown:
    currentLocation = [self convertBaseToScreen: [self mouseLocationOutsideOfEventStream]];
    newOrigin.x = currentLocation.x - initialLocation.x;
    newOrigin.y = currentLocation.y - initialLocation.y;
    
    // Don't let window get dragged up under the menu bar
    if ((newOrigin.y + windowFrame.size.height) > (screenFrame.origin.y + screenFrame.size.height)) {
        newOrigin.y = screenFrame.origin.y + (screenFrame.size.height - windowFrame.size.height);
    }
    
    //go ahead and move the window to the new location
    [self setFrameOrigin: newOrigin];
}

//We start tracking the a drag operation here when the user first clicks the mouse,
//to establish the initial location.
- (void) mouseDown: (NSEvent *)theEvent
{    
    NSRect windowFrame = [self frame];
    
    //grab the mouse location in global coordinates
    initialLocation = [self convertBaseToScreen: [theEvent locationInWindow]];
    initialLocation.x -= windowFrame.origin.x;
    initialLocation.y -= windowFrame.origin.y;
}
/**/
@end
