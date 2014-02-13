//
//  DogRouteSpecs.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/12/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "Kiwi.h"
#import "DogRoute.h"
#import "DogRoute_Private.h"
#import "DistanceMeasure.h"


SPEC_BEGIN(DogRouteSpecs)

describe(@"Dog Route", ^{
    
    DogRoute *dogRoute = [DogRoute new];
    
    context(@"Random point test", ^{
        it(@"should be at a distance radius", ^{
            CGPoint startPoint = CGPointMake(64, 64);
            CGPoint finishPoint = [dogRoute randomPointForDogPosition:startPoint];
            CGFloat distance = distanceBetweenPoints(startPoint, finishPoint);
            [[@(distance) should] beLessThan:@33];
        });
    });
    
    context(@"Hunting point test", ^{
        it(@"should be at a distance radius", ^{
            CGPoint startPoint = CGPointMake(64, 64);
            CGPoint finishPoint = [dogRoute huntingPointForDogPosition:startPoint forState:YES];
            CGFloat distance = distanceBetweenPoints(startPoint, finishPoint);
            [[@(distance) should] beLessThan:@33];
        });
    });
});

SPEC_END
