//
//  Dog.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/30/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "CreatureObject.h"
#import "DogRoute.h"

@interface Dog : CreatureObject <CreatureHealth>

+ (instancetype)dogToWorld:(SKNode *)world withPosition:(CGPoint)position forRoute:(DogRoute *)route;

- (void)move;

- (BOOL)isLowhealthLevel;
- (void)healthRegenation;

@end
