let

  region = "eu-west-1c";
  securityGroups = [ "secure_group" "default"];
  accessKeyId = "dev"; # symbolic name looked up in ~/.ec2-keys
#  networking.firewall.allowedTCPPorts = [21 80 2003 10051 3000 8080];


  ec2 =
    { resources, ... }:
    { deployment.targetEnv = "ec2";
      deployment.ec2.accessKeyId = accessKeyId;
      deployment.ec2.region = region;
      deployment.ec2.instanceType = "t1.micro";
#      deployment.ec2.securityGroupIds = [ "secure_group" ];
      deployment.ec2.keyPair = resources.ec2KeyPairs.my-key-pair;
      ec2.hvm = true;
    };
    
in
{ 

  nixos = ec2;

  # Provision an EC2 key pair.
  resources.ec2KeyPairs.my-key-pair =
    { inherit region accessKeyId; };
}
