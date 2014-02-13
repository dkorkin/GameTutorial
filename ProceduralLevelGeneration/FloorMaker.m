//
//  FloorMaker.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/28/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "FloorMaker.h"

@implementation FloorMaker

- (instancetype)initWithCurrentPosition:(CGPoint)currentPosition andDirection:(FloorDirectionType)direction {
    self = [super init];
    
    if (self) {
        _currentPosition = currentPosition;
        _direction = direction;
    }
    return self;
}

@end
