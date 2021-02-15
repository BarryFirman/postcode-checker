# Postcode Checker
An application to check whether a given postcode is within two service areas:

- Southwark
- Lambeth

## Usage
Enter a given postcode and click `Check Postcode`, the application will report whether the postcode is allowed within the service areas above.

## Getting Started
 - Clone the repository

- Change directory to the root of repository

### Prerequisites :

- [Webpacker](https://github.com/rails/webpacker) : Ensure Webpacker prerequisites and dependencies are installed and configured.


### Install Gems:

`bundle install`

### Create and seed database:

`rails db:migrate`

`rails db:seed`

## Managing Allow Lists
Two Postcodes are set by default:

- SH24 1AA
- SH24 1AB

To manage these and add other postcodes navigate to:

`/postcode_allow_lists`

## Dependencies
This application has the following dependencies

- [UK Postcode Gem](https://github.com/threedaymonk/uk_postcode) : For ensuring the correct format of given postcodes.
- [Postcodes.io](https://postcodes.io) : To determine if a given postcode is in one of the service areas.


## Versions:

- Ruby 2.7.2
- Rails 6.1.1
