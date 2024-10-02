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

## Technical and Architecture Overview

This section provides an overview of the app’s key functionalities and how it’s structured using **Clean Architecture** to maintain scalability, modularity, and separation of concerns.

### 1. Real-Time Data via WebSockets
- **Functionality**: The app connects to a WebSocket server that streams live cryptocurrency data. This allows users to monitor prices and market movements in real time, with instantaneous updates directly reflected in the user interface.
- **Architecture Implementation**:
    - **Data Layer**:
        - `socket_datasource.dart`: Manages the WebSocket connection, handling real-time data streaming and communication with the server.
    - **Presentation Layer**:
        - `crypto_bloc.dart`: Manages the state of the WebSocket connection and data flow, ensuring the UI is updated in real time when new data arrives.

### 2. Interactive Watchlist and Line Charts
- **Functionality**: The app provides a watchlist for users to track selected cryptocurrencies, displaying live updates of prices, daily changes, and percentage changes. Additionally, interactive line charts offer a graphical representation of price movements over time. The X-axis shows time intervals, and the Y-axis displays price in USD.
- **Architecture Implementation**:
    - **Presentation Layer**:
        - `dashboard_page.dart`: The main UI component displaying the watchlist and charts.
        - `stock_card.dart`: A widget representing individual cryptocurrency details, including price and percentage change.
        - `crypto_chart.dart`: A chart widget that visualizes the price movement of selected cryptocurrencies.
    - **Domain Layer**:
        - `get_crypto_usecase.dart`: Fetches and processes the cryptocurrency data to be displayed in the watchlist and charts, ensuring business logic is encapsulated here.
    - **Data Layer**:
        - `crypto_repository_impl.dart`: The implementation of the repository that fetches cryptocurrency data and passes it to the domain layer.

### 3. Core Layer
- **Purpose**: This layer contains essential utilities and configurations that are shared throughout the app.
    - **Components**:
        - `text_constants.dart`: Contains common constants, ensuring consistency across the app.
        - **Dependency Injection**: Ensures all the required services are injected into the necessary components using dependency injection patterns, which promotes modularity and testability.

### 4. Data Layer
- **Purpose**: This layer is responsible for handling data operations, including fetching data from external sources such as WebSockets and REST APIs.
    - **Components**:
        - `socket_datasource.dart`: Manages communication with the WebSocket server for real-time cryptocurrency data.
        - `crypto_model.dart`: Defines the data structure representing cryptocurrency information such as price, daily change, and timestamps.
        - `crypto_repository_impl.dart`: The concrete implementation of the repository, which connects to data sources and provides data to the domain layer.

### 5. Domain Layer
- **Purpose**: Contains the core business logic of the app, independent of external data sources and UI components.
    - **Components**:
        - **Repository Interface** (`crypto_repository.dart`): Defines the contract for data handling, allowing the domain layer to remain agnostic of the underlying data sources.
        - **Use Cases** (`get_crypto_usecase.dart`): Handles specific actions or operations related to cryptocurrency data, such as retrieving the latest prices for the watchlist and chart.

### 6. Presentation Layer
- **Purpose**: Handles the user interface and state management, ensuring the app remains responsive to real-time updates and user interactions.
    - **Components**:
        - **BLoC State Management**:
            - `crypto_bloc.dart`: Manages the state of the application by responding to data changes (e.g., new WebSocket data) and updating the UI accordingly.
            - `crypto_state.dart`: Defines the different states of the UI (e.g., loading, data received, or error states).
        - **UI Pages**:
            - `dashboard_page.dart`: Displays the main interface, including the cryptocurrency watchlist and charts.
            - `stock_card.dart`: Displays the details of individual cryptocurrencies.
            - `crypto_chart.dart`: Renders the price movement chart based on real-time data.

### 7. Utilities
- **Purpose**: Contains helper functions and utility files that streamline certain tasks throughout the application.

---

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
