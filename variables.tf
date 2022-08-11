variable "name" {
  type    = string
  default = "meetup_ansible"
}

/*
Available flex shapes:
"VM.Optimized3.Flex"  # Intel Ice Lake
"VM.Standard3.Flex"   # Intel Ice Lake
"VM.Standard.A1.Flex" # Ampere Altra
"VM.Standard.E3.Flex" # AMD Rome
"VM.Standard.E4.Flex" # AMD Milan
*/

variable "shape" {
  type    = string
  default = "VM.Optimized3.Flex"
}

variable "how_many_nodes" {
  type    = number
  default = 1
}

variable "display_name" {
  type    = string
  default = "Meetup_Ansible"
}

variable "operating_system" {
  type    = string
  default = "Oracle Linux"
}

variable "operating_system_version" {
  type    = string
  default = "8"
}

variable "availability_domain" {
  type    = number
  default = 0
}

variable "ocpus_per_node" {
  type    = number
  default = 1
}

variable "memory_in_gbs_per_node" {
  type    = number
  default = 2
}
