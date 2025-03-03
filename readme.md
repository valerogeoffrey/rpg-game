
# RPG Command-Line Game

## Introduction

This is a turn-based RPG game running in the command line, built in Ruby. Players can navigate through rooms, solve enigmas, and engage in battles against opponents. The game mechanics are designed with flexibility in mind, allowing easy configuration and customization.

## Requirements

- **Ruby**: 3.1.4
    
- **Bundler**: Ensure Bundler is installed to manage dependencies.
    

## Installation

Clone the repository and install dependencies:
```
git clone https://github.com/valerogeoffrey/rpg-game.git
cd rpg-game
bundle install
```

## Running the Game

Start the game with the following command:

```
ruby app.rb
```

## Running Tests

This project uses RSpec for testing. To run the test suite, execute:

```
bundle exec rspec spec/vendor
```

To run a specific test file:

```
bundle exec rspec spec/vendor/../file_spec.rb
```

## Code Quality Checks

To ensure code quality, run RuboCop:

```
bundle exec rubocop
```

## License

This project is licensed under the MIT License.