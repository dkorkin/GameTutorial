//
//  FloarMakerSpecs.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 1/28/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "Kiwi.h"
#import "FloorMaker.h"

SPEC_BEGIN(FloarMakerSpecs)

describe(@"object initialization", ^{
    __block FloorMaker *floor = nil;
    __block CGPoint initialPoint = CGPointMake(10, 10);
    __block NSInteger direction = 3;
    
    context(@"Check FloorMaker Initialization", ^{
        
        context(@"when shot values aren't set", ^{
            it(@"direction should be 0", ^{
                [[theValue(floor.direction) should] equal:theValue(0)];
            });
            
            it(@"direction should be 0", ^{
                [[theValue(floor.currentPosition.x) should] equal:theValue(0)];
            });
            
            it(@"direction should be 0", ^{
                [[theValue(floor.currentPosition.y) should] equal:theValue(0)];
            });
        });
        
        context(@"when shot values are setuped", ^{
            it(@"current position x should be setuped", ^{
                 floor = [[FloorMaker alloc] initWithCurrentPosition:initialPoint andDirection:direction];
                [[theValue(floor.currentPosition.x) should] equal:theValue(initialPoint.x)];
            });
            
            it(@"current position y should be setuped", ^{
                floor = [[FloorMaker alloc] initWithCurrentPosition:initialPoint andDirection:direction];
                [[theValue(floor.currentPosition.y) should] equal:theValue(initialPoint.y)];
            });
            
            it(@"direction should be setuped", ^{
                floor = [[FloorMaker alloc] initWithCurrentPosition:initialPoint andDirection:direction];
                [[theValue(floor.direction) should] equal:theValue(direction)];
            });
            
        });
        
    });
});


SPEC_END
