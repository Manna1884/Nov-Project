output "lb_dns_url" {
  description = "dns of webserver load balancer"
  value = aws_lb.webserver_alb.dns_name
}





