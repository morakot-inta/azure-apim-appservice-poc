include "root" {
    path = find_in_parent_folders("root.hcl")
}
terraform {
    source = "../../../terraform//appservice"
}

dependencies {
    paths = [
        "../apim",
    ]
}

dependency "apim" {
    config_path = "../apim"
}

inputs ={
    resource_group_name = dependency.apim.outputs.resource_group_name
}