# AWS CLI Layer For AWS Lambda (KAI)

Use AWS CLI in AWS Lambda (KAI).

## Usage

### Requirements

* jq
* aws cli v2
* zip
* tar

### Deployment

1. Prepared these
    *  Install awscli-v2 
    * `aws configure` finished
1. How to use
   * `sh setup.sh project_name stage_name`
     * **one time only**
       * build a zip for lambda-layer (Required: `Linux` and `x86_64`)
       * build a zip for lambda-function.
       * create S3 bucket for lambda-layer setup
       * create role and attach policies for lambda-function
       * create lambda-layer for awscli v2
       * create lambda-function
   * `sh deploy.sh project_name stage_name`
     * **Can be executed many times**
     * (re)build a zip for lambda-function.
     * and deploy lambda-function
   * Special
     * `070.add_policy_to_role.sh role_name` you can add new policy to lambda-role
