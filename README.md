## Summary: Include screen shots or a video of your app highlighting its features

Simple app to fetch recipes and display them in a list. Includes local image caching, search functionality, and error handling.

### Error States
<img width="200" alt="image" src="https://github.com/user-attachments/assets/2d710d24-651d-437e-9227-e4bbea4b0d79" />
<img width="200" alt="image" src="https://github.com/user-attachments/assets/626f0ff7-deb7-4e93-be4b-fc63a847d77b" />
<img width="200" alt="image" src="https://github.com/user-attachments/assets/9c30bc5f-075a-4ca4-95c7-9292538b9cad" />
<img width="200" alt="image" src="https://github.com/user-attachments/assets/a819251f-e39d-4ba8-9a6c-d96a7d1af385" />

### Main View
<img width="300" alt="image" src="https://github.com/user-attachments/assets/935e6d64-96c1-4f3a-a35b-489fa0540e5b" />
<img width="300" alt="image" src="https://github.com/user-attachments/assets/7186c3f1-4cf3-4112-8484-bfaf6198c087" />
<img width="300" alt="image" src="https://github.com/user-attachments/assets/b683cef1-f07f-4535-9679-a0399d9644ea" />

## Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I prioritized a clean MVVM architecture and implementing extensible services in order to provide a solid foundation to build from.

## Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

~6 hours
* 3 hours: Base implementation of UI, model, and service classes
* 1.5 hours: Testing
* 1.5 hours: Exploring options for adding features (time burned trying to get embedded youtube videos to play)

## Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

- Targeted iOS 17+ in order to use @Observable 
- Opted not to implement a ViewModel for rows which added some complexity to the View

## Weakest Part of the Project: What do you think is the weakest part of your project?

The error handling around image caching is not very robust with a lot of opportunities to fail silently. 

## Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

I found the project interesting and not too time consuming. It gave me an opportunity to use some SwiftUI elements I hadn't interacted with previously such as DisclosureGroup and ContentUnavailableView.
