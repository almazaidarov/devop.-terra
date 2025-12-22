output id {
     description = "The ID of the web instance"
     value =  aws_instance.web.id
}

output arn {
     description = "The arn of the web instance"
     value =  aws_instance.web.id
}

output public_ip {
     description = "The public IP of the web instance"
     value =  aws_instance.web.public_ip
}