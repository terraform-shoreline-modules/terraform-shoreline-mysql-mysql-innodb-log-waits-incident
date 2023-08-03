resource "shoreline_notebook" "mysql_innodb_log_waits_incident" {
  name       = "mysql_innodb_log_waits_incident"
  data       = file("${path.module}/data/mysql_innodb_log_waits_incident.json")
  depends_on = [shoreline_action.invoke_update_log_buffer,shoreline_action.invoke_resource_allocation]
}

resource "shoreline_file" "update_log_buffer" {
  name             = "update_log_buffer"
  input_file       = "${path.module}/data/update_log_buffer.sh"
  md5              = filemd5("${path.module}/data/update_log_buffer.sh")
  description      = "If the buffer section is found, update the buffer size"
  destination_path = "/agent/scripts/update_log_buffer.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "resource_allocation" {
  name             = "resource_allocation"
  input_file       = "${path.module}/data/resource_allocation.sh"
  md5              = filemd5("${path.module}/data/resource_allocation.sh")
  description      = "Tune the server settings to allocate more resources to the database and reduce contention for system resources."
  destination_path = "/agent/scripts/resource_allocation.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_update_log_buffer" {
  name        = "invoke_update_log_buffer"
  description = "If the buffer section is found, update the buffer size"
  command     = "`chmod +x /agent/scripts/update_log_buffer.sh && /agent/scripts/update_log_buffer.sh`"
  params      = []
  file_deps   = ["update_log_buffer"]
  enabled     = true
  depends_on  = [shoreline_file.update_log_buffer]
}

resource "shoreline_action" "invoke_resource_allocation" {
  name        = "invoke_resource_allocation"
  description = "Tune the server settings to allocate more resources to the database and reduce contention for system resources."
  command     = "`chmod +x /agent/scripts/resource_allocation.sh && /agent/scripts/resource_allocation.sh`"
  params      = []
  file_deps   = ["resource_allocation"]
  enabled     = true
  depends_on  = [shoreline_file.resource_allocation]
}

