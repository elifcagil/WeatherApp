# 🌦️ WeatherApp

**WeatherApp** is a simple, stylish, and user-friendly iOS application that allows users to get real-time weather information by entering a city name or using their current location.  
The app is built using the **OpenWeatherMap API**, and it is enhanced with **Lottie animations**, modern UI design, and vibrant colors to improve the user experience.

---

## 📱 Features

- 🔍 Weather search by city name  
- 📍 One-tap weather info based on current location  
- 🌤️ Dynamic icon and animation display based on weather condition (Lottie)  
- 🎨 Background color is set with a custom hex code (`#0bbffb`) for a professional visual look  
- 📲 User-friendly interface, modern design, and responsive UI elements  
- ❗ Intuitive feedback with alert messages and loading animations  

---

## 🛠️ Technologies Used

- Swift  
- UIKit  
- [Alamofire](https://github.com/Alamofire/Alamofire) – For network requests  
- [CoreLocation](https://developer.apple.com/documentation/corelocation) – To access location data  
- [Lottie](https://github.com/airbnb/lottie-ios) – For animated weather visuals  
- [OpenWeatherMap API](https://openweathermap.org/api) – For weather data  

> 📦 **Dependency Management:**  
> The project uses **Swift Package Manager (SPM)**.  
> Alamofire and Lottie were added via Xcode using `File > Add Packages...`.

---

## 🚀 How It Works

1. The user enters a city name or taps the "Location" button.  
2. A request is sent to the API and the JSON response is parsed.  
3. The weather data is updated on the screen, including:
   - Temperature  
   - City name  
   - Weather description  
   - Icon and animation  
4. The background and icons change based on the weather condition:  
   For example, animations specific to conditions like `Clear`, `Clouds`, `Rain` are shown.

---

## 🖼️ Demo

[Click here to watch the demo](demo.mov)


---

## 📦 Installation

1. Clone this project:
   ```bash
   git clone https://github.com/username/WeatherApp.git
