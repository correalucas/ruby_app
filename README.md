# Ruby App

This app receives a log (with url and ip) as argument and returns the most viewed urls and most unique viewed urls

### Prerequisites

Before you begin, you will need to have the following tools installed on your machine: 
`Ruby 2.7.1`

### Installing

```
# Clone this repository
# Run Bundler
$ bundle install
```

### Executing
```
# Inside the app folder, execute the script passing the log as argument:
$ ruby lib/ruby_app.rb ./log/webserver.log
```

### Testing
```
# Inside the app folder, execute the command:
$ rspec
```

### Running Rubocop
```
# Inside the app folder, execute rubocop by running the command:
$ rubocop
```

## Authors

* **Lucas Correa** - [Contact](https://www.linkedin.com/in/correalucas/)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
