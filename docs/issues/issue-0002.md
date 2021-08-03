# Ruby 'yaml' module cannot handle YAML directive

Get an error if the YAML data starts with a "%YAML" directive, which is in the YAML spec.  The Ruby yaml module only handles YAML 1.1.

## Resolution

Commented out the %YAML directive