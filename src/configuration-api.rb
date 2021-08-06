require 'getoptlong'
# Bug in yaml Ruby module - does not handle %YAML prefix
require 'yaml'
require 'json'
require 'erb'
require 'json_schemer'  # Can only handle JSON Schema Draft 4, 6, and 7 - NOT 2019-09 or 2020-12

module ConfigurationApi

    ###################################################################
    #
    ###################################################################
    # TODO: Design configuration object to handle different API versions over time
    class K8sClusterLandscapeConfig
        def initialize
            @k8s_cluster_types = Hash.new
            @virtual_resource_provider = VirtualResourceProvider.new
        end # def initialize

    end # class K8sClusterLandscapeConfig

    ###################################################################
    #
    ###################################################################
    class K8sClusterType
        def initialize
        end # def initialize
    end # class K8sClusterType

    ###################################################################
    #
    ###################################################################
    class VirtualResourceProvider
        def initialize
        end # def initialize
    end # class VirtualResourceProvider

    ###################################################################
    #
    ###################################################################
    class VirtualResourceProviderProgrammingPlatform
        def initialize
        end # def initialize
    end # class VirtualResourceProviderProgrammingPlatform

    ###################################################################
    #
    ###################################################################
    class DeploymentRegions
        def initialize
        end # def initialize
    end # class DeploymentRegions






    ###################################################################
    #
    ###################################################################



    # Method to get configuration data from configuration file
    # TODO:  Check config file for errors against the schema definition
    def get_config_file_content(opts)
        puts "get_config_file_content start" if opts["debug_switch"]

        # Get config file content
        # TODO: check if data is in YAML
        config_file_data_raw = File.open(opts["config_file"]).read
        if opts["debug_switch"]
            puts "===================================="
            puts "Configuration file raw data"
            puts "#{config_file_data_raw}"
            puts "++++++++++++++++++++++++++++++++++++"
        end # if opts["debug_switch"]
        
        config_file_data_yaml_hash = YAML.load(config_file_data_raw)
        if opts["debug_switch"]
            puts "===================================="
            puts "Configuration file data in YAML hash"
            puts "#{config_file_data_yaml_hash}"
            puts "++++++++++++++++++++++++++++++++++++"
        end # if opts["debug_switch"]

        #config_file_data_json = JSON.pretty_generate(config_file_data_yaml)
        config_file_data_json_string = config_file_data_yaml_hash.to_json
        if opts["debug_switch"]
            puts "===================================="
            puts "Configuration file data in JSON string"
            puts "#{config_file_data_json_string}"
            puts "++++++++++++++++++++++++++++++++++++"
        end # if opts["debug_switch"]

        config_file_data_json_hash = JSON.parse(config_file_data_json_string)
        if opts["debug_switch"]
            puts "===================================="
            puts "Configuration file data in JSON hash"
            puts "#{config_file_data_json_hash}"
            puts "++++++++++++++++++++++++++++++++++++"
        end # if opts["debug_switch"]   

        json_schema_raw = File.open(opts["json_schema_file"]).read
        if opts["debug_switch"]
            puts "===================================="
            puts "JSON schema file raw:  #{opts["json_schema_file"]}"
            puts "#{json_schema_raw}"
            puts "++++++++++++++++++++++++++++++++++++"
        end # if opts["debug_switch"]

        json_schema_hash = JSON.parse(json_schema_raw)
        if opts["debug_switch"]
            puts "===================================="
            puts "JSON schema in JSON hash"
            puts "#{json_schema_hash}"
            puts "++++++++++++++++++++++++++++++++++++"
        end # if opts["debug_switch"]
        
        schema = JSONSchemer.schema(json_schema_hash)
        unless schema.valid?(config_file_data_json_hash)
            puts "===================================="
            puts "Configuration data invalid:"
            schema.validate(config_file_data_json_hash).each do |e|
                puts "- error type: #{e["type"]}"
                puts "  schema: #{e['schema']}"
                puts "  schema_pointer: #{e['schema_pointer']}"
                puts "  data: #{e['data']}"
                puts "  data_pointer: #{e['data_pointer']}"
            end # schema.validate
            puts "++++++++++++++++++++++++++++++++++++"
        end # unless schema.valid?

        # TODO:
        return config_file_data_json_hash
    end # def init_config_hash
    module_function :get_config_file_content

    # Convert from API v0.0.1 data object to configuration object
    def init_config_0_0_1(opts, config_hash, config_file_hash)
        puts "init_config_0_0_1 start" if opts["debug_switch"]
        
        config_hash[:debug] = config_file_hash["activation-options"]["debug"]
        config_hash[:deploy_elb] = config_file_hash["activation-options"]["deploy_elb"]
        config_hash[:deploy_edns] = config_file_hash["activation-options"]["deploy_edns"]
        config_hash[:deploy_k8s_master] = config_file_hash["activation-options"]["deploy_k8s_master"]
        config_hash[:deploy_k8s_worker] = config_file_hash["activation-options"]["deploy_k8s_worker"]
        config_hash[:regions] = config_file_hash["k8s-clusters"]["regions"]
        config_hash[:number_of_regions] = config_hash[:regions].size

        # Assuming that a cluster is needed for a separate geographic region  or availability zone
        # Each cluster needs:
        #   - External BGP router / load balancer
        #   - External DNS server
        #   - External TLS certificate authority
        #   - Kubernetes master nodes
        #   - Kubernetes worker nodes
        config_hash[:number_of_elbs_per_region] = config_file_hash["k8s-clusters"]["number_of_elbs_per_region"]
        config_hash[:number_of_ednss_per_region] = config_file_hash["k8s-clusters"]["number_of_ednss_per_region"]
        config_hash[:number_of_clusters_per_region] = config_file_hash["k8s-clusters"]["number_of_clusters_per_region"]
        config_hash[:number_of_azs_per_region] = config_file_hash["k8s-clusters"]["number_of_azs_per_region"]
        config_hash[:number_of_clusters] = config_hash[:number_of_regions] * config_hash[:number_of_clusters_per_region]
        # Master nodes and worker nodes will be in the same subnet
        # Total number of master and worker nodes cannot exceed subnet capacity (including addresses reserved for network services)
        # Distribute nodes across number of AZs
        # Each K8s cluster will use 1 IPv4 class C address range (for this design)
        # Estimate 100 pods per worker node
        config_hash[:k8s_masters_per_cluster] = config_file_hash["k8s-clusters"]["master_nodes_per_cluster"]
        config_hash[:k8s_workers_per_cluster] = config_file_hash["k8s-clusters"]["worker_nodes_per_cluster"]
        config_hash[:number_ip_addresses_reserved_per_cluster] = config_file_hash["k8s-clusters"]["number_ip_addresses_reserved_per_cluster"]

        config_hash[:elb_vm_box] = config_file_hash["elb-vm"]["vagrant-box"]
        config_hash[:elb_vm_disk_size] = "20GB"
        config_hash[:elb_vm_vb_gui] = config_file_hash["elb-vm"]["virtualbox"]["gui"]
        config_hash[:elb_vm_vb_memory] = config_file_hash["elb-vm"]["virtualbox"]["memory"]
        config_hash[:elb_vm_vb_cpus] = config_file_hash["elb-vm"]["virtualbox"]["cpus"]

        config_hash[:edns_vm_box] = config_file_hash["elb-vm"]["vagrant-box"]
        config_hash[:edns_vm_disk_size] = "20GB"
        config_hash[:edns_vm_vb_gui] = config_file_hash["elb-vm"]["virtualbox"]["gui"]
        config_hash[:edns_vm_vb_memory] = config_file_hash["elb-vm"]["virtualbox"]["memory"]
        config_hash[:edns_vm_vb_cpus] = config_file_hash["elb-vm"]["virtualbox"]["cpus"]

        config_hash[:k8s_master_vm_box] = config_file_hash["k8s-master-vm"]["vagrant-box"]
        config_hash[:k8s_master_vm_disk_size] = "20GB"
        config_hash[:k8s_master_vm_vb_gui] = config_file_hash["k8s-master-vm"]["virtualbox"]["gui"]
        config_hash[:k8s_master_vm_vb_memory] = config_file_hash["k8s-master-vm"]["virtualbox"]["memory"]
        config_hash[:k8s_master_vm_vb_cpus] = config_file_hash["k8s-master-vm"]["virtualbox"]["cpus"]

        config_hash[:k8s_worker_vm_box] = config_file_hash["k8s-worker-vm"]["vagrant-box"]
        config_hash[:k8s_worker_vm_disk_size] = "40GB"
        config_hash[:k8s_worker_vm_vb_gui] = config_file_hash["k8s-worker-vm"]["virtualbox"]["gui"]
        config_hash[:k8s_worker_vm_vb_memory] = config_file_hash["k8s-worker-vm"]["virtualbox"]["memory"]
        config_hash[:k8s_worker_vm_vb_cpus] = config_file_hash["k8s-worker-vm"]["virtualbox"]["cpus"]

        puts "init_config_0_0_1 finish" if opts["debug_switch"]
    end # init_config_0_0_1
    module_function :init_config_0_0_1

    # Convert from API v0.1.0 data object to configuration object
    # TODO: Not implemented
    def init_config_0_1_0(opts, config_hash, config_file_hash)
        puts "init_config_0_1_0 start" if opts["debug_switch"]

        # TODO: Add logic to test if hash key exists before accessing sub-key; otherwise,
        # undefined method `[]' for nil:NilClass (NoMethodError)
        # config_hash[:virtual_resource_provider_type] = config_file_hash["virtual_resource_provider"]["type"]
        # config_hash[:virtual_resource_deployment_programming_platform_type] = config_file_hash["virtual_resource_provider_programming_platform"]["type"]
        # config_hash[:debug] = config_file_hash["activation-options"]["debug"]
        # config_hash[:deploy_elb] = config_file_hash["activation-options"]["deploy_elb"]
        # config_hash[:deploy_edns] = config_file_hash["activation-options"]["deploy_edns"]
        # config_hash[:deploy_k8s_master] = config_file_hash["activation-options"]["deploy_k8s_master"]
        # config_hash[:deploy_k8s_worker] = config_file_hash["activation-options"]["deploy_k8s_worker"]
        # config_hash[:regions] = config_file_hash["k8s-clusters"]["regions"]
        # config_hash[:number_of_regions] = config_hash[:regions].size

        # Assuming that a cluster is needed for a separate geographic region  or availability zone
        # Each cluster needs:
        #   - External BGP router / load balancer
        #   - External DNS server
        #   - External TLS certificate authority
        #   - Kubernetes master nodes
        #   - Kubernetes worker nodes
        # config_hash[:number_of_elbs_per_region] = config_file_hash["k8s-clusters"]["number_of_elbs_per_region"]
        # config_hash[:number_of_ednss_per_region] = config_file_hash["k8s-clusters"]["number_of_ednss_per_region"]
        # config_hash[:number_of_clusters_per_region] = config_file_hash["k8s-clusters"]["number_of_clusters_per_region"]
        # config_hash[:number_of_azs_per_region] = config_file_hash["k8s-clusters"]["number_of_azs_per_region"]
        # config_hash[:number_of_clusters] = config_hash[:number_of_regions] * config_hash[:number_of_clusters_per_region]
        # Master nodes and worker nodes will be in the same subnet
        # Total number of master and worker nodes cannot exceed subnet capacity (including addresses reserved for network services)
        # Distribute nodes across number of AZs
        # Each K8s cluster will use 1 IPv4 class C address range (for this design)
        # Estimate 100 pods per worker node
        # config_hash[:k8s_masters_per_cluster] = config_file_hash["k8s-clusters"]["master_nodes_per_cluster"]
        # config_hash[:k8s_workers_per_cluster] = config_file_hash["k8s-clusters"]["worker_nodes_per_cluster"]
        # config_hash[:number_ip_addresses_reserved_per_cluster] = config_file_hash["k8s-clusters"]["number_ip_addresses_reserved_per_cluster"]

        # config_hash[:elb_vm_box] = config_file_hash["elb-vm"]["vagrant-box"]
        # config_hash[:elb_vm_disk_size] = "20GB"
        # config_hash[:elb_vm_vb_gui] = config_file_hash["elb-vm"]["virtualbox"]["gui"]
        # config_hash[:elb_vm_vb_memory] = config_file_hash["elb-vm"]["virtualbox"]["memory"]
        # config_hash[:elb_vm_vb_cpus] = config_file_hash["elb-vm"]["virtualbox"]["cpus"]

        # config_hash[:edns_vm_box] = config_file_hash["elb-vm"]["vagrant-box"]
        # config_hash[:edns_vm_disk_size] = "20GB"
        # config_hash[:edns_vm_vb_gui] = config_file_hash["elb-vm"]["virtualbox"]["gui"]
        # config_hash[:edns_vm_vb_memory] = config_file_hash["elb-vm"]["virtualbox"]["memory"]
        # config_hash[:edns_vm_vb_cpus] = config_file_hash["elb-vm"]["virtualbox"]["cpus"]

        # config_hash[:k8s_master_vm_box] = config_file_hash["k8s-master-vm"]["vagrant-box"]
        # config_hash[:k8s_master_vm_disk_size] = "20GB"
        # config_hash[:k8s_master_vm_vb_gui] = config_file_hash["k8s-master-vm"]["virtualbox"]["gui"]
        # config_hash[:k8s_master_vm_vb_memory] = config_file_hash["k8s-master-vm"]["virtualbox"]["memory"]
        # config_hash[:k8s_master_vm_vb_cpus] = config_file_hash["k8s-master-vm"]["virtualbox"]["cpus"]

        # config_hash[:k8s_worker_vm_box] = config_file_hash["k8s-worker-vm"]["vagrant-box"]
        # config_hash[:k8s_worker_vm_disk_size] = "40GB"
        # config_hash[:k8s_worker_vm_vb_gui] = config_file_hash["k8s-worker-vm"]["virtualbox"]["gui"]
        # config_hash[:k8s_worker_vm_vb_memory] = config_file_hash["k8s-worker-vm"]["virtualbox"]["memory"]
        # config_hash[:k8s_worker_vm_vb_cpus] = config_file_hash["k8s-worker-vm"]["virtualbox"]["cpus"]

        puts "init_config_0_1_0 finish" if opts["debug_switch"]
    end # init_config_0_1_0
    module_function :init_config_0_1_0


    

    ###########################################
    # PUBLIC FUNCTIONS
    ###########################################

    def ConfigurationApi.get_opts

        opts_hash = Hash.new

        opts = GetoptLong.new(
            [ '--config-file', GetoptLong::REQUIRED_ARGUMENT],
            [ '--schema-file', GetoptLong::REQUIRED_ARGUMENT],
            [ '--debug', GetoptLong::OPTIONAL_ARGUMENT],

            # Vagrant options
            [ '-h', GetoptLong::OPTIONAL_ARGUMENT],
            [ '--help', GetoptLong::OPTIONAL_ARGUMENT],
            [ '--no-color', GetoptLong::OPTIONAL_ARGUMENT],
            [ '--color', GetoptLong::OPTIONAL_ARGUMENT],
            [ '-v', GetoptLong::OPTIONAL_ARGUMENT],
            [ '--version', GetoptLong::OPTIONAL_ARGUMENT],
            [ '--timestamp', GetoptLong::OPTIONAL_ARGUMENT],
            [ '--debug-timestamp', GetoptLong::OPTIONAL_ARGUMENT],
            [ '--no-tty', GetoptLong::OPTIONAL_ARGUMENT],

            # vagrant up options
            [ '--no-provision', GetoptLong::OPTIONAL_ARGUMENT],
            [ '--provision-with', GetoptLong::OPTIONAL_ARGUMENT],
            [ '--no-destroy-on-error', GetoptLong::OPTIONAL_ARGUMENT],
            [ '--destroy-on-error', GetoptLong::OPTIONAL_ARGUMENT],
            [ '--no-parallel', GetoptLong::OPTIONAL_ARGUMENT],
            [ '--parallel', GetoptLong::OPTIONAL_ARGUMENT],
            [ '--provider', GetoptLong::OPTIONAL_ARGUMENT],
            [ '--no-install-provider', GetoptLong::OPTIONAL_ARGUMENT],
            [ '--install-provider', GetoptLong::OPTIONAL_ARGUMENT],

            # vagrant destroy options
            [ '-f', GetoptLong::OPTIONAL_ARGUMENT],
            [ '--force', GetoptLong::OPTIONAL_ARGUMENT],
            [ '-g', GetoptLong::OPTIONAL_ARGUMENT],
            [ '--graceful', GetoptLong::OPTIONAL_ARGUMENT],
            [ '--machine-readable', GetoptLong::OPTIONAL_ARGUMENT]
        )
        
        # Get config file from command line 
        opts.each do |opt, arg|
            puts "Option #{opt} = #{arg}"
            case opt
            when '--config-file'
                opts_hash["config_file"] = arg
            when '--schema-file'
                opts_hash["json_schema_file"] = arg
            when '--debug'
                opts_hash["debug_switch"] = true if arg != "false"
            end # case opt
        end # opts.each

        if opts_hash["config_file"] == ''
            # Default config file is located with Vagrantfile and named config.yaml
            puts "No config-file specified...using default configuration file config.yaml"
            opts_hash["config_file"] = 'config.yaml'
            
            if ! File.file?(opts_hash["config_file"])
                puts "No config.yaml file exist"
                exit 1
            end
        end # if config_file

        if opts_hash["json_schema_file"] == ''
            # Assume default schema file is located in directory as main program and named schema.yaml
            puts "No schema-file specified...using default schema file schema.yaml"
            opts_hash["json_schema_file"] = 'schema.json'
            
            if ! File.file?(opts_hash["json_schema_file"])
                puts "No schema.json file exist"
                exit 1
            end
        end # if schema_file

        return opts_hash
    end


    # Initialize application configuration object from API configuration file object
    def ConfigurationApi.init_cfg(opts)
        puts "ConfigureAPI.init_cfg start" if opts["debug_switch"]

        config_hash = Hash.new
        config_file_hash = get_config_file_content(opts)
        
        # Get API version
        config_api_version = config_file_hash["api_version"]
        if config_api_version == nil
            puts "Cannot determine api_version"
            exit 1
        else
            puts "Configuration file uses api-version #{config_api_version}"
        end # if config_api_version

        # Handle different API versions
        case config_api_version
        when 'v0.0.1'
            init_config_0_0_1(opts, config_hash, config_file_hash)
        when 'v0.1.0'
            init_config_0_1_0(opts, config_hash, config_file_hash)
        else
            puts "Unsupported API version #{config_api_version}"
            exit 1
        end

        puts "ConfigureAPI.init_cfg finish" if opts["debug_switch"]
        return config_hash
    end # def ConfigureAPI.init_cfg
end # module ConfigureAPI