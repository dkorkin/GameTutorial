//
//  Key.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/30/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "LevelObject.h"

@interface Key : LevelObject

+ (instancetype)keyToWorld:(SKNode *)world atPosition:(CGPoint)position;

- (void)pickUpKey;

@end
