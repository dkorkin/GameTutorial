//
//  HealthHolderSpecs.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/12/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "Kiwi.h"
#import "HealthHolder.h"


SPEC_BEGIN(HealthHolderSpecs)

describe(@"Health Manager", ^{
    
    context(@"Manager Initialization", ^{
        it(@"cat health should be full", ^{
            [[theValue([HealthHolder sharedHolder].catHealth) should] equal:theValue(kCatFullHealth)];
        });
        it(@"dog health should be full", ^{
            [[theValue([HealthHolder sharedHolder].dogHealth) should] equal:theValue(kDogFullHealth)];
        });
    });
    
});

SPEC_END