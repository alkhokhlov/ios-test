
# iOS technical test

**KHOKHLOV Oleksandr alkhokhlovv@gmail.com**

## Write a brief outline of the architecture of your app

I used a clean architecture approach, where we divide the software into layers from application use case layer to the implementations 
of exact models. I tried to move the business logic from the View level with a layer that is called the Interactor. I have **Gateway** for the 
network level and **Repository** for database layer. I have three types of **Model**. One (general) is used for the view, 
the other for network and the database layers. These objects must be mapped to the general object in Gateway and Repository
layers. This provides us with a clean and transparent data stream. I have **NetworkManager** and **PersistanceStore** protocols so their 
implementations can be used for modular testing. Implementing these protocols encapsulate working with a network and a database. 
I have DependencyProvider that contains initialization of models that are used within an application. This is especially useful for view_preview 
structures.

## Explain your choice of libraries

I used **SwiftUI** and **Combine** because you develop an application using SwiftUI and I find that it could be relative to provide technical 
test using these technologies. I used **CoreData** as a database because it is better to show understanding of core technologies of iOS development. 
I used **Codable** as a mapper, because it is fast to make a mapping for a test application.

## What was the most difficult part of the challenge?

I spent most of the time learning and reading SwiftUI and Combine, because I was not familiar with these technologies. But I have already worked 
with Reactive technologies, so Combine was not so hard.

I faced with some unexpected problems with SwiftUI

- You cannot make background color clear of grouped lists, so you should make a hack
- You cannot easily change a navigation bar without using StackNavigationViewStyle (which brings problems to iPad, but it is good for iPhone). 
I could use global appearance, but this is a bad approach
- It took some time to refresh mind how to use UIBezierPath

## Estimate your percentage of completion and how much time you would need to finish

I have left to develop a custom design of TabBarController and SegmentedPickerControl. It is hard to estimate properly a time to finish because SwiftUI
is a new technology and you can get unexpected bugs. Positive scenario one - two days, negative scenario one week. I need time to provide a clean connection 
with these components.
