#import "ReactNativeAppleHealthKit.h"
#import "ReactNativeAppleHealthKit-Swift.h"

@implementation ReactNativeAppleHealthKit {
  HealthKitManager *moduleImpl;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    moduleImpl = [[HealthKitManager alloc] init];
  }
  return self;
}

RCT_EXPORT_MODULE()

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeReactNativeAppleHealthKitSpecJSI>(params);
}

RCT_EXPORT_METHOD(requestHealthKitPermissions:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    [moduleImpl requestHealthKitPermissionsWithCompletion:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            resolve(@"Access granted");
        } else {
            reject(@"permission_error", error.localizedDescription, error);
        }
    }];
}

RCT_EXPORT_METHOD(getSteps:(double)daysBefore resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    [moduleImpl getStepsWithDaysBefore:@(daysBefore) completion:^(NSArray * _Nullable steps, NSError * _Nullable error) {
        if (error) {
            reject(@"steps_error", error.localizedDescription, error);
        } else {
            resolve(steps);
        }
    }];
}

RCT_EXPORT_METHOD(getHeartRate:(double)daysBefore resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    [moduleImpl getHeartRateWithDaysBefore:@(daysBefore) completion:^(NSArray * _Nullable steps, NSError * _Nullable error) {
        if (error) {
            reject(@"heart_rate_error", error.localizedDescription, error);
        } else {
            resolve(steps);
        }
    }];
}

RCT_EXPORT_METHOD(getMeasurement:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    [moduleImpl getMeasurementsWithCompletion:^(NSDictionary<NSString *, id> * _Nullable data) {
        resolve(data);
    }];
}

RCT_EXPORT_METHOD(checkAvailability:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    [moduleImpl checkAvailabilityWithCompletion:^(BOOL result) {
        resolve(@(result));
    }];
}

@end
