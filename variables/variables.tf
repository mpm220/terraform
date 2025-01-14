variable "my-ip" {
    description = "an server for something"
    type = object({
        name = string
        description = string
    })
    default = {
        name = "Jim"
        description = "Jim's server"
    }
}