# Ruby Fundamentals IV:  Non-core Change Machine Kata

Create a program that determines the proper currency that
should be issued when change is due.
As an additional challenge, allow the user to specify the
amount tendered.

User story / acceptance criteria:

As a cashier
I want to know the coins I should issue
So that I can give customers proper change

Acceptance Criteria:

Given an amount due, the system will report what change is due after the customer pays a whole dollar amount closest to the amount due.
The system will supply the number of quarters, dimes, nickels, and pennies that should be issued for the change due.

Sample output:
Amount Due: 13.26

What did customer supply?
> 16.00

The change due is $2.74

You should issue:

2 dollars
2 quarters
2 dimes
4 pennies
