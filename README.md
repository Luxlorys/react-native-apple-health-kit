# 📅 React Native Apple HealthKit

🔹 **React Native Apple HealthKit** Expose HealthKit API from your React Native App!

---

## 🚀 Features

- **📆 Check Availability**: Check whether HealthKit is available on current device.
- **🔒 Secure Access**: Requires user permission for accessing HealthKit data.
- **📸 Snapshot for N days**: Returns snapshot for past N days of user's: steps count & heart rate;

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

### 📆 Sample Methods

Below are the methods available in **React Native Apple HealthKit**

---

### Get steps count for past N days


📌 Example Usage

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
