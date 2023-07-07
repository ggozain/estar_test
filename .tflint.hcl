config {
#Enables module inspection
module = true
force = false
}

# Disallow deprecated (0.11-style) interpolation
rule "terraform_deprecated_interpolation" {
enabled = true
}
 
# Disallow legacy dot index syntax.
rule "terraform_deprecated_index" {
enabled = true
}
 
# Disallow variables, data sources, and locals that are declared but never used.
rule "terraform_unused_declarations" {
enabled = true
}
 
# Disallow // comments in favor of #.
rule "terraform_comment_syntax" {
enabled = true
}

plugin "aws" {
    enabled = true
    version = "0.24.1"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}
