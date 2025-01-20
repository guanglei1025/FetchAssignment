### Summary: Include screen shots or a video of your app highlighting its features
|With Data|Empty|
|-|-|
|<img width="400" alt="Screenshot 2023-08-30 at 11 02 48 PM" src="https://github.com/user-attachments/assets/a6b2432d-62d2-4ec6-879a-f4b7e222942e">|<img width="400" alt="Screenshot 2023-08-30 at 11 02 48 PM" src="https://github.com/user-attachments/assets/ea550112-47d4-4948-8f5b-207914d3acf4">|

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

In this project, I am prioritize building the architecture and design pattern because they show my ablity to work on large scale project  

1. Implemented  three layers with the ability to add data persistent if needed. 
- Network layer:  Handle API calls
- Repository layer: Handle fetching data from different data source. (e.g. SwiftData, FileManager, Server)
- UI layer: Include business logic and update UI

2. Implemented Image caching logic 


### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
One day

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I implemented image caching with `NSCache` instead of save them to the File system. It's because the `NSCache` are good for less meaningfull content, like insgtram feed. We don't want to save it to our device. 

If it's something like user profile, we may want to save it to the device. Based on the use case. I choosed `NSCache`

### Weakest Part of the Project: What do you think is the weakest part of your project?

1. Poor UI
2. Very little business logic like. I will add more features if I have time like sorting. etc 

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

In the requirement, it said cache image to disk. It should give option to save it in disk or in memory
