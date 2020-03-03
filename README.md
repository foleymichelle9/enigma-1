# Enigma

## Self Assessment

### Functionality

*Score: 3*

**Overview**
- The `Enigma` class was successfully implemented
    - This class has working `encrypt` and `decrypt` methods
- The command line interfaces were successfully implemented

___
### Object Oriented Programming

*Score: 4*

**Overview**

My `Enigma` Project was broken into 5 essential parts.

1. `Hashable` and `Searchable` Modules
    - Both modules include methods to be used by the child classes (`Encryption` and `Decryption`)
    - The methods are in these modules and not in the `Cipher` class because they are to be used differently in each child class
2. `Cipher` Parent Class
    - This class includes the `Hashable` and `Searchable` modules to be used in the child classes
        - This was done in the parent class to ensure that my code is as DRY as possible
    - This class contains all methods that are shared by both child classes
3. `Encryption` and `Decryption` Child Classes
    - Both the `Encryption` and `Decryption` classes contain methods unique to encrypting or decrypting the message
        - This was done to properly encapsulate what is needed to either encrypt or decrypt a message
4. `Enigma` Class
    - The `Enigma` class was created to hold the final encrypt and decrypt methods
        - This was done to create a "one stop shop" for encrypting and decrypting a message
5. `Encrypt` and `Decrypt` CLI files
    - The `Encrypt` runner file was created to allow the user to write the message they would like encrypted in a text file
        - It then reads this file and encrypts the message and places it in another text file
        - Finally it returns a message to the user telling them where to find their encrypted message along with the key and date used to encrypt it
    - The `Decrypt` runner file takes the encrypted message from above and decrypts it
        - It writes this decrypted message in another text file
        - It then returns a message to the user telling them where to find their decrypted message along with the key and date used to decrypt it

**More Things to Note**
- The longest class in this project is the `Cipher` class at 69 lines
    - The shortest class is `Enigma` at 18 lines long
- All classes only contain information relating to themselves
- All methods follow the SRP guidelines

___
### Ruby Conventions and Mechanics

*Score: 3*

**Overview**

- All classes and modules in this project are named for transparency
- The arguments given to any method are consistent throughout the project
- Child classes are named similar to their parent class to show their relation
- Code is properly indented and spaced throughout
- Some enumerable's are the correct tool for the job while I had to use `each` on some others
- There are several hashes implemented in this project

___
### Test Driven Development

*Score: 3.5*

**Overview**
- Every method in this project is tested with the exception of `generate_random_key`
- The testing coverage is at 99.15%
- Most methods follow SRP guidelines
    - This allowed me to test every piece of logic in the code
- Most edge cases are tested
- All tests were written and committed before the methods were written
- Classes can be tested without relying on functionality from other classes

Stubs were also used in the testing of the final encrypt and decrypt methods to ensure that it is able to create a random key and generate todays date.

___
### Version Control

*Score: 4*

**Overview**
- This project has over 250 commits in total
- All tests were committed before methods
- No commit messages are ambiguous
    - None of them include multiple chunks of functionality
- All pull requests are named appropriately
    - Pull requests have the functionality created in that branch listed in the request

___
### Layout of files

![Ruby Encapsulation Enigma](https://user-images.githubusercontent.com/55028065/75744627-11382080-5cd2-11ea-9255-9ff76900479f.jpg "File Layout")
