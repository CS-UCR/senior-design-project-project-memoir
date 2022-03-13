![Memoir](./images/banner.jpg?raw=true "Memoir")


## Table of Contents
- [Overview](#overview)
- [Authentication](#authentication)
- [Usage](#usage)
- [How To Run](#how-to-run)
- [Diagrams](#diagrams)
- [Dependencies](#dependencies)

## Overview
Memoir is an augmented reality social messaging app that allows users to anchor messages to their current geographic location. Within the app, users can post and read messages that have been anchored.

# Team
![Contributors](./images/contributors.png)
- Carlos Loeza
- Aden Ghadimi
- Richard Duong
- Marco Alexi Sta Ana
- Bryan David Orozco


## Usage
Demo: <Link to youtube video>

<Screenshot of application>

## Running the project
To run the project you'll need the following
 - iPhone device with IOS 15+
 - Xcode V13
 - Apple Developer Account

Clone this repository into your local machine. And open the `ProjectM.xcodeproj` file
```shell
git clone https://github.com/CS-UCR/senior-design-project-project-memoir.git
cd iOS-frontend
open ProjectM.xcodeproj
```
You'll need to have your phone connected to your computer. Build the project `Product > Build`, then run it `Product > Run`. The application will open on your phone.
 
 ## AppSync
Given that GraphQL is the method our data is fetched and updated, AWS AppSync provides us with a GraphQL endpoint as well as a schema designer. Mutations for updating data is also created within AppSync. To download the graphQL schema you can use the AWS cli.

## Apollo
Apollo is used to connect from our iOS app to the GraphGL server. Queries are written and saved under the `GraphQL` folder in the XCode project. [Read more about apollo-ios](https://www.apollographql.com/docs/ios/tutorial/tutorial-add-sdk/).

### Schemas
We use the apollo cli to download the schemas. Once the apollo cli is installed you can runt he following command. Replace `AWS_API_KEY` with the actual api key.

apollo schema:download --header "x-api-key: AWS_API_KEY" --endpoint=https://wcgn7h5rojedpgzlmoroh3bazq.appsync-api.us-west-1.amazonaws.com/graphql schema.json

 
## Authentication
Authentication for Memoir is managed by Apple Sign In. We do not store any password information for security purposes. Each user has the ability to disclose their email to us or hide it through an icloud alias. [Read more about Sign In with Apple](https://developer.apple.com/documentation/sign_in_with_apple).

## ARKit
Apple's ARKit is the fundamental framework used for the AR development. Scenes, Anchors and Entities are used to display content on the scene.
 - [Scenes](https://developer.apple.com/documentation/arkit/arscnview/2875547-scene)
 - [ARAnchors](https://developer.apple.com/documentation/arkit/aranchor)
 - [Entities](https://developer.apple.com/documentation/realitykit/entity)

### ARGeoAnchors
ARGeoAnchors are used to place anchors in the real world. By providing a latitude and longitude, we are able represent an anchor in our world. ARGeoAnchors are only available in certain cities, [see list](https://developer.apple.com/documentation/arkit/argeotrackingconfiguration). 

### Reality Composer
Reality Composer is used to model the 3D objects placed in the AR view. Behaviors such as touch or proximity.  

![Reality Composer](./images/reality-composer.png "Reality Composer" )
