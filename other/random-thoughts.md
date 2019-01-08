## Introduction
This file is used to document my train of thought while creating the Rental app
and smart contracts.  The plan is to write any questions/thoughts/ideas that
come up during development so that a possible great idea doesn't go to waste :)


### 1/4
* How can I predetermine that size of the renters array without an overflow?
* Do I need to predetermine the array size?

### 1/8
#### Steps from registering users to posting apartments
1. Requirements to be able to register
  - User is not:
    - banned
    - already registered
3. give user permissions to post rentals/rent an apartment
  - User allowed to sell
  - User allowed to rent
    - Can only rent one apartment
    - Can sell as many apartments as they like
4. Allow seller to post apartment for rent
  - data needed from seller to initiate apartment for rent
    - location
    - deposit price
    - term (months)
    - monthly price
    - description of apartment
  - data to document
    - location
    - deposit price
    - term (months)
    - monthly price
    - description of apartment
    - address of seller
    - id of apartment
    - date posted
5. Allow renter to rent apartment
  - again, validation that renter isn't already renting
  - they make a deposit to the apartment seller
  - their name is put on the apartment rental
  - update the user data
  - repeat billing every month for the term
6. Once an apartment is rented
  - Let's say a renter wants to cancel early
    - They need to first send an amount to trigger the cancellation
      - proportional to either the monthly price or deposit price
    - their deposit is also sent to the seller
    - their "currentlyRenting" user value is now set to *false*
    - The "currentlyRented" apartment value is now set to *false*
    - notify the seller
    - Add to cancellation registry
      - user Id
      - apartment Id
      - date
      - tx hash of when apartment was put for rent
