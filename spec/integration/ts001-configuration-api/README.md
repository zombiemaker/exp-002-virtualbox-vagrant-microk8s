# Configuation API Testing

## Setup Testing Environment

Use Ruby bundle to install Ruby gems (from within test directory)
```
bundle install
```

OR Install JSONSchemer Ruby gem individually

* From within the development container, run the following linux shell command
```
gem install json_schemer
```

OR Install Rspec Ruby gem individually
```
gem install rspec
```

Run Ruby Test Programs

* From within the development container, run the following linux shell command
```
ruby [name of ruby program file]
```


## Testing Goals

* Test configuration data ingesting programs
  - conversion from yaml to json
  - detection of errors in configuration data if not following schema
* Test schema definition for configuration data
  - does it sufficiently detect syntax errors
  - does it sufficiently restrict data values to prevent incorrect types
  - does it sufficiently restrict incorrect combinations