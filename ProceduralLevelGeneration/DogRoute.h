//
//  Route.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/31/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Map.h"
#import "Map_Private.h"
#import "CatPlayer.h"
#import "LevelObject.h"
#import "DistanceMeasure.h"

@interface DogRoute : NSObject

+ (instancetype)routeOnMap:(Map *)map andAim:(CatPlayer *)catPlayer;

- (CGPoint)movePointForDogPosition:(CGPoint)dogPosition forState:(BOOL)isLowHealth;

- (BOOL)checkForMoveAvailabilityFromPosition:(CGPoint)position;

@end
