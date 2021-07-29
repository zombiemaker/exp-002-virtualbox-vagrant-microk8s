module ConfigureAPI
    # Method to get configuration data from configuration file
    def get_config_file_content(opts)
        puts "get_config_file_content start"

        # Initialize variable for optional parameters
        config_file = ''

        # # BUG: Need to handle vagrant options
        # opts = GetoptLong.new(
        #     [ '--config-file', GetoptLong::OPTIONAL_ARGUMENT]
        # )

        # Get config file from command line 
        opts.each do |opt, arg|
            case opt
            when '--config-file'
                config_file = arg
            end # case opt
        end # opts.each

        if config_file == ''
            # Default config file is located with Vagrantfile and named config.yaml
            puts "No config-file specified...using default configuration file config.yaml"
            config_file = 'config.yaml'
            
            if ! File.file?(config_file)
                puts "No config.yaml file exist"
                exit 1
            end
        end # if config_file

        # Get config file content
        config_file_yaml = File.open(config_file).read
        config_file_hash = YAML.load( ERB.new(config_file_yaml).result)

        return config_file_hash

    end # def init_config_hash
    module_function :get_config_file_content

    # Convert from API v0.0.1 data object to configuration object
    def init_config_0_0_1(config_hash, config_file_hash)
        puts "init_config_0_0_1 start"
        
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

        puts "init_config_0_0_1 finish"
    end # init_config_0_0_1
    module_function :init_config_0_0_1


    # Convert from API v0.0.1 data object to configuration object
    def init_config_0_1_0(config_hash, config_file_hash)
        puts "init_config_0_1_0 start"
    end # init_config_0_1_0
    module_function :init_config_0_1_0


    # Initialize application configuration object from API configuration file object
    def ConfigureAPI.init_cfg(config_hash, opts)
        puts "ConfigureAPI.init_cfg start"

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
            init_config_0_0_1(config_hash, config_file_hash)
        when 'v0.1.0'
            init_config_0_1_0(config_hash, config_file_hash)
        else
            puts "Unsupported API version #{config_api_version}"
            exit 1
        end
        puts "ConfigureAPI.init_cfg finish"
    end # def ConfigureAPI.init_cfg
end # module ConfigureAPI