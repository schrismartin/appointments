# Appointments
A simple iOS app showing a list of appointments

| iPhone Light | iPhone Dark | iPad Light | iPad Dark |
|:---:|:---:|:---:|:---:|
| <img width="564" alt="CleanShot 2023-06-05 at 19 07 50@2x" src="https://github.com/schrismartin/appointments/assets/7174994/eafe1fcf-220d-4068-b1b9-2049e3e85ca0"> | <img width="564" alt="CleanShot 2023-06-05 at 19 07 52@2x" src="https://github.com/schrismartin/appointments/assets/7174994/49d2efd0-3a17-4bea-98dc-80b49d4f0567"> | <img width="995" alt="CleanShot 2023-06-05 at 19 07 54@2x" src="https://github.com/schrismartin/appointments/assets/7174994/72697507-76bc-4e62-a87a-b2dfebb01404"> | <img width="995" alt="CleanShot 2023-06-05 at 19 07 57@2x" src="https://github.com/schrismartin/appointments/assets/7174994/f3afe60c-7124-41bd-853c-a86e7be09359"> |

## Installation

The dependencies are managed via Swift Package Manager. The project was developed using Xcode 14.3. Opening the project on Xcode 14.3 and higher 
will automatically download and resolve all package dependencies.

## Build & Run

Run the project using the **Appointments** scheme. 

## Testing

This project has two sets of tests:
- **AppointmentsFeatureTests** – A set of unit tests that cover the TCA stores powering the Appointments feature.
- **ApplicationSnapshotTests** – A set of snapshot tests creating images that cover the populated and empty states for the appointments feature.

> **Note**
> Snapshot tests must be run on an iPhone 14 simulator in order to pass.

# Developer Notes

Additionally, this comes packaged with a single Swift Package that drives the application, including...
- `APIClient` – A basic API client
- `Application` – An applicaiton wrapper containing the tab bar
- `AppointmentsFeature` – The self-contained feature containing the Appointments screen.
- `Primitives` – A small collection of tools used to add resilience to parsing and some testing helpers
- `StyleGuide` – The fonts, button styles, colors, and reusable views

You'll want to inspect the `AppointmentsFeature` as the primary feature for the app. This has views and stores for
- The screen (x1)
- The card (x1)
  - Each configuration (x4)
