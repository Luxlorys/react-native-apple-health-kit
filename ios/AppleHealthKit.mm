#import "AppleHealthKit.h"
#import "AppleHealthKit-Swift.h"

@implementation AppleHealthKit {
  AppleHealthKitManager *moduleImpl;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    moduleImpl = [[AppleHealthKitManager alloc] init];
  }
  return self;
}

RCT_EXPORT_MODULE()

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeAppleHealthKitSpecJSI>(params);
}

RCT_EXPORT_METHOD(getStepsCountForCurrentDay:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
  [moduleImpl getStepsCountForCurrentDayWithCompletion:^(NSNumber * _Nullable steps, NSError * _Nullable error) {
      if (steps) {
        resolve(steps);
      } else {
        reject(@"step_count_error", error.localizedDescription, error);
      }
  }];
}

RCT_EXPORT_METHOD(getStepsCountForLast30Days:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
  [moduleImpl getStepsCountForLast30DaysWithCompletion:^(NSArray * _Nullable stepsArray, NSError * _Nullable error) {
      if (stepsArray) {
        resolve(stepsArray);
      } else {
        reject(@"step_count_error", error.localizedDescription, error);
      }
  }];
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

@end
