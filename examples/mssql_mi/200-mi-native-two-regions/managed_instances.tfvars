mssql_managed_instances = {
  sqlmi1 = {
    version = "v1"
    resource_group = {
      key = "sqlmi_region1"
    }
    name                = "sqlmi1"
    administrator_login = "adminuser"
    #administrator_login_password = "@dm1nu53r@30102020"
    ## if password not set, a random complex password will be created and stored in the keyvault
    ## the secret value can be changed after the deployment if needed
    ## When administrator_login_password use the following keyvault to store the password

    authentication_mode = "hybrid"
    # "aad_only", "hybrid"
    administrators = {
      # Set the group explicitly with object id (sid)
      # principal_type              = "Group"
      # sid                         = "000000-6c31-485e-a7d4-5b927171bd99"
      # login                       = "AAD DC Administrators"
      # tenant_id                    = "00000-ee35-4265-95f6-46e9a9b4ec96"

      # group key or existing group OID or upn supported
      azuread_group_key = "sql_mi_admins"
      login_username    = "AAD DC Administrators"
      # azuread_group_id   = "<specify existing azuread group's Object Id (OID) here>"

    }
    keyvault = {
      key = "sqlmi_rg1"
    }
    license_type        = "BasePrice" #BasePrice (Hybrid Benefit) or LicenseIncluded (Pay-As-You-Go)
    minimal_tls_version = "1.2"
    //networking
    networking = {
      vnet_key   = "sqlmi_region1"
      subnet_key = "sqlmi1"
    }
    proxy_override = "Default" #"Default,Proxy,Redirect"   #terraform sets the value to redirect if not set.
    identity = {
      type                  = "UserAssigned"
      managed_identity_keys = ["mi1"]

    }
    public_data_endpoint_enabled = false
    sku = {
      name = "GP_Gen5"
    }
    backup_storage_redundancy = "GRS" #
    storage_size_in_gb        = 32
    vcores                    = 4
    transparent_data_encryption = {
      enabled = true
    }

    #     private_endpoints = {
    #   # Require enforce_private_link_endpoint_network_policies set to true on the subnet
    #   private-link-level4 = {
    #     name       = "sqlmi1-pe"
    #     vnet_key   = "sqlmi_region1"
    #     subnet_key = "sqlmi1pe"
    #     #subnet_id          = "/subscriptions/97958dac-f75b-4ee3-9a07-9f436fa73bd4/resourceGroups/ppga-rg-sql-rg1/providers/Microsoft.Network/virtualNetworks/ppga-vnet-testvnet1/subnets/ppga-snet-web-subnet"
    #     resource_group_key = "sqlmi_region1"

    #     private_service_connection = {
    #       name                 = "sales-sql-rg1"
    #       is_manual_connection = false
    #       subresource_names    = ["managedInstance"]
    #     }

    #     # private_dns = {
    #     #   zone_group_name = "privatelink_database_windows_net" 
    #     #   # lz_key          = ""   # If the DNS keys are deployed in a remote landingzone 
    #     #   keys = ["privatelink"]
    #     # }
    #   }
    # }

  }
}

# private_dns = {
#   privatelink = {
#     name               = "privatelink.07f1a81e4b95.database.windows.net"
#     resource_group_key = "sqlmi_region1"

#     vnet_links = {
#       sqlmi-pe-link = {
#         name     = "sqlmi-pe-link"
#         #lz_key   = "launchpad"
#         vnet_key = "sqlmi_region1"
#       }
#     }
#   }
# }