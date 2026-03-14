return {
  {
    "mfussenegger/nvim-jdtls",
    config = function()
      local jdtls_setup = require("jdtls.setup")
      local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
      local root_dir = jdtls_setup.find_root(root_markers)

      local home = vim.uv.os_homedir()
      local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
      local workspace_dir = home .. "/.cache/jdtls/workspace" .. project_name
      local path_to_mason_packages = home .. "/.local/share/nvim/mason/packages"

      local path_to_jdtls = path_to_mason_packages .. "/jdtls"
      local path_to_jar = path_to_jdtls .. "/plugins/org.eclipse.equinox.launcher_1.7.100.v20251111-0406.jar"

      local path_to_config = path_to_jdtls .. "/config_linux"
      local lombok_path = path_to_jdtls .. "/lombok.jar"


      local path_to_jdebug = path_to_mason_packages .. "/java-debug-adapter"
      local bundles = {
        vim.fn.glob(path_to_jdebug .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
      }

      local path_to_jtest = path_to_mason_packages .. "/java-test"
      vim.list_extend(bundles, vim.split(vim.fn.glob(path_to_jtest .. "/extension/server/*.jar", true), "\n"))


      vim.keymap.set('n', 't<C-j>', function() require'jdtls'.test_class() end, { desc = "Test Java class" })
      ---    create a command that will execute jdtls.test_class() function
      vim.api.nvim_create_user_command('JdtTestClass', function() require'jdtls'.test_class() end, { desc = "Test Java class" })
      vim.api.nvim_create_user_command('JdtTestNearestMethod', function() require'jdtls'.test_nearest_method() end, { desc = "Test nearest Java method" })

      local config = {
          settings = {
            java = {
              configuration = {
                runtimes = {
                  {
                    name = "JavaSE-13",
                    path = "/home/felipe/.sdkman/candidates/java/13.0.1-open",
                  },
                  {
                    name = "JavaSE-17",
                    path = "/home/felipe/.sdkman/candidates/java/17.0.14-zulu"
                  },
                  {
                    name = "JavaSE-21",
                    path = "/home/felipe/.sdkman/candidates/java/21.0.8-zulu"
                  },
                }
              }
            }
          },
          cmd = {
            "java", 
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xmx1g",
            "-javaagent:" .. lombok_path,
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",

            "-jar",
            path_to_jar,
            "-configuration",
            path_to_config,
            "-data",
            workspace_dir,
          },
          init_options = {
            bundles = bundles,
          },
        }
        vim.lsp.config("jdtls", config)
    end
  }
}
