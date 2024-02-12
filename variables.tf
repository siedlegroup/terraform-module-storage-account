variable "project" {
  type        = string
  description = "Global project name as prefix and other naming and tagging functions."
  validation {
    error_message = "Error: Global project name can't be empty."
    condition     = var.project != ""
  }
}

variable "location" {
  type        = string
  description = "Azure Location (region) to create resources in."
  validation {
    error_message = "Error: Azure cloud location for resources should be germanywestcentral"
    condition     = var.location == "germanywestcentral"
  }
}

variable "environment" {
  type        = string
  description = "Environment (stage) to assign resources for."
  validation {
    error_message = "Error: Environment can't be empty."
    condition     = var.environment != ""
  }
}

variable "postfix" {
  type        = string
  description = "Suffix definition providing predictable resource names"
}

variable "subscription_id" {
  type        = string
  description = "Subscription ID for this account in the resource group"
}

variable "storage_account_name" {
  type        = string
  description = "Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed."
  validation {
    error_message = "Error: Only lowercase Alphanumeric characters (min: 3, max: 24) allowed for storage accounts."
    condition     = can(regex("^[a-zA-Z0-9]{3,24}$", var.storage_account_name))
  }
}

variable "storage_account_prefix" {
  type        = string
  description = "String to prefix storage account related resource names, depending on use case."
}

variable "storage_account_kind" {
  type        = string
  description = "Defines the kind of storage for this storage accounts"
  default     = ""
  validation {
    error_message = "Error: Kind for storage accounts can only BlobStorage, BlockBlobStorage, FileStorage or StorageV2 (default)."
    condition     = contains(["BlobStorage", "BlockBlobStorage", "FileStorage", "StorageV2"], var.storage_account_kind)
  }
}

variable "storage_account_tier" {
  type        = string
  description = "Account tier to use this storage account"
  default     = ""
  validation {
    error_message = "Error: Account tier for storage accounts can only be Standard or Premium."
    condition     = contains(["Standard", "Premium"], var.storage_account_tier)
  }
}

variable "storage_access_tier" {
  type        = string
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts."
  default     = ""
  validation {
    error_message = "Error: Access tier for storage accounts can only be Hot (default) or Cool."
    condition     = contains(["Hot", "Cold"], var.storage_access_tier)
  }
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account."
  default     = ""
  validation {
    error_message = "Error: Valid replication types are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.account_replication_type)
  }
}

variable "resource_group_name" {
  type        = string
  description = "Name of resource group to add the storage account to."
  validation {
    error_message = "Error: The resource group name must be defined."
    condition     = var.resource_group_name != ""
  }
}

variable "dns_zone_resource_group" {
  type        = string
  description = "Name of resource group with the DNS zone to create records in"
  validation {
    error_message = "Error: The resource group name must be defined."
    condition     = var.dns_zone_resource_group != ""
  }
}

variable "vnet_id" {
  type        = string
  description = "Virtual network ID in use"
  validation {
    error_message = "Error: The vnet id must be provided."
    condition     = var.vnet_id != ""
  }
}

variable "vnet_subnet_ids" {
  type        = map(string)
  description = "A list of resource ids for subnets that can access the storage account."
  validation {
    error_message = "Error: The list vnet subnet ids must be defined."
    condition     = var.vnet_subnet_ids != {}
  }
}

variable "shared_subnet_ids" {
  type        = list(string)
  description = "List ob subnet IDs of shared vnet to add to the storage account network acl"
  validation {
    error_message = "Error: The list shared subnet ids must be defined."
    condition     = var.shared_subnet_ids != []
  }
}

variable "private_dns_zone_name" {
  type        = string
  description = "Name of private dns zone to add A record of storage endpoint."
  validation {
    error_message = "Error: The private dns zone name must be defined."
    condition     = var.private_dns_zone_name != ""
  }
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Enable public network access to this storage account."
  default     = false
  validation {
    error_message = "Error: Public network access must be enabled or disabled."
    condition     = var.public_network_access_enabled == true || var.public_network_access_enabled == false
  }
}

variable "allow_nested_items_to_be_public" {
  type        = bool
  description = "Allow or disallow nested items within this Account to opt into being public."
  default     = false
  validation {
    error_message = "Error: Public network access must be enabled or disabled."
    condition     = var.allow_nested_items_to_be_public == true || var.allow_nested_items_to_be_public == false
  }
}

variable "cross_tenant_replication_enabled" {
  type        = bool
  description = "Should cross Tenant replication be enabled? "
  default     = false
  validation {
    error_message = "Error: Cross tenant replication must be set to true or false."
    condition     = var.cross_tenant_replication_enabled == true || var.cross_tenant_replication_enabled == false
  }
}

variable "shared_access_key_enabled" {
  type        = bool
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key."
  default     = true
  validation {
    error_message = "Error: Shared access key permission must be set to false or true."
    condition     = var.shared_access_key_enabled == true || var.shared_access_key_enabled == false
  }
}

variable "infrastructure_encryption_enabled" {
  type        = bool
  description = "Is infrastructure encryption enabled?"
  default     = true
  validation {
    error_message = "Error: Infrastructure encryption must be set to false or true. Change this if using customer managed key."
    condition     = var.infrastructure_encryption_enabled == true || var.infrastructure_encryption_enabled == false
  }
}

variable "min_tls_version" {
  type        = string
  description = "The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2"
  default     = "TLS1_2"
  validation {
    error_message = "Error: The minimum supported TLS version for the storage account. We should only use TLS1_2."
    condition     = var.min_tls_version == "TLS1_2"
  }
}

variable "key_vault_id" {
  type        = string
  description = "Name of Key Vault to store customer managed storage encryption key in."
}

variable "managed_identity_ids" {
  type        = string
  description = "Specifies a list of User Assigned Managed Identity IDs to be assigned to this Storage Account."
  default     = ""
}

variable "devops_object_id" {
  type        = string
  description = "Entra ID object ID of the DevOps group to enable for Key Vault access."
}

variable "tags" {
  type        = map(string)
  description = "Map of key/value pairs added to tag the storage account."
  default     = {}
}

variable "private_link_endpoint_enabled" {
  type        = bool
  description = "Toggle private link endpoint creation for the storage account"
  default     = false
}

variable "cmk_lifetime_in_hours" {
  type        = number
  description = "Validity for customer managed key in hours, e.g. 1 year = 8760"
  default     = 8760
}
