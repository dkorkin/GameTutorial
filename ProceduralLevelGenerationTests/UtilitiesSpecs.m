//
//  UtilitiesSpecs.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/4/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "Kiwi.h"
#import "DistanceMeasure.h"
#import "RandomGenerator.h"

SPEC_BEGIN(UtilitiesSpecs)

describe(@"DistanceMeasure Utility", ^{
    context(@"check distance counting", ^{
        it(@"should count 5 in Pitagora triangle", ^{
            CGPoint firstPoint = CGPointMake(0, 0);
            CGPoint secondPoint = CGPointMake(4, 3);
            CGFloat distance = distanceBetweenPoints(firstPoint, secondPoint);
            [[theValue(distance) should] equal:theValue(5)];
        });
    });
});

describe(@"RandomGenerator Utility", ^{
     context(@"Random number generation in range", ^{
         it(@"number should be in range", ^{
             NSInteger randomNumber = randomNumberBetweenNumbers(3, 8);
             [[theValue(randomNumber) should] beBetween:theValue(3) and:theValue(8)];
         });
         
         it(@"number should be out range", ^{
             NSInteger randomNumber = randomNumberBetweenNumbers(3, 8);
             [[theValue(randomNumber) shouldNot] beBetween:theValue(10) and:theValue(18)];
         });
     });
    
});



SPEC_END