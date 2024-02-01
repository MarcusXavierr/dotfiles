local dap = require('dap')

dap.adapters.php = {
  type = "executable",
  command = "php-debug-adapter", -- Installed with Mason 🤙😎🤙
}

dap.configurations.php = {
  {
    type = "php",
    request = "launch",
    name = "Listen for Xdebug",
    port = 9000, -- Change this when using other port on Dockerfile
    pathMappings = {
      ["/var/www/app"] = "${workspaceFolder}" -- Change this when using other workdir on Dockerfile
    }
  }
}
