### Project Overview

# Crypto Watchlist and Chart Mobile Application

This Flutter-based mobile application is designed to display real-time cryptocurrency data, allowing users to track the prices and market trends of various cryptocurrencies. The app features a clean, modern design that is user-friendly and intuitive. It leverages WebSockets for live data updates and offers interactive charts for price movement visualization.

## Key Features

- **Watchlist**: Displays a list of selected cryptocurrencies with real-time updates of their prices and percentage changes. Users can easily monitor their favorite coins such as Bitcoin, Ethereum, and others.
- **Detailed Crypto Data**: Each cryptocurrency displays:
    - **Current Price** in USD.
    - **Daily Price Change** showing the difference in price since the start of the day.
    - **Percentage Change** indicating the percentage increase or decrease.
- **Interactive Price Chart**: When a cryptocurrency is selected from the watchlist, the user is presented with an interactive price chart showing real-time price movement. Users can zoom and pan to focus on specific time intervals.
- **Real-Time Updates**: The app uses WebSocket technology to ensure that all cryptocurrency data is updated in real time without needing to refresh.
- **Elegant UI**: The app design includes smooth animations, modern fonts, and clean card-based layouts, making the interface visually appealing and intuitive to navigate.

## Demo

| Android Demo | iOS Demo |
|--------------|----------|
| ![Android Demo](assets/android.gif) | ![iOS Demo](assets/ios.gif) |

## Technical Overview

- **Real-Time Data via WebSockets**: The app connects to a WebSocket server that streams cryptocurrency data, allowing for instant price updates.
- **Interactive Watchlist and Line Charts**: Detailed Watchlist and Charts provide users can monitor their selected cryptocurrencies with a list and a graphical representation of price movement over time. The X-axis represents time in intervals, and the Y-axis shows the price in USD.

## Clean Architecture Implementation

This application follows the **Clean Architecture** pattern, which provides a clear separation of concerns and ensures a modular, scalable, and maintainable codebase. The architecture consists of the following layers:

### 1. **Core Layer**
- Contains fundamental elements such as environment configurations, error handling, dependency injection, and core services.
- These components are essential and used across the entire application, making them reusable and easily modifiable.

### 2. **Data Layer**
- Responsible for managing data sources, including WebSocket and RESTful API interactions, models, and repositories.
- This layer abstracts the details of data retrieval and provides a unified interface for fetching data, ensuring the data source implementations (WebSocket, APIs, etc.) are hidden from the rest of the app.

### 3. **Domain Layer**
- Contains the business logic of the application, including use cases and repository interfaces.
- It is independent of the data source and presentation layers, ensuring that core functionality is isolated and reusable in other contexts if needed.

### 4. **Presentation Layer**
- Manages the UI components, utilizing `Bloc` and `Cubit` for state management to ensure that the user interface responds to changes in the data.
- This layer interacts with the domain layer to render live data in charts and watchlists, providing a seamless and real-time experience for the user.

## Scalability and Maintainability

Thanks to **Clean Architecture**, the application is modular and highly maintainable. Each layer is loosely coupled, making it easier to add new features without affecting other parts of the app. The modular design also allows for individual components to be tested and maintained independently, ensuring the app's scalability as it grows in complexity.


## Sample Data Structure

The application interacts with WebSocket APIs for real-time data and also includes support for fetching historical data when needed (to be integrated in future updates). Below is an example of the data structure used in the app:

```json
{
  "tickerCode": "BTC-USD",
  "lastPrice": 60272.20,
  "quantityOfTrade": 0.5,
  "dailyChangePercentage": -0.89,
  "dailyDifferencePrice": -536.27,
  "time": 1633024800
}
```

### How to Run the Project

Follow these steps to set up and run the project on your local machine:

1. **Clone the Repository**:
    - First, clone the repository to your local machine using the following command:
      ```sh
      git clone https://github.com/yourusername/yourproject.git
      ```
    - Navigate to the project directory:
      ```sh
      cd yourproject
      ```

2. **Install Dependencies**:
    - Ensure that you have Flutter installed on your machine. If not, follow the official [Flutter installation guide](https://flutter.dev/docs/get-started/install).
    - Install the necessary dependencies by running:
      ```sh
      flutter pub get
      ```

3. **Create the `.env` File**:
    - Create a `.env` file in the root directory of your project. This file is used to store environment variables like API URLs.
    - Example content for the `.env` file:
      ```sh
      BASE_URL=wss://ws.eodhistoricaldata.com/ws/crypto?api_token=demo
      SYMBOLS=BTC-USD, ETH-USD
      ```
    - Ensure that the `.env` file is included in your `.gitignore` to avoid committing sensitive information.

4. **Run the Application**:
    - To run the application on an emulator or a physical device, execute the following command:
      ```sh
      flutter run
      ```
    - Ensure that you have an emulator running or a physical device connected. You can check connected devices by running:
      ```sh
      flutter devices
      ```
