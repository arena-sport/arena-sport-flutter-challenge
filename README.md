# How to Install
1. Clone the repository, and run `flutter pub get` within the cloned directory in cmd.
2. Open the server folder, and run `npm install` within the directory in cmd.
3. In the same server folder, run `npm start` in cmd. This starts the NodeJS GraphQL middle layer.
4. Open a new terminal, and run the `ipconfig` command. Copy the IPv4 address (this is local to your LAN network).
5. Within the cloned Arena directory, navigate to `Arena/lib/client.dart`. Here, edit the URI of the HttpLink from `http://10.0.0.213:4000/` to `http://{YOUR URI FROM STEP 4}:4000/`. (**This is extremely important because android emulator does not understand the meaning of localhost.**)
6. Finally, navigate to the `lib/` folder and type `flutter run`. The app should be working.


If you have any questions about this process, please contact Mihir Thanekar at `mihirthanekar@gmail.com`.

# Arena Sport 
![license](https://img.shields.io/badge/license-MIT-green?style=flat-square)  
Arena Sport open-source Flutter challenge.  
Earn your chance to become a permanent member or external collaborator of Arena Sport, the new upcoming official ecosystem for sports.

## Screenshots
Some screens that will help you.

Main Page           | Stats Page
:-------------------------:|:-------------------------:
![](https://user-images.githubusercontent.com/17878459/92183024-90dead80-ee23-11ea-9429-1b25e2a73485.jpeg)  |  ![](https://user-images.githubusercontent.com/61524860/92217221-cad4a180-ee6d-11ea-9d0a-6d63dbc51188.png)

## Requirements
All of the following requirements must to be fully functional.

- Home page, consuming the endpoint.
- Stats page, consuming the endpoint.
- And make some magic ✨

## Submitting
- Fork the repository and clone it to your local machine
- Create a branch with your name and make it the default one.
- Make your changes and create a pull request.

**DON'T FORGET TO PUSH YOUR CODE BEFORE SEP 13 12PM GMT.**
We will be announcing the results on Monday 14.

## Backend
You must use our GraphQL endpoint that can be found [here](http://137.135.44.198:4000/graphql).
Therefore, you can use any API you want to retrieve the sport news. ([example](https://rapidapi.com/collection/espn-api-alternative))

## License
This project is under the [MIT License](https://opensource.org/licenses/MIT).  
Feel free to submit issues or create pull requests.
