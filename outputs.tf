output "url" {
  value = "https://${aws_instance.proxy.public_ip}.nip.io"
}
