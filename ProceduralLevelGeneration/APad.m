//
//  APad.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/3/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "APad.h"

@implementation APad

-(id)init {
    self = [super initWithImageNamed:@"sword.png"];
    if(self) {
        [self settings];
    }
    return  self;
}

- (void)settings {
    self.zPosition = 4.0;
    self.userInteractionEnabled = YES;
}

#pragma mark - touch event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self runAction:[SKAction fadeAlphaTo:0.5 duration:0.0]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self runAction:[SKAction fadeAlphaTo:1.0 duration:0.0]];
    [self.delegate attackPressed:self];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self runAction:[SKAction fadeAlphaTo:1.0 duration:0.0]];
}

@end
