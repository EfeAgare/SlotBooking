# Slot booking
 A system through which shipping companies can book a time slot to load or unload goods at a warehouse. Specifically, given a day and the duration for the new slot to be booked, the system gives a list of times that are available for booking. Users can then pick one suggestion from the list and book a slot at this time.

### Task Done
- Create a simple web application using Ruby on Rails and React.
- Users of this application shall be able to enter their slot booking details:
     - The day on which the slot should be booked
     - The duration of the slot to book

- In response to these inputs, the application shall display a list of possible times on this day when such a slot can be booked. Slot booking shall be aligned to 15-minute increments - therefore there should be a multiple of 15 minutes between each slot that is offered.
- The user shall be able to pick one of these possible time slots. That should then book this slot for the user and display some form of confirmation that the operation was successful.
- Users of the app shall not be able to book a slot that overlaps any previously-booked slot.

## Technologies
  * Ruby
  * Git
  * Rspec

## Setup
- Ensure you have [ruby](https://rvm.io/rvm/install) installed on your device and also [redis](https://phoenixnap.com/kb/install-redis-on-mac) for background processes

  ```
   Ruby = 3.0.0
  ```

  Clone this repository and cd into the clone specific folder and run the following command 
  accordingly

  ```
   bundle install
  ```

  ```
   rails db:create 
  ```

  ```
   rails db:migrate
  ```

  After to run server

  ```
  rails s
  ```
## Test 
To run all test
```
rspec 
```

and to run a specific test 
 ```
 rspec 'relative path to file'
 ```

### Assumption:

- No loading or unloading during the weekends
- Book slot in 15 minutes range according to the duration input of user
  meaning if a user book 9:00AM and duration of 40, it means "9:00AM - 9:45AM" 
  have been booked  so "9:00AM", "9:15AM" "9:30AM" will not be shown to the user
