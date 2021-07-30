# Configuration File Syntax

My thoughts for APIs

* should allow for different data serialization formats namely:
  * Required
    * JSON
    * YAML
    * XML
  * Optional
    * Apache Avro
    * Apache Thrift
    * Apache Parquet
    * Protocol Buffers
* Should have a well-adopted data model schema definition language
  * JSON Schema
  * JSON Hyper-Schema
  * XML XSD
  * YAML Schema (?)
  * Apache Avro Schema

Current API specification language standards:
* [OpenAPI](https://spec.openapis.org/oas/v3.1.0)
  * Uses JSON Schema Draft 2020-12 for data schema definitions
* [Blueprint](https://apiblueprint.org/)
* [RAML](https://github.com/raml-org/raml-spec)
* [JSON:API](https://jsonapi.org/)

Tools
* [JSON Schema Validator](https://www.jsonschemavalidator.net/)
* [JSON to YAML](https://www.json2yaml.com/)
* [YAML to JSON](https://onlineyamltools.com/convert-yaml-to-json)
* [Red Hat Visual Studio Code Extension: YAML Language Support](https://github.com/redhat-developer/vscode-yaml)
  * Use a file name for YAML file type
  * Edit VSC settings to association file type with schema definition file
  * If you edit the schema definition file, you need to force VSC to reload the schema definition

## Reference Information

* [OpenAPI Initiative Site](https://www.openapis.org/)
  * [OpenAPI Specification (GitHub)](https://github.com/OAI/OpenAPI-Specification)
  * [OpenAPI Specification (Latest)](https://spec.openapis.org/oas/latest.html)
  * [OpenAPI Specification v3.1.0 (2/15/2021)](https://spec.openapis.org/oas/v3.1.0)
  * [OpenAPI Specification v3.0.3 (2/2020)](https://spec.openapis.org/oas/v3.0.3)
* [JSON Schema](https://json-schema.org/)
  * [JSON Schema Specification](https://json-schema.org/specification.html)
  * [JSON Schema All Specifications](https://json-schema.org/specification-links.html)
  * [JSON Schema Core Draft 2020-12](https://json-schema.org/draft/2020-12/json-schema-core.html)
    * https://json-schema.org/draft/2020-12/schema
  * [JSON Schema Core Draft 2019-09 / Draft 8](https://datatracker.ietf.org/doc/html/draft-handrews-json-schema-02)
    * $schema = https://json-schema.org/draft/2019-09/schema
  * [JSON Schema Draft 7](https://datatracker.ietf.org/doc/html/draft-handrews-json-schema-01)
    * $schema = http://json-schema.org/draft-07/schema#
  * JSON Schema Draft 6
    * $schema = http://json-schema.org/draft-06/schema#
  * [JSON Schema Draft 4](https://datatracker.ietf.org/doc/html/draft-zyp-json-schema-04)
    * $schema = http://json-schema.org/draft-04/schema#
  * [JSON Hyper Schema Draft 2019-09](https://json-schema.org/draft/2019-09/json-schema-hypermedia.html)
* [JSON Schema Store](https://www.schemastore.org/json/)
* [YAML](https://yaml.org/)
* [YAML Schema]()
* [YAML schema validation](https://json-schema-everywhere.github.io/yaml)
* [Red Hat Visual Studio Code Extension: YAML Language Support](https://github.com/redhat-developer/vscode-yaml)
* [Red Hat YAML Language Server](https://github.com/redhat-developer/yaml-language-server)
* [Editing JSON With Visual Studio Code](https://code.visualstudio.com/docs/languages/json)
* [Schema First API Design](https://yos.io/2018/02/11/schema-first-api-design/)