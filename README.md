# SwaggerApp
Interview application for Mediatorium. The idea of the application is to use user credentials in order to connect to open API.
After connection was established in case of valid credentials, server responds with status 200, and an access token wrapped in the body of the response.
*Access token* is then saved in *UserDefaults*, and set as Bearer authorization token.
Immediately after set token, new request is sent to second API with the token,
upon which server reponds with data which will be presented on screen.

Project was developed without storyboard, using programmatically created UI only. Files are grouped by their types for easier navigation.
Project also contains buildable DocC documentation, in order to present functionalities, targets and goals of various elements.

## Code architecture

### Coordinator pattern

In order to create modular structure with independend elements Coordinator pattern was used. 
*Main Coordinator* class is responsible for creating and adding View Controllers to *Navigation Controller* tasked with presenting them.
It is also responsible for creating delegacies between classes which are not related. 

### MVVM Pattern

For cleaner and more readable code MVVM Pattern was used, to keep bussines logic separated from classes responsible for UI logic.

### Delegate pattern

With purpose of avoiding providing parent classes to children Delegate pattern was used. In this application Delegate pattern has two main purposes:
- avoid cyclic dependencies
- create independent reusable classes

### Code design

During development of application SwiftLint was used to help with code design. Whitespaces and double empty lines were removed.
Line lengths were kept under 120 characters, methods were structured to keep as minimum complexity as possible.
Two or three letter variable, constant and function names were avoided.

## UI Design

Application uses Supreme open source font. Background colors for screen and buttons were extracted from sample image for login screen.
Status bar was set to light mode for whole application.

### Login Screen

*Login screen* was designed by given example. It is important to note that design was created with the help of **iPhone 13 Pro Max Simulator**,
and changes in final visual result may vary depending on iPhone type and/or generation.

![Simulator Screen Shot - iPhone 13 Pro Max - 2023-02-24 at 10 11 05](https://user-images.githubusercontent.com/87969333/221141524-3f8afbdb-5dfe-4dd8-aae7-79e87187a5a4.png)

Screen also contains *Loading spinner*, which represents waiting of *APIService* for HTTPResponse.
![swaggerAppLoading](https://user-images.githubusercontent.com/87969333/221142017-51738945-59b7-47e5-ba70-e73ba43739f4.png)

While application is waiting for response, *Login button* is disabled to avoid sending multiple requests before recieving response.

Request and/or response errors are presented modally on top of the screen. 
![swaggerAppError](https://user-images.githubusercontent.com/87969333/221142613-18fb0532-5f42-4986-9c2a-9d9012cbb74d.png)

### Details screen

Since no specific design was given for screen presenting recieved data, intuition was to keep the same design pattern from *Login screen*. 
Presentation was achieved via tableView with custom cells, showing key labels in gray color, while value labels use slightly transparent white color.
*Logout button* was created with the same design as *Login button*.

![Simulator Screen Shot - iPhone 13 Pro Max - 2023-02-24 at 10 22 30](https://user-images.githubusercontent.com/87969333/221144182-953fd896-17f7-4ed4-9465-f60e68e7e0ee.png)

### Input Fields

For input fields *UITextField* was used, with given border. In order to keep constraints valid, in password input, the "eye" icon was added as textField's rightView property.
Both labels attached to input fields were custom made, even though a pod could have been used.
Both input fields have turned off autocorrection and autocapitalization to give full controll of input to the user.

## Application flow

User is first presented with the Login screen, in which input fields for e-mail and password are given. Upon given input when *Login Button* is tapped,
*LoginController* creates a new instance of *LoginRequestModel*, which is delegated to *APIService*. *APIService* runs *login* method, sending the request,
and notifying the Login screen that it is waiting for response, via delegate.
Upon recieved response, in case of errors, service delegates the error message back to *LoginController*, which contains an optional published string variable, with *LoginView* as subscriber.
*LoginView* then presents the error message to the user.
If the response status was 200, and data was successfully recieved and decoded, service stores the data in *UserDefaults*, immediately calls the next method to fetch user data, with same structure as login method.
If the data as succesfully recieved and decoded, service notifies *MainCoordinator* providing recieved data.
*MainCoordinator* then removes *LoginViewController*, and sets *DetailsTableViewController* in its place, with own views and controller.
*DetailsController* recieves the data from service, converting it for display into *DetailsViewModel* and appending to the predefined array variable.
Uppon change in the variable, didSet is called, which updates the snapshot for the table view data source,
which then provides it to the *DetailsTableViewController* in order to render and present recieved data to the user.
With tapping on *Logout button* saved access token is deleted, and *Main Coordinator* is notified to whitch back to Login screen.

