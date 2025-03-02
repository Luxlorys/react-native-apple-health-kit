# 📅 React Native Apple HealthKit

🔹 **React Native Apple HealthKit** A React Native package to interact with Apple HealthKit for iOS.
This package allows access to health & fitness data exposed by Apple Healthkit.

---

## 🚀 Features

- **📆 Check Availability**: Check whether HealthKit is available on current device.
- **🔒 Secure Access**: Requires user permission for accessing HealthKit data.
- **📸 Snapshot for N days**: Returns a snapshot for past N days of user's: steps count & heart rate;

---

## 🛠️ Prerequisites

Before getting started, ensure you have:

- React Native version `0.75+`
- **iOS 13++** (Native API support)
- new architecture support

---

## 📦 Installation

Run the following command to install the package:

```bash
npm install @gromozeqa/react-native-apple-health-kit

yarn add @gromozeqa/react-native-apple-health-kit

cd ios && pod install
```

Edit **`Info.plist`**. Add the following item (Set **Value** as desired):

| Key                                     | Type     | Value                                                                              |
| --------------------------------------- | -------- | ---------------------------------------------------------------------------------- |
| _Privacy - NSHealthShareUsageDescription_ | `String` | _CHANGEME: This app requires read access to your Health data._ |


### To add Healthkit support to your application's Capabilities ###

Open the ios/ folder of your project in Xcode
Select the project name in the left sidebar
In the main view select '+ Capability' and double click 'HealthKit'

📌 Example Usage

✅ Request Permissions

To check the current status of calendar permissions, use:

```ts
import { requestHealthKitPermissions } from '@gromozeqa/react-native-apple-health-kit';

const requestPermissions = async () => {
    const status = await requestHealthKitPermissions();
    console.log(status);
  };
```

### 📆 Methods

Below are the methods available in **React Native Apple HealthKit**

---

### Get steps count for past N days


📌 **Get steps count for past N days**

```ts
import { getSteps } from '@gromozeqa/react-native-apple-health-kit';

const getStepsCount = async () => {
    try {
      const steps = await getSteps(30);
      console.log(steps);
    } catch (error) {
      console.log(error);
    }
  };
```

📌 **Get heart rate for past N days**

```ts
import { getHeartRate } from '@gromozeqa/react-native-apple-health-kit';

const getUsersHeartRate = async () => {
    try {
      const steps = await getHeartRate(30);
      console.log(steps);
    } catch (error) {
      console.log(error);
    }
  };
```

📌 **Get user's body measurement**

```ts
import { getMeasurement } from '@gromozeqa/react-native-apple-health-kit';

const getUserMeasurement = async () => {
    try {
      const steps = await getMeasurement();
      console.log(steps);
    } catch (error) {
      console.log(error);
    }
  };
```

### ⚠️Permissions ###
Due to Apple's privacy model, if a user has previously denied a specific permission they will not be prompted again for that permission. The user will need to go into the Apple Health app and grant the permission to your app.

If read permissions are not granted for the requested data, the method will return an empty array.
