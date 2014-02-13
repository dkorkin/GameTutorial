//
//  DistanceMeasure.h
//  ProceduralLevelGeneration
//
//  Created by Dmitriy Korkin on 2/3/14.
//  Copyright (c) 2014 Kim Pedersen. All rights reserved.
//

#ifndef ProceduralLevelGeneration_DistanceMeasure_h
#define ProceduralLevelGeneration_DistanceMeasure_h

NS_INLINE CGFloat distanceBetweenPoints(CGPoint p1, CGPoint p2) {
    return sqrtf(powf((p2.x - p1.x), 2) + powf((p2.y - p1.y), 2));
}

#endif
