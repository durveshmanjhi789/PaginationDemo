# 📱 iOS Pagination Demo App

### 🛠️ Tech Stack
- **Architecture:** MVVM (Model-View-ViewModel)
- **Framework:** UIKit
- **Design Pattern:** UITableView with custom `.xib` cell
- **Language:** Swift

### 📦 Features
- Fetches all user data from API:  
  `https://core-apis.a1apps.co/ios/interview-details`
- Pagination implemented using `visibleUsers` array from `allUsers`
- Loads 10 users initially → loads next 10 on scroll (10 → 20 → 30...)

### 🔄 Data Flow
- **Model:** User model for decoding API data.
- **APIService:** Fetches data from the API.
- **ViewModel:** Manages `allUsers`, paginates into `visibleUsers`.
- **ViewController:** Displays data using `UITableView`, loads more on scroll.

### 📌 Notes
- No third-party libraries used.
- Clean, maintainable, and scalable code.
- Designed with good separation of concerns and reusability in mind.
