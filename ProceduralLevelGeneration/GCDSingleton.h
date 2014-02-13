//
//  GCDSingleton.h
//  Gratitude365
//
//  Created by RamotionMac on 4/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
static dispatch_once_t pred = 0; \
__strong static id _sharedObject = nil; \
dispatch_once(&pred, ^{ \
_sharedObject = block(); \
}); \
return _sharedObject; \


//Usage example:
//@implementation MySharedThing
//
//+ (id)sharedInstance
//{
//    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
//        return [[self alloc] init];
//    });
//}
//
//@end
