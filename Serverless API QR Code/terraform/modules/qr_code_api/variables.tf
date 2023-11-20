variable "name_api" {
  description = "Name for the API"
}

variable "path_swagger" {
  description = "Path to the swagger file"
}

variable "path_base" {
  description = "Path to the folder that contains the lambda codes"
}

variable "endpoints" {
    description = "Lambda mapping with the path_base"
    type        = list (
                    object({
                      endpoint_name = string
                      layers        = list(string)
                      timeout       = number
                    }
                  )
                )
}