//
//  DogRoute_Private.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/12/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "DogRoute.h"

@interface DogRoute ()

- (CGPoint)randomPointForDogPosition:(CGPoint)dogPosition;
- (CGPoint)huntingPointForDogPosition:(CGPoint)dogPosition forState:(BOOL)isLowHealth;

@end
