Before you submit the project, add a README.md file to your repository that contains a self assessment of your project based on the rubric
# Enigma

## Self Assessment

### Functionality

*Score: 3*

The Enigma class was successfully implemented with working encrypt and decrypt methods. The command line interfaces were successfully implemented as well.

___
### Object Oriented Programming

*Score: 4*

My Enigma Project was broken into 5 essential parts.

1. Hashable and Searchable Modules
    - Both modules include methods to be used by the child classes (Encryption and Decryption)
    - The methods are in these modules and not in the Cipher class because they are to be used differently in each child class
2. Cipher Parent Class
    - This class includes the methods from the Hashable and Searchable modules to be used in the child classes
        - This was done in the parent class to ensure that I am not repeating myself
    - This class contains all methods that are shared by both child classes
3. Encryption and Decryption Child Classes
    - Both the Encryption and Decryption classes contain methods unique to encrypting or decrypting the message
        - This was done to properly encapsulate what is needed to either encrypt or decrypt a message
4. Enigma Class
    - The Enigma class was created to hold the final encrypt and decrypt methods
        - This was done to create a "one stop shop" for encrypting and decrypting a message
5. Encrypt and Decrypt CLI files
    - The encrypt runner file allows to the user to write a message to encrypt in a text file
    - It then takes that encrypted message and decrypts it using the decrypt runner file


The longest class in this project is the Cipher class at 69 lines. the shortest class is Enigma at 18 lines long. All classes only contain information relating to themselves and all methods follow the SRP guidelines.

___
### Ruby Conventions and Mechanics

*Score: 3*

Classes and modules are all named well. The child classes are named similar to their parent class to show their relation. Code is properly indented and spaced. Some enumerables are the correct tool for the job while I had to use `each` on some others. There are also several hashes implemented in this project.

___
### Test Driven Development

*Score: 3.5*

Every method in this project is tested with the exception of `generate_random_key`. The testing coverage is at 99.15%. Most methods follow SRP guidelines so they were simple to test. Most edge cases are tested and all tests were written and committed before the methods were written.

Stubs were also used in the testing of the final encrypt and decrypt methods to ensure that it is able to create a random key and generate todays date. Classes can be tested without relying on functionality from other classes.

___
### Version Control

*Score: 4*

This project in total has over 200 commits. All tests are committed before methods. No commit messages are ambiguous and none of then include multiple chunks of functionality. All pull requests are named appropriately and have the functionality created in that branch listed in the request.
