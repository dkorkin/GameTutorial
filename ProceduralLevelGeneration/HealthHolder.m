//
//  HealthHolder.m
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/3/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#import "HealthHolder.h"
#import "GCDSingleton.h"

CGFloat const kCatFullHealth = 10.0;
CGFloat const kDogFullHealth = 10.0;

@implementation HealthHolder

+ (instancetype)sharedHolder {
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

- (id)init {
    self = [super init];
    if(self) {
        _catHealth = kCatFullHealth;
        _dogHealth = kDogFullHealth;
    }
    return self;
}

@end
