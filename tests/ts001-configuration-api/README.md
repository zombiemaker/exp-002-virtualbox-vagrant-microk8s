# Configuation API Testing

## Setup Testing Environment

Install JSONSchemer Ruby gem

* From within the development container, run the following linux shell command
```
gem install json_schemer
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