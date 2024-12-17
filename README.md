# 📋 Project Description 

Testtask is an iOS application developed according to the given test assignment by [abz.agency](https://abz.agency). The project is built using VIPER architecture and provides functionality for working with REST API to display and register users.

## ⚙️ Technologies and Libraries

The project utilizes the following technologies and tools:
- UIKit: Main framework for building the user interface.
- VIPER: Architecture for modular and scalable code.
- Kingfisher: Loading and caching images from the network.
- SnapKit: Simplified Auto Layout management programmatically.
- Swift Package Manager (SPM): Dependency management tool for external libraries.

## 🚀 App Functionality
1.	User List (GET Request):
- Pagination: Load users in pages (6 users per page).
- Sorting: Users are displayed in descending order of registration date (newest first).
2. User Registration (POST Request):
- Form validation as per the API requirements.
- Submit user data to the server and automatically refresh the user list after successful registration.
3. Offline Mode:
- Display an appropriate screen when there’s no internet connection.

## 🔧 Installation and Build
1.	Clone the repository:
```
git clone https://github.com/username/Testtask.git
cd Testtask
```

## 🕒 Time Spent
- Total hours spent: 16 hours
- Challenges faced: Working with POST requests

## 📧 Contacts

Author: Danila Okunev
Email: danila@okuneu.com

### Dependencies  
- [SnapKit](https://github.com/SnapKit/SnapKit): For Auto Layout constraints.  
- [Kingfisher](https://github.com/onevcat/Kingfisher): To load and cache images efficiently.
